using DotNetEnv;
using ESCO_API.Contexts;
using ESCO_API.Domains;
using ESCO_API.Interfaces;
using ESCO_API.Repositories;
using ESCO_API.Services;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Npgsql;
using System.Reflection;
using System.Text.Json.Serialization;

var builder = WebApplication.CreateBuilder(args);

//? 
//? Loading database schema
//? Add ENV loader
Env.Load();
//?
//? Loading connection string from .env
var connectionString = Environment.GetEnvironmentVariable("DefaultConnection");
var connectionStringBuilder = new NpgsqlConnectionStringBuilder(connectionString)
{
    SearchPath = "esco_dataset,public"
};

//? 
//? Connect with database
builder.Services.AddDbContext<EscoContext>(options =>
    options.UseNpgsql(
        connectionStringBuilder.ConnectionString,
        npgsqloptions =>
        {
            npgsqloptions.MapEnum<ClassificacaoHabilidadeEnum>(
                enumName: "classificacao_habilidade_enum",
                schemaName: "esco_dataset");

            npgsqloptions.MapEnum<NivelReutilizacaoEnum>(
                enumName: "nivel_reutilizacao_enum",
                schemaName: "esco_dataset");

            npgsqloptions.MapEnum<StatusEnum>(
                enumName: "status_enum",
                schemaName: "esco_dataset");

            npgsqloptions.MapEnum<TipoConceitoEnum>(
                enumName: "tipo_conceito_enum",
                schemaName: "esco_dataset");

            npgsqloptions.MapEnum<TipoHabilidadeEnum>(
                enumName: "tipo_habilidade_enum",
                schemaName: "esco_dataset");

            npgsqloptions.MapEnum<TipoRelacionamentoEnum>(
                enumName: "tipo_relacionamento_enum",
                schemaName: "esco_dataset");
        }
    )
);

// Add services to the container.
//? CRUD Colecao
builder.Services.AddScoped<IColecaoRepository, ColecaoRepository>();
builder.Services.AddScoped<ColecaoService>();

//? CRUD GrupoOcupacao
builder.Services.AddScoped<IGrupoOcupacaoRepository, GrupoOcupacaoRepository>();
builder.Services.AddScoped<GrupoOcupacaoService>();

//? CRUD Habilidade
builder.Services.AddScoped<IHabilidadeRepository, HabilidadeRepository>();
builder.Services.AddScoped<HabilidadeService>();

//? CRUD Ocupacao
builder.Services.AddScoped<IOcupacaoRepository, OcupacaoRepository>();
builder.Services.AddScoped<OcupacaoService>();

builder.Services.AddScoped<ISfiaRepository, SfiaRepository>();
builder.Services.AddScoped<SfiaService>();

builder.Services.AddScoped<IMercadoRepository, MercadoRepository>();
builder.Services.AddScoped<MercadoService>();

builder.Services.AddScoped<IBuscaRepository, BuscaRepository>();
builder.Services.AddScoped<BuscaService>();


builder.Services.AddControllers()
    .AddJsonOptions(options =>
        options.JsonSerializerOptions.Converters.Add(new JsonStringEnumConverter()));

//? Importando o Cors policy
builder.Services.AddCors(option =>
{
    option.AddPolicy("CorsPolicy", policy =>
    {
        policy.AllowAnyOrigin()
            .AllowAnyHeader()
            .AllowAnyMethod();
    });
});

// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();

//? Swagger (Swashbuckle): UI em /swagger e documento em /swagger/v1/swagger.json
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new Microsoft.OpenApi.OpenApiInfo
    {
        Title = "RBOSF API",
        Version = "v1",
        Description = "RBOSF — Relation Between Occupations and Skills Framework",
    });

    var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
    var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
    options.IncludeXmlComments(xmlPath);
    options.EnableAnnotations();
});

var app = builder.Build();


app.UseCors("CorsPolicy");

//? Swagger UI (documentação interativa da API)
app.UseSwagger();
app.UseSwaggerUI();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}else
{
    app.UseHttpsRedirection();
}

app.UseAuthorization();

app.MapControllers();

app.Run();
