using System.Diagnostics;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Text.Json;

namespace RBOSF.Tests;

internal static class Program
{
    private const string Base = "rbosfapi/v1";

    private static readonly Dictionary<string, long> Esperado = new()
    {
        ["grupos"] = 619,
        ["ocupacoes"] = 3071,
        ["ocupacoes_esco"] = 3036,
        ["ocupacoes_mercado"] = 35,
        ["habilidades"] = 15221,
        ["relacoes_oh"] = 173226,
        ["hierarquias_h"] = 21566,
        ["colecoes"] = 7,
    };

    private static readonly Stopwatch T0 = Stopwatch.StartNew();
    private static readonly List<(string Nome, double Segundos)> Fases = new();

    private static void Log(string msg) =>
        Console.WriteLine($"[{T0.Elapsed.TotalSeconds,7:F1}s] {msg}");

    private static void Fase(string nome, double segundos)
    {
        Fases.Add((nome, segundos));
        Log($"{nome}: {segundos:F1}s");
    }

    private static string Repo { get; set; } = "";
    private static string Tmp { get; set; } = "";
    private static string Container { get; set; } = "";
    private static bool ManterArtefatos { get; set; }

    private static async Task<int> Main(string[] args)
    {
        try { Console.OutputEncoding = Encoding.UTF8; } catch { /* não-tty */ }

        string imagem = "postgres:latest";
        int? pgPorta = null, apiPorta = null;
        bool semIdempotencia = false;

        for (int i = 0; i < args.Length; i++)
        {
            switch (args[i])
            {
                case "--imagem": imagem = args[++i]; break;
                case "--pg-porta": pgPorta = int.Parse(args[++i]); break;
                case "--api-porta": apiPorta = int.Parse(args[++i]); break;
                case "--sem-idempotencia": semIdempotencia = true; break;
                case "--manter-artefatos": ManterArtefatos = true; break;
                default:
                    Console.Error.WriteLine($"Argumento desconhecido: {args[i]}");
                    return 2;
            }
        }

        if (Which("docker") is null) { Console.Error.WriteLine("ERRO: docker não encontrado no PATH"); return 2; }
        if (Which("dotnet") is null) { Console.Error.WriteLine("ERRO: dotnet não encontrado no PATH (necessário .NET 10)"); return 2; }

        Repo = LocalizarRepo();
        Tmp = Path.Combine(Path.GetTempPath(), "rbosf_api_tests_" + Guid.NewGuid().ToString("N")[..8]);
        Directory.CreateDirectory(Tmp);
        Container = $"rbosf-api-tests-{Environment.ProcessId}";
        bool imagemPreCarregada = imagem.StartsWith("rbosf-db");

        int pgPortaFinal = pgPorta ?? PortaLivre();
        int apiPortaFinal = apiPorta ?? PortaLivre();

        Process? api = null;
        int falhas;
        try
        {
            // 1. subir Postgres
            Log($"Subindo {imagem} em 127.0.0.1:{pgPortaFinal} (container {Container})");
            var t = Stopwatch.StartNew();
            Executar("docker", "run", "--rm", "-d", "--name", Container,
                "-e", "POSTGRES_PASSWORD=postgres",
                "-p", $"127.0.0.1:{pgPortaFinal}:5432",
                "-v", $"{Repo}:/workspace", imagem);
            EsperarContainer(Container);
            Fase("Postgres pronto", t.Elapsed.TotalSeconds);

            var contagens = AguardarEValidarCarga(imagemPreCarregada, semIdempotencia);

            // 4. publicar API
            var publishDir = Path.Combine(Tmp, "publish");
            t.Restart();
            Log("Publicando API (dotnet publish -c Release)...");
            var (rc, saida) = Executar("dotnet", "publish", Path.Combine(Repo, "server", "RBOSF_API"),
                "-c", "Release", "-o", publishDir, "--nologo");
            File.WriteAllText(Path.Combine(Tmp, "log_publish.txt"), saida);
            if (rc != 0) throw new Exception($"ERRO no dotnet publish; log: {Tmp}/log_publish.txt");
            Fase("dotnet publish", t.Elapsed.TotalSeconds);

            // 5. .env + start
            File.WriteAllText(Path.Combine(publishDir, ".env"),
                $"DefaultConnection=\"Host=127.0.0.1;Port={pgPortaFinal};Database=rbosf_db;Username=postgres;Password=postgres\"\n");

            t.Restart();
            Log($"Iniciando API em http://127.0.0.1:{apiPortaFinal}");
            api = IniciarApi(publishDir, apiPortaFinal);
            using var http = new HttpClient(new HttpClientHandler { Proxy = null, UseProxy = false })
                { Timeout = TimeSpan.FromSeconds(300) };
            EsperarApiPronta(api, http, apiPortaFinal);
            Fase("API boot + readiness", t.Elapsed.TotalSeconds);
            Log($"API pronta em http://127.0.0.1:{apiPortaFinal}");

            // 6. suíte
            PortaApi = apiPortaFinal;
            var ctx = new Ctx(http);
            var resultados = new List<Resultado>();
            foreach (var (nome, teste) in Casos)
            {
                var res = new Resultado(nome);
                t.Restart();
                try { await teste(ctx, res); }
                catch (Exception e) { res.Falha($"exceção: {e.GetType().Name}: {e.Message}"); }
                res.DuracaoMs = t.Elapsed.TotalMilliseconds;
                resultados.Add(res);
                var marcador = res.Status switch { "OK" => "✓", "AVISO" => "!", _ => "✗" };
                Log($"{marcador} {nome} ({res.DuracaoMs:F0}ms) {Truncar(res.Detalhe, 70)}");
            }

            // 7. relatório
            falhas = ImprimirResultados(resultados, contagens);
        }
        catch (Exception e)
        {
            Console.Error.WriteLine($"\nERRO FATAL: {e.Message}");
            falhas = -1;
        }
        finally
        {
            if (api is { HasExited: false })
            {
                try { api.Kill(entireProcessTree: true); api.WaitForExit(10000); } catch { /* já morto */ }
            }
            Executar("docker", "rm", "-f", Container);
            if (!ManterArtefatos)
            {
                try { Directory.Delete(Tmp, recursive: true); } catch { /* inexistente */ }
            }
            else
            {
                Console.WriteLine($"\nArtefatos mantidos em: {Tmp}");
            }
        }

        return falhas > 0 ? 1 : 0;
    }

