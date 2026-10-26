using DotNetEnv;
using ESCO_API.Contexts;
using ESCO_API.Domains;
using ESCO_API.Interfaces;
using ESCO_API.Repositories;
using ESCO_API.Services;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Npgsql;

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


builder.Services.AddControllers();

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

var app = builder.Build();


app.UseCors("CorsPolicy");

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
