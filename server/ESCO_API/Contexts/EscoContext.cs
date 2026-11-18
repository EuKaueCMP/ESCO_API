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
    public virtual DbSet<NivelHabilidade> NivelHabilidade { get; set; }

    public virtual DbSet<NivelHabilidadeDescritor> NivelHabilidadeDescritor { get; set; }

    public virtual DbSet<Ocupacao> Ocupacao { get; set; }

    public virtual DbSet<SfiaAtributo> SfiaAtributo { get; set; }

    public virtual DbSet<SfiaAtributoNivel> SfiaAtributoNivel { get; set; }

    public virtual DbSet<SfiaView> SfiaView { get; set; }

    public virtual DbSet<SfiaViewHabilidade> SfiaViewHabilidade { get; set; }

    public virtual DbSet<MercadoOcupacao> MercadoOcupacao { get; set; }

    public virtual DbSet<MercadoSalario> MercadoSalario { get; set; }

    public virtual DbSet<MercadoHabilidade> MercadoHabilidade { get; set; }
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

            entity.Property(e => e.Codigo)
                .HasMaxLength(8)
                .HasColumnName("codigo");

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

            entity.Property(e => e.PesoRelevancia)
                .HasColumnName("peso_relevancia");
                
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

        // Nivel de responsabilidade SFIA (1-7)
        modelBuilder.Entity<NivelHabilidade>(entity =>
        {
            entity.HasKey(e => e.Nivel)
                .HasName("nivel_habilidade_pkey");

            entity.ToTable("nivel_habilidade", "esco_dataset");

            entity.Property(e => e.Nivel)
                .HasColumnName("nivel");

            entity.Property(e => e.Nome)
                .HasColumnName("nome");

            entity.Property(e => e.Descricao)
                .HasColumnName("descricao");
        });

        // Descritor de nivel especifico por habilidade (faixa SFIA real da skill)
        modelBuilder.Entity<NivelHabilidadeDescritor>(entity =>
        {
            entity.ToTable("nivel_habilidade_descritor", "esco_dataset");

            entity.HasKey(e => new { e.HabilidadeId, e.Nivel })
                .HasName("nivel_habilidade_descritor_pkey");

            entity.Property(e => e.HabilidadeId)
                .HasColumnName("habilidade_id");

            entity.Property(e => e.Nivel)
                .HasColumnName("nivel");

            entity.Property(e => e.Descricao)
                .HasColumnName("descricao");

            entity.Property(e => e.DescricaoEn)
                .HasColumnName("descricao_en");

            entity.Property(e => e.Origem)
                .HasColumnName("origem")
                .HasDefaultValue("sintetizado");

            entity.HasOne(e => e.NivelHabilidade)
                .WithMany()
                .HasForeignKey(e => e.Nivel)
                .HasConstraintName("nivel_habilidade_descritor_nivel_fkey");

            entity.HasOne(e => e.Habilidade)
                .WithMany()
                .HasForeignKey(e => e.HabilidadeId)
                .HasConstraintName("nivel_habilidade_descritor_habilidade_id_fkey");
        });

        // Atributo generico SFIA
        modelBuilder.Entity<SfiaAtributo>(entity =>
        {
            entity.ToTable("sfia_atributo", "esco_dataset");

            entity.HasKey(e => e.Slug)
                .HasName("sfia_atributo_pkey");

            entity.Property(e => e.Slug).HasColumnName("slug");
            entity.Property(e => e.Codigo).HasColumnName("codigo");
            entity.Property(e => e.NomeEn).HasColumnName("nome_en");
            entity.Property(e => e.NomePt).HasColumnName("nome_pt");
        });

        modelBuilder.Entity<SfiaAtributoNivel>(entity =>
        {
            entity.ToTable("sfia_atributo_nivel", "esco_dataset");

            entity.HasKey(e => new { e.Slug, e.Nivel })
                .HasName("sfia_atributo_nivel_pkey");

            entity.Property(e => e.Slug).HasColumnName("slug");
            entity.Property(e => e.Nivel).HasColumnName("nivel");
            entity.Property(e => e.DescricaoEn).HasColumnName("descricao_en");
            entity.Property(e => e.DescricaoPt).HasColumnName("descricao_pt");

            entity.HasOne(e => e.Atributo)
                .WithMany(a => a.Niveis)
                .HasForeignKey(e => e.Slug)
                .HasConstraintName("sfia_atributo_nivel_slug_fkey");

            entity.HasOne(e => e.NivelHabilidade)
                .WithMany()
                .HasForeignKey(e => e.Nivel)
                .HasConstraintName("sfia_atributo_nivel_nivel_fkey");
        });

        // View SFIA
        modelBuilder.Entity<SfiaView>(entity =>
        {
            entity.ToTable("sfia_view", "esco_dataset");

            entity.HasKey(e => e.ViewId)
                .HasName("sfia_view_pkey");

            entity.HasIndex(e => e.Caminho, "sfia_view_caminho_key")
                .IsUnique();

            entity.Property(e => e.ViewId)
                .HasColumnName("view_id")
                .ValueGeneratedOnAdd();

            entity.Property(e => e.Caminho).HasColumnName("caminho");
            entity.Property(e => e.Slug).HasColumnName("slug");
            entity.Property(e => e.SlugPai).HasColumnName("slug_pai");
            entity.Property(e => e.NomeEn).HasColumnName("nome_en");
            entity.Property(e => e.NomePt).HasColumnName("nome_pt");
            entity.Property(e => e.Profundidade).HasColumnName("profundidade");
        });

        modelBuilder.Entity<SfiaViewHabilidade>(entity =>
        {
            entity.ToTable("sfia_view_habilidade", "esco_dataset");

            entity.HasKey(e => new { e.Caminho, e.HabilidadeId })
                .HasName("sfia_view_habilidade_pkey");

            entity.Property(e => e.Caminho).HasColumnName("caminho");
            entity.Property(e => e.HabilidadeId).HasColumnName("habilidade_id");

            entity.HasOne(e => e.View)
                .WithMany(v => v.Habilidades)
                .HasForeignKey(e => e.Caminho)
                .HasPrincipalKey(v => v.Caminho)
                .HasConstraintName("sfia_view_habilidade_caminho_fkey");

            entity.HasOne(e => e.Habilidade)
                .WithMany()
                .HasForeignKey(e => e.HabilidadeId)
                .HasConstraintName("sfia_view_habilidade_habilidade_id_fkey");
        });

        // Dado real de mercado (vagas e salarios)
        modelBuilder.Entity<MercadoOcupacao>(entity =>
        {
            entity.ToTable("mercado_ocupacao", "esco_dataset");

            entity.HasKey(e => e.OcupacaoId)
                .HasName("mercado_ocupacao_pkey");

            entity.Property(e => e.OcupacaoId).HasColumnName("ocupacao_id");
            entity.Property(e => e.Vagas).HasColumnName("vagas");
            entity.Property(e => e.FrequenciaPct).HasColumnName("frequencia_pct");
            entity.Property(e => e.Fonte).HasColumnName("fonte");
            entity.Property(e => e.AtualizadoEm).HasColumnName("atualizado_em");

            entity.HasOne(e => e.Ocupacao)
                .WithMany()
                .HasForeignKey(e => e.OcupacaoId)
                .HasConstraintName("mercado_ocupacao_ocupacao_id_fkey");
        });

        modelBuilder.Entity<MercadoSalario>(entity =>
        {
            entity.ToTable("mercado_salario", "esco_dataset");

            entity.HasKey(e => new { e.OcupacaoId, e.Nivel })
                .HasName("mercado_salario_pkey");

            entity.Property(e => e.OcupacaoId).HasColumnName("ocupacao_id");
            entity.Property(e => e.Nivel).HasColumnName("nivel");
            entity.Property(e => e.Amostra).HasColumnName("amostra");
            entity.Property(e => e.P25).HasColumnName("p25");
            entity.Property(e => e.P50).HasColumnName("p50");
            entity.Property(e => e.P75).HasColumnName("p75");
            entity.Property(e => e.P90).HasColumnName("p90");
            entity.Property(e => e.Moeda).HasColumnName("moeda");
            entity.Property(e => e.Fonte).HasColumnName("fonte");
            entity.Property(e => e.AtualizadoEm).HasColumnName("atualizado_em");

            entity.HasOne(e => e.Ocupacao)
                .WithMany()
                .HasForeignKey(e => e.OcupacaoId)
                .HasConstraintName("mercado_salario_ocupacao_id_fkey");

            entity.HasOne(e => e.NivelHabilidade)
                .WithMany()
                .HasForeignKey(e => e.Nivel)
                .HasConstraintName("mercado_salario_nivel_fkey");
        });

        modelBuilder.Entity<MercadoHabilidade>(entity =>
        {
            entity.ToTable("mercado_habilidade", "esco_dataset");

            entity.HasKey(e => new { e.OcupacaoId, e.HabilidadeId })
                .HasName("mercado_habilidade_pkey");

            entity.Property(e => e.OcupacaoId).HasColumnName("ocupacao_id");
            entity.Property(e => e.HabilidadeId).HasColumnName("habilidade_id");
            entity.Property(e => e.Vagas).HasColumnName("vagas");
            entity.Property(e => e.PctVagas).HasColumnName("pct_vagas");
            entity.Property(e => e.Fonte).HasColumnName("fonte");
            entity.Property(e => e.AtualizadoEm).HasColumnName("atualizado_em");

            entity.HasOne(e => e.Habilidade)
                .WithMany()
                .HasForeignKey(e => e.HabilidadeId)
                .HasConstraintName("mercado_habilidade_habilidade_id_fkey");
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

            entity.Property(e => e.PesoRelevancia)
                .HasColumnName("peso_relevancia");

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

                        join.IndexerProperty<short?>("NivelHabilidade")
                            .HasColumnName("nivel_habilidade");

                        join.IndexerProperty<TipoRelacionamentoEnum>("TipoRelacionamento")
                            .HasColumnName("tipo_relacionamento")
                            .HasColumnType("esco_dataset.tipo_relacionamento_enum");
                    });
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}