    // ------------------------------------------------------------------
    // Infra
    // ------------------------------------------------------------------

    private static Dictionary<string, long> AguardarEValidarCarga(bool imagemPreCarregada, bool semIdempotencia)
    {
        if (imagemPreCarregada)
        {
            Log("Imagem pré-carregada (rbosf-db): pulando carga SQL e idempotência");
        }
        else
        {
            var t = Stopwatch.StartNew();
            Log("Aplicando esco_database_create.sql");
            PsqlArquivo(Path.Combine(Repo, "script", "CREATE", "esco_database_create.sql"), "postgres", "log_create.sql");
            Fase("CREATE (schema base)", t.Elapsed.TotalSeconds);

            t.Restart();
            Log("Aplicando esco_database_refactor.sql");
            PsqlArquivo(Path.Combine(Repo, "script", "CREATE", "esco_database_refactor.sql"), "rbosf_db", "log_refactor.sql");
            Fase("CREATE (tabelas de vínculo)", t.Elapsed.TotalSeconds);

            t.Restart();
            Log("Aplicando esco_db_refatorado.sql (carga completa)...");
            PsqlArquivo(Path.Combine(Repo, "script", "INSERTs", "esco_db_refatorado.sql"), "rbosf_db", "log_insert.sql");
            Fase("INSERT (carga completa)", t.Elapsed.TotalSeconds);
        }

        Log("Validando contagens da carga");
        var cnt = imagemPreCarregada ? EsperarContagensPreCarregada() : Contagens();
        var divergentes = Esperado.Where(kv => cnt.TryGetValue(kv.Key, out var v) && v != kv.Value)
            .ToDictionary(kv => kv.Key, kv => (cnt[kv.Key], kv.Value));
        if (divergentes.Count > 0)
            throw new Exception($"ERRO: contagens divergentes do esperado: {Formatar(divergentes)}");
        Log($"Contagens OK: {Formatar(cnt)}");

        if (!imagemPreCarregada && !semIdempotencia)
        {
            var antes = new Dictionary<string, long>(cnt);
            var t = Stopwatch.StartNew();
            Log("Reexecutando carga para validar idempotência...");
            PsqlArquivo(Path.Combine(Repo, "script", "INSERTs", "esco_db_refatorado.sql"), "rbosf_db", "log_insert2.sql");
            Fase("INSERT (idempotência)", t.Elapsed.TotalSeconds);
            var cnt2 = Contagens();
            if (!cnt2.DictionaryEquals(antes))
                throw new Exception($"ERRO: carga não idempotente.\nantes={Formatar(antes)}\ndepois={Formatar(cnt2)}");
            Log("Idempotência OK (contagens idênticas)");
        }
        return cnt;
    }

    private static Dictionary<string, long> EsperarContagensPreCarregada(int timeoutS = 300)
    {
        // A imagem rbosf-db executa a carga no primeiro start do container;
        // pg_isready pode responder antes de os scripts initdb terminarem.
        var deadline = DateTime.UtcNow.AddSeconds(timeoutS);
        while (DateTime.UtcNow < deadline)
        {
            try
            {
                var cnt = Contagens();
                if (!Esperado.Any(kv => cnt.TryGetValue(kv.Key, out var v) && v != kv.Value))
                    return cnt;
            }
            catch { /* carga ainda inicializando */ }
            Thread.Sleep(2000);
        }
        throw new Exception($"Contagens da imagem pré-carregada não validaram em {timeoutS}s");
    }

    private static string LocalizarRepo()
    {
        var dir = new DirectoryInfo(AppContext.BaseDirectory);
        while (dir is not null)
        {
            if (File.Exists(Path.Combine(dir.FullName, "script", "INSERTs", "esco_db_refatorado.sql")))
                return dir.FullName;
            dir = dir.Parent!;
        }
        throw new Exception("Raiz do repositório não encontrada (procurando script/INSERTs/esco_db_refatorado.sql)");
    }

