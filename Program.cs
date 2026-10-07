using System.Text.Json.Nodes;

namespace dataset_to_json
{
    class Program
    {
        static void Main(string[] args)
{
    string pastaEntrada = "/home/kaue/Documents/projects/dataset_to_json/dataset_cargos/ESCO_dataset_v1.2.0_pt_csv";
    string pastaSaida = "/home/kaue/Documents/projects/dataset_to_json/Convertidos";

    Directory.CreateDirectory(pastaSaida);

    var arquivos = Directory.GetFiles(pastaEntrada, "*.csv");

    foreach (var arquivo in arquivos)
    {
        string nome = Path.GetFileNameWithoutExtension(arquivo); // ex: "occupations_pt"
        string saida = Path.Combine(pastaSaida, nome + ".json");
        Conversions.ConvertCsvToJson(arquivo, saida);
        Console.WriteLine($"✓ {nome}.csv → {nome}.json");
    }

    Console.WriteLine($"\n{arquivos.Length} arquivos convertidos.");
}   
    }
}