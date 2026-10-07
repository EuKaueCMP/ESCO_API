using CsvHelper;
using CsvHelper.Configuration;
using System.Globalization;
using System.IO;
using System.Text.Encodings.Web;
using System.Text.Json;

public static class Conversions
{
    public static void ConvertCsvToJson(string caminhoCSV, string caminhoJSON)
    {
        var config = new CsvConfiguration(CultureInfo.InvariantCulture)
        {
            HasHeaderRecord = false,
            Mode = CsvMode.RFC4180,
            TrimOptions = TrimOptions.Trim,
        };

        using var reader = new StreamReader(caminhoCSV);
        using var csv = new CsvReader(reader, config);

        // Lê a primeira linha como headers
        csv.Read();
        int colCount = csv.Parser.Count;  // ← número de campos na linha atual
        var headers = new string[colCount];
        for (int i = 0; i < colCount; i++)
            headers[i] = csv.GetField(i);

        var result = new List<Dictionary<string, string>>();

        while (csv.Read())
        {
            var row = new Dictionary<string, string>();
            for (int i = 0; i < colCount; i++)
            {
                var value = csv.GetField(i) ?? "";
                row[headers[i]] = value.Replace("\n", "; ").Replace("\r", "");
            }
            result.Add(row);
        }

        var json = JsonSerializer.Serialize(result, new JsonSerializerOptions
        {
            WriteIndented = true,
            Encoder = JavaScriptEncoder.UnsafeRelaxedJsonEscaping
        });
        File.WriteAllText(caminhoJSON, json);
    }}