    private static string? Which(string cmd)
    {
        var caminhos = (Environment.GetEnvironmentVariable("PATH") ?? "")
            .Split(':', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries);
        return caminhos.Select(p => Path.Combine(p, cmd)).FirstOrDefault(File.Exists);
    }

    private static int PortaLivre()
    {
        var listener = new TcpListener(IPAddress.Loopback, 0);
        listener.Start();
        try { return ((IPEndPoint)listener.LocalEndpoint).Port; }
        finally { listener.Stop(); }
    }

    private static (int Codigo, string Saida) Executar(params string[] cmd)
    {
        var psi = new ProcessStartInfo { FileName = cmd[0], RedirectStandardOutput = true, RedirectStandardError = true, UseShellExecute = false };
        foreach (var a in cmd.Skip(1)) psi.ArgumentList.Add(a);
        using var p = Process.Start(psi)!;
        var saida = p.StandardOutput.ReadToEnd() + p.StandardError.ReadToEnd();
        p.WaitForExit();
        return (p.ExitCode, saida);
    }

    private static void EsperarContainer(string nome, int timeoutS = 90)
    {
        // pg_isready responde 0 já no servidor temporário do initdb (entrada docker);
        // só é seguro aplicar SQL após "PostgreSQL init process complete".
        var deadline = DateTime.UtcNow.AddSeconds(timeoutS);
        while (DateTime.UtcNow < deadline)
        {
            var (_, logs) = Executar("docker", "logs", nome);
            if (logs.Contains("PostgreSQL init process complete"))
            {
                var (rc, _) = Executar("docker", "exec", nome, "pg_isready", "-U", "postgres");
                if (rc == 0) return;
            }
            Thread.Sleep(1000);
        }
        throw new Exception($"Postgres de teste não ficou pronto em {timeoutS}s");
    }

    private static void PsqlArquivo(string caminhoHost, string db, string nomeLog)
    {
        var relativo = Path.GetRelativePath(Repo, caminhoHost).Replace('\\', '/');
        var (rc, saida) = Executar("docker", "exec", Container, "psql", "-U", "postgres", "-d", db,
            "-v", "ON_ERROR_STOP=1", "-f", $"/workspace/{relativo}");
        File.WriteAllText(Path.Combine(Tmp, nomeLog), saida);
        if (rc != 0)
            throw new Exception($"SQL falhou ({Path.GetFileName(caminhoHost)}) com código {rc}; log: {Tmp}/{nomeLog}\nÚltimas linhas:\n{saida[^Math.Min(saida.Length, 2000)..]}");
    }

    private static Dictionary<string, long> Contagens()
    {
        const string sql = """
            SELECT 'grupos', count(*) FROM esco_dataset.grupo_ocupacao
            UNION ALL SELECT 'ocupacoes', count(*) FROM esco_dataset.ocupacao
            UNION ALL SELECT 'ocupacoes_esco', count(*) FROM esco_dataset.ocupacao
              WHERE uri LIKE 'http://data.europa.eu/esco/occupation/%'
            UNION ALL SELECT 'ocupacoes_mercado', count(*) FROM esco_dataset.ocupacao
              WHERE uri LIKE 'https://nexthire.local/esco/occupation/%'
            UNION ALL SELECT 'habilidades', count(*) FROM esco_dataset.habilidade
            UNION ALL SELECT 'relacoes_oh', count(*) FROM esco_dataset.ocupacao_habilidade
            UNION ALL SELECT 'hierarquias_h', count(*) FROM esco_dataset.hierarquia_habilidade
            UNION ALL SELECT 'colecoes', count(*) FROM esco_dataset.colecao
            """;
        var (rc, saida) = Executar("docker", "exec", Container, "psql", "-U", "postgres",
            "-d", "rbosf_db", "-At", "-v", "ON_ERROR_STOP=1", "-c", sql);
        if (rc != 0) throw new Exception($"psql falhou: {Truncar(saida, 500)}");
        return saida.Split('\n', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries)
            .Select(l => l.Split('|'))
            .ToDictionary(p => p[0], p => long.Parse(p[1]));
    }

    private static Process IniciarApi(string publishDir, int porta)
    {
        var psi = new ProcessStartInfo
        {
            FileName = "dotnet",
            Arguments = "RBOSF_API.dll",
            WorkingDirectory = publishDir,
            UseShellExecute = false,
            RedirectStandardOutput = true,
        };
        psi.Environment["ASPNETCORE_ENVIRONMENT"] = "Development";
        psi.Environment["ASPNETCORE_URLS"] = $"http://127.0.0.1:{porta}";
        var logApi = new FileStream(Path.Combine(Tmp, "log_api.txt"), FileMode.Create, FileAccess.Write, FileShare.Read);
        var p = Process.Start(psi)!;
        _ = Task.Run(() =>
        {
            var buffer = new byte[4096];
            int n;
            while ((n = p.StandardOutput.BaseStream.Read(buffer, 0, buffer.Length)) > 0) logApi.Write(buffer, 0, n);
            logApi.Close();
        });
        return p;
    }

