using DotNetEnv;
using ESCO_API.Contexts;
using ESCO_API.Domains;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

//? 
//? Loading database schema
//? Add ENV loader
Env.Load();
//?
//? Loading connection string from .env
var connectionString = Environment.GetEnvironmentVariable("DefaultConncetion");
//? 
//? Connect with database
builder.Services.AddDbContext<EscoContext>(options => options.UseNpgsql(
    connectionString,
    npgsqloptions =>
    {
        npgsqloptions.MapEnum<ClassificacaoHabilidadeEnum>("classificacao_habilidade_enum");
        npgsqloptions.MapEnum<NivelReutilizacaoEnum>("nivel_reutilizacao_enum");
        npgsqloptions.MapEnum<StatusEnum>("status_enum");
        npgsqloptions.MapEnum<TipoConceitoEnum>("tipo_conceito_enum");
        npgsqloptions.MapEnum<TipoHabilidadeEnum>("tipo_habilidade_enum");
        npgsqloptions.MapEnum<TipoRelacionamentoEnum>("tipo_relacionamento_enum");
    }
));


// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}else
{
    app.UseHttpsRedirection();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
