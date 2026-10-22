using System;
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
        modelBuilder
            .HasPostgresEnum("esco_dataset", "classificacao_habilidade_enum", new[] { "hardskill", "softskill" })
            .HasPostgresEnum("esco_dataset", "nivel_reutilizacao_enum", new[] { "transversal", "intersetorial", "especifico_setor", "especifico_ocupacao" })
            .HasPostgresEnum("esco_dataset", "status_enum", new[] { "released", "deprecated" })
            .HasPostgresEnum("esco_dataset", "tipo_conceito_enum", new[] { "habilidade", "grupo_habilidade" })
            .HasPostgresEnum("esco_dataset", "tipo_habilidade_enum", new[] { "conhecimento", "competencia" })
            .HasPostgresEnum("esco_dataset", "tipo_relacionamento_enum", new[] { "essencial", "opcional" })
            .HasPostgresExtension("esco_dataset", "pg_trgm");

        modelBuilder.Entity<Colecao>(entity =>
        {
            entity.HasKey(e => e.ColecaoId).HasName("colecao_pkey");

            entity.ToTable("colecao", "esco_dataset");

            entity.HasIndex(e => e.Uri, "colecao_uri_key").IsUnique();

            entity.HasIndex(e => e.SearchVector, "idx_colecao_fts").HasMethod("gin");

            entity.Property(e => e.ColecaoId).HasColumnName("colecao_id");
            entity.Property(e => e.Descricao).HasColumnName("descricao");
            entity.Property(e => e.Nome).HasColumnName("nome");
            entity.Property(e => e.SearchVector)
                .HasComputedColumnSql("(setweight(to_tsvector('portuguese'::regconfig, COALESCE(nome, ''::text)), 'A'::\"char\") || setweight(to_tsvector('portuguese'::regconfig, COALESCE(descricao, ''::text)), 'B'::\"char\"))", true)
                .HasColumnName("search_vector");
            entity.Property(e => e.Uri)
                .HasMaxLength(100)
                .HasColumnName("uri");
        });

        modelBuilder.Entity<GrupoOcupacao>(entity =>
        {
            entity.HasKey(e => e.GrupoId).HasName("grupo_ocupacao_pkey");

            entity.ToTable("grupo_ocupacao", "esco_dataset");

            entity.HasIndex(e => e.Codigo, "grupo_ocupacao_codigo_key").IsUnique();

            entity.HasIndex(e => e.Uri, "grupo_ocupacao_uri_key").IsUnique();

            entity.HasIndex(e => e.SearchVector, "idx_grupo_ocupacao_rts").HasMethod("gin");

            entity.Property(e => e.GrupoId).HasColumnName("grupo_id");
            entity.Property(e => e.Codigo)
                .HasMaxLength(20)
                .HasColumnName("codigo");
            entity.Property(e => e.Descricao).HasColumnName("descricao");
            entity.Property(e => e.Nome).HasColumnName("nome");
            entity.Property(e => e.SearchVector)
                .HasComputedColumnSql("(setweight(to_tsvector('portuguese'::regconfig, COALESCE(nome, ''::text)), 'A'::\"char\") || setweight(to_tsvector('portuguese'::regconfig, COALESCE(descricao, ''::text)), 'B'::\"char\"))", true)
                .HasColumnName("search_vector");
            entity.Property(e => e.Uri)
                .HasMaxLength(100)
                .HasColumnName("uri");
        });

        modelBuilder.Entity<Habilidade>(entity =>
        {
            entity.HasKey(e => e.HabilidadeId).HasName("habilidade_pkey");

            entity.ToTable("habilidade", "esco_dataset");

            entity.HasIndex(e => e.Uri, "habilidade_uri_key").IsUnique();

            entity.HasIndex(e => e.SearchVector, "idx_habilidade_fts").HasMethod("gin");

            entity.Property(e => e.HabilidadeId).HasColumnName("habilidade_id");
            entity.Property(e => e.Descricao).HasColumnName("descricao");
            entity.Property(e => e.Nome).HasColumnName("nome");
            entity.Property(e => e.NomesAlternativos)
                .HasColumnType("jsonb")
                .HasColumnName("nomes_alternativos");
            entity.Property(e => e.SearchVector)
                .HasComputedColumnSql("(setweight(to_tsvector('portuguese'::regconfig, COALESCE(nome, ''::text)), 'A'::\"char\") || setweight(to_tsvector('portuguese'::regconfig, COALESCE(descricao, ''::text)), 'B'::\"char\"))", true)
                .HasColumnName("search_vector");
            entity.Property(e => e.Uri)
                .HasMaxLength(100)
                .HasColumnName("uri");

            entity.HasMany(d => d.Colecao).WithMany(p => p.Habilidade)
                .UsingEntity<Dictionary<string, object>>(
                    "HabilidadeColecao",
                    r => r.HasOne<Colecao>().WithMany()
                        .HasForeignKey("ColecaoId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("habilidade_colecao_colecao_id_fkey"),
                    l => l.HasOne<Habilidade>().WithMany()
                        .HasForeignKey("HabilidadeId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("habilidade_colecao_habilidade_id_fkey"),
                    j =>
                    {
                        j.HasKey("HabilidadeId", "ColecaoId").HasName("habilidade_colecao_pkey");
                        j.ToTable("habilidade_colecao", "esco_dataset");
                        j.IndexerProperty<int>("HabilidadeId").HasColumnName("habilidade_id");
                        j.IndexerProperty<int>("ColecaoId").HasColumnName("colecao_id");
                    });

            entity.HasMany(d => d.HabilidadeFilha).WithMany(p => p.HabilidadePai)
                .UsingEntity<Dictionary<string, object>>(
                    "HierarquiaHabilidade",
                    r => r.HasOne<Habilidade>().WithMany()
                        .HasForeignKey("HabilidadeFilha")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("hierarquia_habilidade_habilidade_filha_fkey"),
                    l => l.HasOne<Habilidade>().WithMany()
                        .HasForeignKey("HabilidadePai")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("hierarquia_habilidade_habilidade_pai_fkey"),
                    j =>
                    {
                        j.HasKey("HabilidadePai", "HabilidadeFilha").HasName("hierarquia_habilidade_pkey");
                        j.ToTable("hierarquia_habilidade", "esco_dataset");
                        j.IndexerProperty<int>("HabilidadePai").HasColumnName("habilidade_pai");
                        j.IndexerProperty<int>("HabilidadeFilha").HasColumnName("habilidade_filha");
                    });

            entity.HasMany(d => d.HabilidadePai).WithMany(p => p.HabilidadeFilha)
                .UsingEntity<Dictionary<string, object>>(
                    "HierarquiaHabilidade",
                    r => r.HasOne<Habilidade>().WithMany()
                        .HasForeignKey("HabilidadePai")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("hierarquia_habilidade_habilidade_pai_fkey"),
                    l => l.HasOne<Habilidade>().WithMany()
                        .HasForeignKey("HabilidadeFilha")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("hierarquia_habilidade_habilidade_filha_fkey"),
                    j =>
                    {
                        j.HasKey("HabilidadePai", "HabilidadeFilha").HasName("hierarquia_habilidade_pkey");
                        j.ToTable("hierarquia_habilidade", "esco_dataset");
                        j.IndexerProperty<int>("HabilidadePai").HasColumnName("habilidade_pai");
                        j.IndexerProperty<int>("HabilidadeFilha").HasColumnName("habilidade_filha");
                    });
        });

        modelBuilder.Entity<Ocupacao>(entity =>
        {
            entity.HasKey(e => e.OcupacaoId).HasName("ocupacao_pkey");

            entity.ToTable("ocupacao", "esco_dataset");

            entity.HasIndex(e => e.SearchVector, "idx_ocupacao_fts").HasMethod("gin");

            entity.HasIndex(e => e.Uri, "ocupacao_uri_key").IsUnique();

            entity.Property(e => e.OcupacaoId).HasColumnName("ocupacao_id");
            entity.Property(e => e.Descricao).HasColumnName("descricao");
            entity.Property(e => e.GrupoOcupacaoId).HasColumnName("grupo_ocupacao_id");
            entity.Property(e => e.NomesAlternativos)
                .HasColumnType("jsonb")
                .HasColumnName("nomes_alternativos");
            entity.Property(e => e.SearchVector)
                .HasComputedColumnSql("(setweight(to_tsvector('portuguese'::regconfig, COALESCE(titulo, ''::text)), 'A'::\"char\") || setweight(to_tsvector('portuguese'::regconfig, COALESCE(descricao, ''::text)), 'B'::\"char\"))", true)
                .HasColumnName("search_vector");
            entity.Property(e => e.Titulo).HasColumnName("titulo");
            entity.Property(e => e.Uri)
                .HasMaxLength(100)
                .HasColumnName("uri");

            entity.HasOne(d => d.GrupoOcupacao).WithMany(p => p.Ocupacao)
                .HasForeignKey(d => d.GrupoOcupacaoId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("ocupacao_grupo_ocupacao_id_fkey");

            entity.HasMany(d => d.Habilidade).WithMany(p => p.Ocupacao)
                .UsingEntity<Dictionary<string, object>>(
                    "OcupacaoHabilidade",
                    r => r.HasOne<Habilidade>().WithMany()
                        .HasForeignKey("HabilidadeId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("ocupacao_habilidade_habilidade_id_fkey"),
                    l => l.HasOne<Ocupacao>().WithMany()
                        .HasForeignKey("OcupacaoId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("ocupacao_habilidade_ocupacao_id_fkey"),
                    j =>
                    {
                        j.HasKey("OcupacaoId", "HabilidadeId").HasName("ocupacao_habilidade_pkey");
                        j.ToTable("ocupacao_habilidade", "esco_dataset");
                        j.IndexerProperty<int>("OcupacaoId").HasColumnName("ocupacao_id");
                        j.IndexerProperty<int>("HabilidadeId").HasColumnName("habilidade_id");
                    });
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