    private static void EsperarApiPronta(Process api, HttpClient http, int porta)
    {
        var deadline = DateTime.UtcNow.AddSeconds(120);
        while (true)
        {
            if (api.HasExited)
                throw new Exception($"ERRO: API morreu no boot; log: {Tmp}/log_api.txt");
            try
            {
                var resp = http.GetAsync($"http://127.0.0.1:{porta}/{Base}/metadados/status").GetAwaiter().GetResult();
                if ((int)resp.StatusCode == 200) return;
            }
            catch { /* ainda não pronta */ }
            if (DateTime.UtcNow > deadline)
                throw new Exception($"ERRO: API não respondeu em 120s; log: {Tmp}/log_api.txt");
            Thread.Sleep(1000);
        }
    }

    // ------------------------------------------------------------------
    // Casos de teste
    // ------------------------------------------------------------------

    private sealed class Ctx
    {
        public Ctx(HttpClient http) => Http = http;
        public HttpClient Http { get; }
        public long GrupoId { get; set; }
        public long FullstackId { get; set; }
        public long FullstackGrupo { get; set; }
        public long DockerId { get; set; }
    }

    private sealed class Resultado
    {
        public Resultado(string nome) => Nome = nome;
        public string Nome { get; }
        public string Status { get; set; } = "OK";
        public double DuracaoMs { get; set; }
        public long Bytes { get; set; }
        public int? HttpStatus { get; set; }
        public string Detalhe { get; set; } = "";

        public void Falha(string msg) { Status = "FALHA"; Detalhe = msg; }
        public void Aviso(string msg) { Status = "AVISO"; Detalhe = msg; }
        public bool Ok(bool condicao, string msgOk, string msgErro)
        {
            if (condicao) { Detalhe = msgOk; return true; }
            Falha(msgErro);
            return false;
        }
    }

    private static async Task<(int Status, JsonDocument? Json, long Bytes)> GetJsonAsync(HttpClient http, string path)
    {
        var resp = await http.GetAsync($"http://127.0.0.1:{PortaApi}/{path.TrimStart('/')}");
        var bytes = await resp.Content.ReadAsByteArrayAsync();
        JsonDocument? json = null;
        try { json = JsonDocument.Parse(bytes); } catch { /* corpo não é JSON */ }
        return ((int)resp.StatusCode, json, bytes.LongLength);
    }

    private static async Task<(int Status, long Bytes)> GetAsync(HttpClient http, string path)
    {
        var resp = await http.GetAsync($"http://127.0.0.1:{PortaApi}/{path.TrimStart('/')}");
        var bytes = await resp.Content.ReadAsByteArrayAsync();
        return ((int)resp.StatusCode, bytes.LongLength);
    }

    private static int PortaApi { get; set; }

    private static List<JsonElement> Lista(JsonDocument? d) =>
        d?.RootElement.ValueKind == JsonValueKind.Array ? d.RootElement.EnumerateArray().ToList() : new();

    private static string? Str(JsonElement e, string prop) =>
        e.TryGetProperty(prop, out var v) && v.ValueKind == JsonValueKind.String ? v.GetString() : null;

    private static long? Num(JsonElement e, string prop) =>
        e.TryGetProperty(prop, out var v) && v.ValueKind == JsonValueKind.Number ? v.GetInt64() : null;

    private static List<string>? StrList(JsonElement e, string prop) =>
        e.TryGetProperty(prop, out var v) && v.ValueKind == JsonValueKind.Array
            ? v.EnumerateArray().Select(x => x.GetString() ?? "").ToList()
            : null;

    private static bool EqLista(List<string> lista, params string[] esperado) =>
        lista.Count == esperado.Length && lista.Zip(esperado, (a, b) => a == b).All(x => x);

    private static string Truncar(string s, int n) => s.Length <= n ? s : s[..n];

    private static (string Nome, Func<Ctx, Resultado, Task> Teste) Caso(string nome, Func<Ctx, Resultado, Task> t) => (nome, t);

    private static async Task TestarMetadados(Ctx ctx, Resultado res)
    {
        var (s, d, bytes) = await GetJsonAsync(ctx.Http, $"{Base}/metadados/status");
        res.HttpStatus = s; res.Bytes = bytes;
        var status = d is null ? new List<string>() : d.RootElement.EnumerateArray().Select(x => x.GetString() ?? "").ToList();
        if (!res.Ok(s == 200 && EqLista(status, "released", "deprecated"),
                "released/deprecated", $"status={s}, corpo={Truncar(d?.RootElement.ToString() ?? "-", 100)}"))
            return;

        var r2 = await GetJsonAsync(ctx.Http, $"{Base}/metadados/tipo-habilidade");
        var r3 = await GetJsonAsync(ctx.Http, $"{Base}/metadados/tipo-conceito");
        var r4 = await GetJsonAsync(ctx.Http, $"{Base}/metadados/reutilizacao");
        var r5 = await GetJsonAsync(ctx.Http, $"{Base}/metadados/tipo-relacionamento");
        List<string> Arr((int Status, JsonDocument? Json, long Bytes) r) =>
            r.Json is null ? new() : r.Json.RootElement.EnumerateArray().Select(x => x.GetString() ?? "").ToList();
        var l2 = Arr(r2); var l3 = Arr(r3); var l4 = Arr(r4); var l5 = Arr(r5);
        bool ok2 = r2.Status == 200 && EqLista(l2, "conhecimento", "competencia") &&
                   r3.Status == 200 && EqLista(l3, "habilidade", "grupo_habilidade") &&
                   r4.Status == 200 && l4.Count == 4 &&
                   r5.Status == 200 && EqLista(l5, "essencial", "opcional");
        res.Ok(ok2, "5 endpoints de metadados OK", $"tipos: [{string.Join(',', l2)}]/[{string.Join(',', l3)}]/[{string.Join(',', l4)}]/[{string.Join(',', l5)}]");
    }

