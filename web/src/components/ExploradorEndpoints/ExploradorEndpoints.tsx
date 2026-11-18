"use client";

import { useRef, useState } from "react";
import styles from "./ExploradorEndpoints.module.css";

type Rota = { rota: string; desc: string };
type Grupo = { titulo: string; rotas: Rota[] };

const EXEMPLOS: [RegExp, string][] = [
  [/\{habilidadeId\}/g, "15281"],
  [/\{ocupacaoId\}/g, "482"],
  [/\{grupoId\}/g, "154"],
  [/\{viewId\}/g, "1"],
  [/\{codigo\}/g, "PROG"],
  [/\{slug\}/g, "comunicacao"],
  [/\{hard\|soft\}/g, "soft"],
  [/\{termo\}/g, "dados"],
  [/\{id\}/g, "482"],
];

function caminhoExemplo(rota: string) {
  let caminho = rota.replace(/^GET\s+/, "");
  for (const [token, valor] of EXEMPLOS) caminho = caminho.replace(token, valor);
  caminho = caminho.replace("classificacao=hard|soft", "classificacao=soft");
  if (caminho.includes("/classificacao/") && !caminho.includes("?")) {
    caminho += "?limite=24&pagina=1";
  }
  return caminho;
}

function normalizar(entrada: string) {
  let caminho = entrada.trim();
  if (!caminho) return "";
  if (/^https?:\/\//i.test(caminho)) {
    try {
      const url = new URL(caminho);
      caminho = `${url.pathname}${url.search}`;
    } catch {
      return "";
    }
  }
  if (!caminho.startsWith("/")) caminho = `/${caminho}`;
  return caminho;
}

export default function ExploradorEndpoints({ grupos }: { grupos: Grupo[] }) {
  const [selecionada, setSelecionada] = useState<Rota | null>(null);
  const [caminho, setCaminho] = useState("");
  const [resposta, setResposta] = useState("");
  const [status, setStatus] = useState<number | null>(null);
  const [carregando, setCarregando] = useState(false);
  const [erro, setErro] = useState("");
  const painelRef = useRef<HTMLElement>(null);

  async function enviar(bruto: string) {
    const caminho = normalizar(bruto);
    if (!caminho) return;

    setCaminho(caminho);
    setCarregando(true);
    setErro("");
    setResposta("");
    setStatus(null);

    try {
      const inicio = performance.now();
      const r = await fetch(`/api/docs${caminho}`, {
        headers: { accept: "application/json" },
        cache: "no-store",
      });
      const texto = await r.text();
      const duracao = Math.round(performance.now() - inicio);

      let corpo = texto;
      try {
        corpo = JSON.stringify(JSON.parse(texto), null, 2);
      } catch {
        corpo = texto;
      }

      setStatus(r.status);
      setResposta(`${corpo}\n\n// ${duracao} ms`);
      if (!r.ok) setErro(`A API respondeu ${r.status}.`);
    } catch {
      setErro("Não foi possível falar com a API. Verifique se o servidor está no ar.");
    } finally {
      setCarregando(false);
    }
  }

  function abrir(rota: Rota) {
    const exemplo = caminhoExemplo(rota.rota);
    setSelecionada(rota);
    setResposta("");
    setStatus(null);
    setErro("");
    requestAnimationFrame(() => {
      painelRef.current?.scrollIntoView({ block: "nearest" });
    });
    void enviar(exemplo);
  }

  function fechar() {
    setSelecionada(null);
    setCaminho("");
    setResposta("");
    setStatus(null);
    setErro("");
  }

  return (
    <div className={styles.explorador} data-aberto={selecionada ? "true" : "false"}>
      <div className={styles.lista}>
        {grupos.map((g) => (
          <div key={g.titulo} className={styles.grupoRotas}>
            <h3 className={styles.grupoTitulo}>{g.titulo}</h3>
            <ul className={styles.rotas}>
              {g.rotas.map((r) => {
                const ativa = selecionada?.rota === r.rota;
                return (
                  <li key={r.rota}>
                    <button
                      type="button"
                      className={`${styles.rota} ${ativa ? styles.rotaAtiva : ""}`}
                      onClick={() => abrir(r)}
                      aria-expanded={ativa}
                      aria-controls="explorador-resposta"
                    >
                      <code>{r.rota}</code>
                      <span>{r.desc}</span>
                    </button>
                  </li>
                );
              })}
            </ul>
          </div>
        ))}
      </div>

      {selecionada && (
        <aside
          className={styles.painel}
          id="explorador-resposta"
          ref={painelRef}
          aria-label="Testar endpoint"
        >
          <div className={styles.painelTopo}>
            <div>
              <span className="rotulo">testar endpoint</span>
              <p className={styles.endpoint}>{selecionada.rota}</p>
            </div>
            <button type="button" className={styles.fechar} onClick={fechar} aria-label="Fechar painel">
              ×
            </button>
          </div>

          <form
            className={styles.form}
            onSubmit={(e) => {
              e.preventDefault();
              void enviar(caminho);
            }}
          >
            <label htmlFor="caminho-endpoint" className={styles.rotuloCampo}>
              caminho da requisição
            </label>
            <div className={styles.campo}>
              <span className={styles.metodo}>GET</span>
              <input
                id="caminho-endpoint"
                value={caminho}
                onChange={(e) => setCaminho(e.target.value)}
                spellCheck={false}
                autoComplete="off"
                aria-label="Caminho da requisição"
              />
              <button type="submit" className={styles.enviar} disabled={carregando}>
                {carregando ? "…" : "Enviar"}
              </button>
            </div>
            <span className={styles.dica}>
              Edite o caminho e os parâmetros; a resposta vem da API ao vivo.
            </span>
          </form>

          <div className={styles.respostaCabeca}>
            <span className="rotulo">resposta</span>
            <span className={styles.statusLinha}>
              {status !== null && (
                <span className={`${styles.status} ${status >= 200 && status < 300 ? styles.ok : styles.falha}`}>
                  {status}
                </span>
              )}
              {carregando && <span className={styles.carregando}>consultando…</span>}
            </span>
          </div>

          {erro && <p className={styles.erro}>{erro}</p>}

          <pre className={styles.codigo} aria-live="polite">
            <code>{resposta || (carregando ? "…" : "// envie a requisição para ver o JSON")}</code>
          </pre>
        </aside>
      )}
    </div>
  );
}
