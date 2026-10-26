using System.Collections.Generic;
using ESCO_API.Domains;
using Microsoft.EntityFrameworkCore;

namespace ESCO_API.Contexts;

public partial class EscoContext : DbContext
{
    public EscoContext(DbContextOptions<EscoContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Colecao> Colecao { get; set; }
    public virtual DbSet<GrupoOcupacao> GrupoOcupacao { get; set; }
    public virtual DbSet<Habilidade> Habilidade { get; set; }
    public virtual DbSet<Ocupacao> Ocupacao { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.HasDefaultSchema("esco_dataset");

        // ENUMs do PostgreSQL
        modelBuilder
            .HasPostgresEnum(
                "esco_dataset",
                "classificacao_habilidade_enum",
                new[] { "hardskill", "softskill" })
            .HasPostgresEnum(
                "esco_dataset",
                "nivel_reutilizacao_enum",
                new[]
                {
                    "transversal",
                    "intersetorial",
                    "especifico_setor",
                    "especifico_ocupacao"
                })
            .HasPostgresEnum(
                "esco_dataset",
                "status_enum",
                new[] { "released", "deprecated" })
            .HasPostgresEnum(
                "esco_dataset",
                "tipo_conceito_enum",
                new[] { "habilidade", "grupo_habilidade" })
            .HasPostgresEnum(
                "esco_dataset",
                "tipo_habilidade_enum",
                new[] { "conhecimento", "competencia" })
            .HasPostgresEnum(
                "esco_dataset",
                "tipo_relacionamento_enum",
                new[] { "essencial", "opcional" });

        modelBuilder.HasPostgresExtension("esco_dataset", "pg_trgm");

        // Coleção
        modelBuilder.Entity<Colecao>(entity =>
        {
            entity.HasKey(e => e.ColecaoId)
                .HasName("colecao_pkey");

            entity.ToTable("colecao", "esco_dataset");

            entity.HasIndex(e => e.Uri, "colecao_uri_key")
                .IsUnique();

            entity.HasIndex(e => e.SearchVector, "idx_colecao_fts")
                .HasMethod("gin");

            entity.Property(e => e.ColecaoId)
                .HasColumnName("colecao_id");

            entity.Property(e => e.Descricao)
                .HasColumnName("descricao");

            entity.Property(e => e.Nome)
                .HasColumnName("nome");

            entity.Property(e => e.SearchVector)
                .HasComputedColumnSql(
                    "(setweight(to_tsvector('portuguese'::regconfig, COALESCE(nome, ''::text)), 'A'::\"char\") || setweight(to_tsvector('portuguese'::regconfig, COALESCE(descricao, ''::text)), 'B'::\"char\"))",
                    true)
                .HasColumnName("search_vector");

            entity.Property(e => e.Uri)
                .HasMaxLength(100)
                .HasColumnName("uri");
        });

        // Grupo de ocupação
        modelBuilder.Entity<GrupoOcupacao>(entity =>
        {
            entity.HasKey(e => e.GrupoId)
                .HasName("grupo_ocupacao_pkey");

            entity.ToTable("grupo_ocupacao", "esco_dataset");

            entity.HasIndex(e => e.Codigo, "grupo_ocupacao_codigo_key")
                .IsUnique();

            entity.HasIndex(e => e.Uri, "grupo_ocupacao_uri_key")
                .IsUnique();

            entity.HasIndex(e => e.SearchVector, "idx_grupo_ocupacao_rts")
                .HasMethod("gin");

            entity.Property(e => e.GrupoId)
                .HasColumnName("grupo_id");

            entity.Property(e => e.Codigo)
                .HasMaxLength(20)
                .HasColumnName("codigo");

            entity.Property(e => e.Descricao)
                .HasColumnName("descricao");

            entity.Property(e => e.Nome)
                .HasColumnName("titulo");

            entity.Property(e => e.SearchVector)
                .HasComputedColumnSql(
                    "(setweight(to_tsvector('portuguese'::regconfig, COALESCE(titulo, ''::text)), 'A'::\"char\") || setweight(to_tsvector('portuguese'::regconfig, COALESCE(descricao, ''::text)), 'B'::\"char\"))",
                    true)
                .HasColumnName("search_vector");

            entity.Property(e => e.Uri)
                .HasMaxLength(100)
                .HasColumnName("uri");
        });

        // Habilidade
        modelBuilder.Entity<Habilidade>(entity =>
        {
            entity.HasKey(e => e.HabilidadeId)
                .HasName("habilidade_pkey");

            entity.ToTable("habilidade", "esco_dataset");

            entity.HasIndex(e => e.Uri, "habilidade_uri_key")
                .IsUnique();

            entity.HasIndex(e => e.SearchVector, "idx_habilidade_fts")
                .HasMethod("gin");

            entity.Property(e => e.HabilidadeId)
                .HasColumnName("habilidade_id");

            entity.Property(e => e.Uri)
                .HasMaxLength(100)
                .HasColumnName("uri");

            entity.Property(e => e.Nome)
                .HasColumnName("nome");

            entity.Property(e => e.Descricao)
                .HasColumnName("descricao");

            entity.Property(e => e.NomesAlternativos)
                .HasColumnType("jsonb")
                .HasColumnName("nomes_alternativos");

            entity.Property(e => e.SearchVector)
                .HasComputedColumnSql(
                    "(setweight(to_tsvector('portuguese'::regconfig, COALESCE(nome, ''::text)), 'A'::\"char\") || setweight(to_tsvector('portuguese'::regconfig, COALESCE(descricao, ''::text)), 'B'::\"char\"))",
                    true)
                .HasColumnName("search_vector");

            entity.Property(e => e.StatusHabilidade)
    .HasColumnName("status")
    .HasColumnType("esco_dataset.status_enum");

            entity.Property(e => e.NivelReutilizacao)
                .HasColumnName("nivel_reutilizacao")
                .HasColumnType("esco_dataset.nivel_reutilizacao_enum");

            entity.Property(e => e.TipoHabilidade)
                .HasColumnName("tipo_habilidade")
                .HasColumnType("esco_dataset.tipo_habilidade_enum");

            entity.Property(e => e.TipoConceito)
                .HasColumnName("tipo_conceito")
                .HasColumnType("esco_dataset.tipo_conceito_enum");

            entity.Property(e => e.ClassificacaoHabilidade)
                .HasColumnName("classificacao_habilidade")
                .HasColumnType("esco_dataset.classificacao_habilidade_enum");
                
            // Habilidade <-> Coleção
            entity.HasMany(e => e.Colecao)
                .WithMany(e => e.Habilidade)
                .UsingEntity<Dictionary<string, object>>(
                    "HabilidadeColecao",
                    right => right.HasOne<Colecao>()
                        .WithMany()
                        .HasForeignKey("ColecaoId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("habilidade_colecao_colecao_id_fkey"),
                    left => left.HasOne<Habilidade>()
                        .WithMany()
                        .HasForeignKey("HabilidadeId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("habilidade_colecao_habilidade_id_fkey"),
                    join =>
                    {
                        join.HasKey("HabilidadeId", "ColecaoId")
                            .HasName("habilidade_colecao_pkey");

                        join.ToTable("habilidade_colecao", "esco_dataset");

                        join.IndexerProperty<int>("HabilidadeId")
                            .HasColumnName("habilidade_id");

                        join.IndexerProperty<int>("ColecaoId")
                            .HasColumnName("colecao_id");
                    });

            // Hierarquia: habilidade pai <-> habilidade filha
            entity.HasMany(e => e.HabilidadeFilha)
                .WithMany(e => e.HabilidadePai)
                .UsingEntity<Dictionary<string, object>>(
                    "HierarquiaHabilidade",
                    right => right.HasOne<Habilidade>()
                        .WithMany()
                        .HasForeignKey("HabilidadeFilha")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("hierarquia_habilidade_habilidade_filha_fkey"),
                    left => left.HasOne<Habilidade>()
                        .WithMany()
                        .HasForeignKey("HabilidadePai")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("hierarquia_habilidade_habilidade_pai_fkey"),
                    join =>
                    {
                        join.HasKey("HabilidadePai", "HabilidadeFilha")
                            .HasName("hierarquia_habilidade_pkey");

                        join.ToTable("hierarquia_habilidade", "esco_dataset");

                        join.IndexerProperty<int>("HabilidadePai")
                            .HasColumnName("habilidade_pai");

                        join.IndexerProperty<int>("HabilidadeFilha")
                            .HasColumnName("habilidade_filha");
                    });
        });

        // Ocupação
        modelBuilder.Entity<Ocupacao>(entity =>
        {
            entity.HasKey(e => e.OcupacaoId)
                .HasName("ocupacao_pkey");

            entity.ToTable("ocupacao", "esco_dataset");

            entity.HasIndex(e => e.SearchVector, "idx_ocupacao_fts")
                .HasMethod("gin");

            entity.HasIndex(e => e.Uri, "ocupacao_uri_key")
                .IsUnique();

            entity.Property(e => e.OcupacaoId)
                .HasColumnName("ocupacao_id");

            entity.Property(e => e.Descricao)
                .HasColumnName("descricao");

            entity.Property(e => e.GrupoOcupacaoId)
                .HasColumnName("grupo_ocupacao_id");

            entity.Property(e => e.NomesAlternativos)
                .HasColumnType("jsonb")
                .HasColumnName("nomes_alternativos");

            entity.Property(e => e.SearchVector)
                .HasComputedColumnSql(
                    "(setweight(to_tsvector('portuguese'::regconfig, COALESCE(titulo, ''::text)), 'A'::\"char\") || setweight(to_tsvector('portuguese'::regconfig, COALESCE(descricao, ''::text)), 'B'::\"char\"))",
                    true)
                .HasColumnName("search_vector");

            entity.Property(e => e.Titulo)
                .HasColumnName("titulo");

            entity.Property(e => e.StatusOcupacao)
                .HasColumnName("status")
                .HasColumnType("esco_dataset.status_enum");

            entity.Property(e => e.Uri)
                .HasMaxLength(100)
                .HasColumnName("uri");

            entity.HasOne(e => e.GrupoOcupacao)
                .WithMany(e => e.Ocupacao)
                .HasForeignKey(e => e.GrupoOcupacaoId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("ocupacao_grupo_ocupacao_id_fkey");

            entity.HasMany(e => e.Habilidade)
                .WithMany(e => e.Ocupacao)
                .UsingEntity<Dictionary<string, object>>(
                    "OcupacaoHabilidade",
                    right => right.HasOne<Habilidade>()
                        .WithMany()
                        .HasForeignKey("HabilidadeId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("ocupacao_habilidade_habilidade_id_fkey"),
                    left => left.HasOne<Ocupacao>()
                        .WithMany()
                        .HasForeignKey("OcupacaoId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("ocupacao_habilidade_ocupacao_id_fkey"),
                    join =>
                    {
                        join.HasKey("OcupacaoId", "HabilidadeId")
                            .HasName("ocupacao_habilidade_pkey");

                        join.ToTable("ocupacao_habilidade", "esco_dataset");

                        join.IndexerProperty<int>("OcupacaoId")
                            .HasColumnName("ocupacao_id");

                        join.IndexerProperty<int>("HabilidadeId")
                            .HasColumnName("habilidade_id");
                    });
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}