    private static async Task TestarColecaoListar(Ctx ctx, Resultado res)
    {
        var (s, d, bytes) = await GetJsonAsync(ctx.Http, $"{Base}/colecao");
        res.HttpStatus = s; res.Bytes = bytes;
        var lista = Lista(d);
        var nomes = lista.Select(i => Str(i, "nome")).ToHashSet();
        res.Ok(s == 200 && lista.Count == 7 && nomes.Contains("Competências digitais") && nomes.Contains("Ocupações de investigação"),
            $"{lista.Count} coleções", $"status={s}, itens={(d is null ? "corpo inválido" : lista.Count.ToString())}");
    }

    private static async Task TestarColecaoTermo(Ctx ctx, Resultado res)
    {
        var (s, d, bytes) = await GetJsonAsync(ctx.Http, $"{Base}/colecao/termo/digitais");
        res.HttpStatus = s; res.Bytes = bytes;
        var lista = Lista(d);
        res.Ok(s == 200 && lista.Count >= 1, $"{lista.Count} resultado(s)", $"status={s}, corpo={Truncar(d?.RootElement.ToString() ?? "-", 200)}");
    }

    private static async Task TestarGrupoListar(Ctx ctx, Resultado res)
    {
        var (s, d, bytes) = await GetJsonAsync(ctx.Http, $"{Base}/grupoOcupacao");
        res.HttpStatus = s; res.Bytes = bytes;
        var lista = Lista(d);
        res.Ok(s == 200 && lista.Count == Esperado["grupos"], $"{lista.Count} grupos", $"status={s}, itens={(d is null ? "corpo inválido" : lista.Count.ToString())}");
    }

    private static async Task TestarGrupoTermo(Ctx ctx, Resultado res)
    {
        var (s, d, bytes) = await GetJsonAsync(ctx.Http, $"{Base}/grupoOcupacao/termo/software");
        res.HttpStatus = s; res.Bytes = bytes;
        var lista = Lista(d);
        var alvo = lista.FirstOrDefault(g => Str(g, "codigo") == "2512");
        if (!res.Ok(s == 200 && alvo.ValueKind != JsonValueKind.Undefined,
                alvo.ValueKind != JsonValueKind.Undefined ? $"{lista.Count} resultado(s); 2512 '{Str(alvo, "nome")}'" : "alvo não achado",
                $"status={s}, itens={(d is null ? "corpo inválido" : lista.Count.ToString())}"))
            return;
        ctx.GrupoId = Num(alvo, "grupoId") ?? 0;
    }

    private static async Task TestarGrupoPorId(Ctx ctx, Resultado res)
    {
        var (s, d, bytes) = await GetJsonAsync(ctx.Http, $"{Base}/grupoOcupacao/{ctx.GrupoId}");
        res.HttpStatus = s; res.Bytes = bytes;
        var codigo = d is null ? null : Str(d.RootElement, "codigo");
        var nome = d is null ? null : Str(d.RootElement, "nome");
        res.Ok(s == 200 && codigo == "2512" && !string.IsNullOrEmpty(nome),
            $"2512 '{nome}'", $"status={s}, corpo={Truncar(d?.RootElement.ToString() ?? "-", 200)}");
    }

    private static async Task TestarOcupacaoListar(Ctx ctx, Resultado res)
    {
        var (s, d, bytes) = await GetJsonAsync(ctx.Http, $"{Base}/ocupacao");
        res.HttpStatus = s; res.Bytes = bytes;
        var lista = Lista(d);
        var semGrupo = lista.Count(o => string.IsNullOrEmpty(Str(o, "nomeGrupoOcupacao")));
        res.Ok(s == 200 && lista.Count == Esperado["ocupacoes"] && semGrupo == 0,
            $"{lista.Count} ocupações, todas com grupo",
            $"status={s}, itens={(d is null ? "corpo inválido" : lista.Count.ToString())}, sem_grupo={semGrupo}");
    }

    private static async Task TestarOcupacaoTermoFullstack(Ctx ctx, Resultado res)
    {
        var (s, d, bytes) = await GetJsonAsync(ctx.Http, $"{Base}/ocupacao/termo/full-stack");
        res.HttpStatus = s; res.Bytes = bytes;
        var lista = Lista(d);
        var alvo = lista.FirstOrDefault(o => Str(o, "titulo") == "Desenvolvedor Full-stack");
        if (!res.Ok(s == 200 && alvo.ValueKind != JsonValueKind.Undefined,
                alvo.ValueKind != JsonValueKind.Undefined ? $"{lista.Count} resultado(s); ocupacao_id={Num(alvo, "ocupacaoId")}" : "alvo não achado",
                $"status={s}, itens={(d is null ? "corpo inválido" : lista.Count.ToString())}"))
            return;
        ctx.FullstackId = Num(alvo, "ocupacaoId") ?? 0;
        ctx.FullstackGrupo = Num(alvo, "grupoOcupacaoId") ?? 0;
    }

    private static async Task TestarOcupacaoTermoDevops(Ctx ctx, Resultado res)
    {
        var (s, d, bytes) = await GetJsonAsync(ctx.Http, $"{Base}/ocupacao/termo/devops");
        res.HttpStatus = s; res.Bytes = bytes;
        var lista = Lista(d);
        var tem = lista.Any(o => Str(o, "titulo") == "Engenheiro DevOps");
        res.Ok(s == 200 && tem, $"{lista.Count} resultado(s), 'Engenheiro DevOps' presente",
            $"status={s}, itens={(d is null ? "corpo inválido" : lista.Count.ToString())}");
    }

    private static async Task TestarOcupacaoPorId(Ctx ctx, Resultado res)
    {
        var (s, d, bytes) = await GetJsonAsync(ctx.Http, $"{Base}/ocupacao/{ctx.FullstackId}");
        res.HttpStatus = s; res.Bytes = bytes;
        var raiz = d?.RootElement;
        var titulo = raiz is null || raiz.Value.ValueKind != JsonValueKind.Object ? null : Str(raiz.Value, "titulo");
        var grupo = raiz is null || raiz.Value.ValueKind != JsonValueKind.Object ? null : Num(raiz.Value, "grupoOcupacaoId");
        var alt = raiz is null || raiz.Value.ValueKind != JsonValueKind.Object ? null : StrList(raiz.Value, "nomesAlternativos");
        var altDesc = alt is null ? (raiz?.ValueKind == JsonValueKind.Object ? "null" : "?") : "array";
        res.Ok(s == 200 && titulo == "Desenvolvedor Full-stack" && grupo == ctx.FullstackGrupo && (alt is null || alt.Count >= 0),
            $"Full-stack no grupo {grupo}; altNames={altDesc}",
            $"status={s}, corpo={Truncar(d?.RootElement.ToString() ?? "-", 300)}");
    }

    private static async Task TestarOcupacaoPorGrupo(Ctx ctx, Resultado res)
    {
        var (s, d, bytes) = await GetJsonAsync(ctx.Http, $"{Base}/ocupacao/grupo/{ctx.FullstackGrupo}");
        res.HttpStatus = s; res.Bytes = bytes;
        var lista = Lista(d);
        bool ok = s == 200 && lista.Count >= 1;
        if (!res.Ok(ok, $"{lista.Count} ocupações no grupo 2512",
                $"status={s}, itens={(d is null ? "corpo inválido" : lista.Count.ToString())}"))
        {
            if (s == 200 && lista.Count == 0)
                res.Detalhe = "BUG provável: GrupoOcupacaoRepository.ListarPorGrupo usa grupo.Ocupacao sem Include/lazy load -> lista vazia";
            return;
        }
        var ids = lista.Select(o => Num(o, "ocupacaoId")).ToHashSet();
        res.Ok(ids.Contains(ctx.FullstackId), "Full-stack presente no retorno do grupo", "Full-stack ausente no grupo");
    }

    private static async Task TestarOcupacaoHabilidades(Ctx ctx, Resultado res)
    {
        var (s, d, bytes) = await GetJsonAsync(ctx.Http, $"{Base}/ocupacao/ocupacaoId/{ctx.FullstackId}/habilidades");
        res.HttpStatus = s; res.Bytes = bytes;
        var lista = Lista(d);
        var nomes = lista.Select(h => Str(h, "nome")).ToHashSet();
        string[] esperadas = ["Docker", "Git", "GitHub", "GraphQL", "Kubernetes", "LGPD", "Node.js", "React", "Terraform"];
        var inter = esperadas.Where(nomes.Contains).OrderBy(x => x).ToList();
        res.Ok(s == 200 && lista.Count >= 100 && inter.Count >= 5,
            $"{lista.Count} habilidades; novas: [{string.Join(", ", inter)}]",
            $"status={s}, itens={(d is null ? "corpo inválido" : lista.Count.ToString())}, novas=[{string.Join(", ", inter)}]");
    }

    private static async Task TestarHabilidadeListar(Ctx ctx, Resultado res)
    {
        var (s, d, bytes) = await GetJsonAsync(ctx.Http, $"{Base}/habilidade");
        res.HttpStatus = s; res.Bytes = bytes;
        var lista = Lista(d);
        res.Ok(s == 200 && lista.Count == Esperado["habilidades"], $"{lista.Count} habilidades", $"status={s}, itens={(d is null ? "corpo inválido" : lista.Count.ToString())}");
    }

    private static async Task TestarHabilidadeTermoDocker(Ctx ctx, Resultado res)
    {
        var (s, d, bytes) = await GetJsonAsync(ctx.Http, $"{Base}/habilidade/termo/docker");
        res.HttpStatus = s; res.Bytes = bytes;
        var lista = Lista(d);
        var alvo = lista.FirstOrDefault(h => Str(h, "nome") == "Docker");
        if (!res.Ok(s == 200 && alvo.ValueKind != JsonValueKind.Undefined,
                alvo.ValueKind != JsonValueKind.Undefined ? $"{lista.Count} resultado(s); habilidade_id={Num(alvo, "habilidadeId")}" : "alvo não achado",
                $"status={s}, itens={(d is null ? "corpo inválido" : lista.Count.ToString())}"))
            return;
        ctx.DockerId = Num(alvo, "habilidadeId") ?? 0;
    }

    private static async Task TestarHabilidadeTermoLgpd(Ctx ctx, Resultado res)
    {
        var (s, d, bytes) = await GetJsonAsync(ctx.Http, $"{Base}/habilidade/termo/lgpd");
        res.HttpStatus = s; res.Bytes = bytes;
        var lista = Lista(d);
        var tem = lista.Any(h => Str(h, "nome") == "LGPD");
        res.Ok(s == 200 && tem, $"{lista.Count} resultado(s), 'LGPD' presente",
            $"status={s}, itens={(d is null ? "corpo inválido" : lista.Count.ToString())}");
    }

    private static async Task TestarHabilidadePorId(Ctx ctx, Resultado res)
    {
        var (s, d, bytes) = await GetJsonAsync(ctx.Http, $"{Base}/habilidade/{ctx.DockerId}");
        res.HttpStatus = s; res.Bytes = bytes;
        var raiz = d?.RootElement;
        var nome = raiz is null || raiz.Value.ValueKind != JsonValueKind.Object ? null : Str(raiz.Value, "nome");
        var tipo = raiz is null || raiz.Value.ValueKind != JsonValueKind.Object ? null : Str(raiz.Value, "tipoConceito");
        var descricao = raiz is null || raiz.Value.ValueKind != JsonValueKind.Object ? null : Str(raiz.Value, "descricao");
        var alt = raiz is null || raiz.Value.ValueKind != JsonValueKind.Object ? null : StrList(raiz.Value, "nomesAlternativos");
        var altDesc = alt is null ? (raiz?.ValueKind == JsonValueKind.Object ? "null" : "?") : "array";
        var id = d is not null ? Num(d.RootElement, "habilidadeId") : null;
        res.Ok(s == 200 && nome == "Docker" && tipo == "habilidade" && !string.IsNullOrEmpty(descricao),
            $"Docker id={id}; altNames={altDesc}",
            $"status={s}, corpo={Truncar(d?.RootElement.ToString() ?? "-", 300)}");
    }

    private static async Task Testar404Ocupacao(Ctx ctx, Resultado res)
    {
        var (s, bytes) = await GetAsync(ctx.Http, $"{Base}/ocupacao/999999999");
        res.HttpStatus = s; res.Bytes = bytes;
        res.Ok(s == 404, "404 com mensagem", $"status={s}");
    }

    private static async Task Testar404Habilidade(Ctx ctx, Resultado res)
    {
        var (s, bytes) = await GetAsync(ctx.Http, $"{Base}/habilidade/999999999");
        res.HttpStatus = s; res.Bytes = bytes;
        res.Ok(s == 404, "404 com mensagem", $"status={s}");
    }

    private static async Task Testar404Grupo(Ctx ctx, Resultado res)
    {
        var (s, bytes) = await GetAsync(ctx.Http, $"{Base}/grupoOcupacao/999999999");
        res.HttpStatus = s; res.Bytes = bytes;
        res.Ok(s == 404, "404 com mensagem", $"status={s}");
    }

    private static async Task Testar404Colecao(Ctx ctx, Resultado res)
    {
        var (s, bytes) = await GetAsync(ctx.Http, $"{Base}/colecao/999999999");
        res.HttpStatus = s; res.Bytes = bytes;
        res.Ok(s == 404, "404 com mensagem", $"status={s}");
    }

    private static async Task TestarBuscaSemResultado(Ctx ctx, Resultado res)
    {
        var (s, d, bytes) = await GetJsonAsync(ctx.Http, $"{Base}/ocupacao/termo/zzzqqqxxxzzz");
        res.HttpStatus = s; res.Bytes = bytes;
        var lista = Lista(d);
        if (s == 200 && lista.Count == 0)
            res.Aviso("Retorna 200 [] para busca sem resultado (inconsistente com 404 por id)");
        else if (s == 200 && lista.Count > 0)
            res.Falha($"Busca sem sentido retornou {lista.Count} itens");
        else
            res.Detalhe = $"status={s} (404), comportamento 404";
    }

    private static async Task TestarBuscaSemTermo(Ctx ctx, Resultado res)
    {
        var (s, bytes) = await GetAsync(ctx.Http, $"{Base}/ocupacao/termo/");
        res.HttpStatus = s; res.Bytes = bytes;
        res.Ok(s is 404 or 200, $"status={s}", $"status inesperado {s}");
    }

    private static readonly (string, Func<Ctx, Resultado, Task>)[] Casos =
    [
        Caso("Metadados | 5 endpoints", TestarMetadados),
        Caso("Coleção | listar", TestarColecaoListar),
        Caso("Coleção | termo digitais", TestarColecaoTermo),
        Caso("Grupo | listar (619)", TestarGrupoListar),
        Caso("Grupo | termo software", TestarGrupoTermo),
        Caso("Grupo | por id 2512", TestarGrupoPorId),
        Caso("Ocupação | listar (3071)", TestarOcupacaoListar),
        Caso("Ocupação | termo full-stack", TestarOcupacaoTermoFullstack),
        Caso("Ocupação | termo devops", TestarOcupacaoTermoDevops),
        Caso("Ocupação | por id Full-stack", TestarOcupacaoPorId),
        Caso("Ocupação | por grupo 2512", TestarOcupacaoPorGrupo),
        Caso("Ocupação | habilidades Full-stack", TestarOcupacaoHabilidades),
        Caso("Habilidade | listar (15221)", TestarHabilidadeListar),
        Caso("Habilidade | termo docker", TestarHabilidadeTermoDocker),
        Caso("Habilidade | termo lgpd", TestarHabilidadeTermoLgpd),
        Caso("Habilidade | por id Docker", TestarHabilidadePorId),
        Caso("404 | ocupação inexistente", Testar404Ocupacao),
        Caso("404 | habilidade inexistente", Testar404Habilidade),
        Caso("404 | grupo inexistente", Testar404Grupo),
        Caso("404 | coleção inexistente", Testar404Colecao),
        Caso("Busca | termo sem resultado", TestarBuscaSemResultado),
        Caso("Busca | termo vazio", TestarBuscaSemTermo),
    ];

    // Nota: a suíte usa campos estáticos (PortaApi) configurados antes da execução;
    // Casos.Todos expõe a lista para o Main.
    private static (string, Func<Ctx, Resultado, Task>)[] Todos => Casos;

    // ------------------------------------------------------------------
    // Relatório
    // ------------------------------------------------------------------

    private static int ImprimirResultados(List<Resultado> resultados, Dictionary<string, long> contagens)
    {
        Console.WriteLine();
        Console.WriteLine(new string('=', 100));
        Console.WriteLine("RESULTADOS DOS TESTES");
        Console.WriteLine(new string('=', 100));
        Console.WriteLine($"{"TESTE",-44} {"STATUS",-7} {"HTTP",5} {"TEMPO(ms)",10} {"PAYLOAD",9}  DETALHE");
        int nOk = 0, nAvisos = 0, nFalhas = 0;
        foreach (var r in resultados)
        {
            Console.WriteLine($"{Truncar(r.Nome, 44),-44} {r.Status,-7} {(r.HttpStatus?.ToString() ?? "-"),5} {r.DuracaoMs,10:F0} {r.Bytes / 1024.0,8:F1}KB  {Truncar(r.Detalhe, 60)}");
            switch (r.Status)
            {
                case "OK": nOk++; break;
                case "AVISO": nAvisos++; break;
                default: nFalhas++; break;
            }
        }
        Console.WriteLine(new string('-', 100));
        Console.WriteLine($"OK={nOk}  AVISOS={nAvisos}  FALHAS={nFalhas}");

        Console.WriteLine();
        Console.WriteLine(new string('=', 100));
        Console.WriteLine("FASES DE INFRA (tempo)");
        Console.WriteLine(new string('=', 100));
        foreach (var (nome, seg) in Fases)
            Console.WriteLine($"  {nome,-48} {seg,7:F1}s");

        Console.WriteLine();
        Console.WriteLine(new string('=', 100));
        Console.WriteLine("INSIGHTS DE PERFORMANCE (top 8 por tempo)");
        Console.WriteLine(new string('=', 100));
        foreach (var r in resultados.OrderByDescending(r => r.DuracaoMs).Take(8))
            Console.WriteLine($"  {Truncar(r.Nome, 44),-44} {r.DuracaoMs,9:F0}ms  {r.Bytes / 1024.0,8:F1}KB");
        Console.WriteLine();
        Console.WriteLine("INSIGHTS DE PAYLOAD (top 5 por tamanho)");
        foreach (var r in resultados.OrderByDescending(r => r.Bytes).Take(5))
            Console.WriteLine($"  {Truncar(r.Nome, 44),-44} {r.Bytes / 1024.0,9:F1}KB");

        var problemas = resultados.Where(r => r.Status is "FALHA" or "AVISO").ToList();
        if (problemas.Count > 0)
        {
            Console.WriteLine();
            Console.WriteLine(new string('=', 100));
            Console.WriteLine("PONTOS DE ATENÇÃO (para o backlog da API)");
            Console.WriteLine(new string('=', 100));
            foreach (var r in problemas)
                Console.WriteLine($"  [{r.Status}] {r.Nome}: {r.Detalhe}");
        }
        Console.WriteLine(new string('=', 100));
        return nFalhas;
    }

    private static string Formatar(Dictionary<string, long> d) =>
        "{" + string.Join(", ", d.Select(kv => $"'{kv.Key}': {kv.Value}")) + "}";

    private static string Formatar(Dictionary<string, (long Real, long Esperado)> d) =>
        "{" + string.Join(", ", d.Select(kv => $"'{kv.Key}': real={kv.Value.Real}, esperado={kv.Value.Esperado}")) + "}";
}

internal static class DictionaryExtensions
{
    public static bool DictionaryEquals<TKey, TValue>(this IReadOnlyDictionary<TKey, TValue> a, IReadOnlyDictionary<TKey, TValue> b)
        where TKey : notnull
        => a.Count == b.Count && a.All(kv => b.TryGetValue(kv.Key, out var v) && EqualityComparer<TValue>.Default.Equals(v, kv.Value));
}
