import { apiGet } from "@/lib/api";
import type { Nivel, SfiaAtributo, SfiaAtributoNivel } from "@/lib/tipagem";
import styles from "./page.module.css";

export const dynamic = "force-dynamic";
export const metadata = { title: "Níveis e atributos" };

export default async function Niveis() {
  const [niveis, atributos] = await Promise.all([
    apiGet<Nivel[]>("/habilidade/niveis"),
    apiGet<SfiaAtributo[]>("/sfia/atributo"),
  ]);

  const detalhes = await Promise.all(
    (atributos ?? []).map(async (a) => ({
      atributo: a,
      niveis: (await apiGet<SfiaAtributoNivel[]>(`/sfia/atributo/${a.slug}`)) ?? [],
    })),
  );

  return (
    <div className="container">
      <div className={styles.cabeca}>
        <span className="rotulo">a régua · 7 níveis · 16 atributos</span>
        <h1 className="titulo-pagina">Níveis de responsabilidade</h1>
        <p className="subtitulo-pagina">
          A escala que organiza todas as habilidades — do trabalho sob supervisão à definição de
          estratégia. Cada nível se descreve por 16 atributos, de autonomia a influência.
        </p>
      </div>

      <div className={styles.cabecalhoSecao}>
        <h2 className={styles.secaoTitulo}>A escala</h2>
        <span className={styles.secaoMeta}>1 executor · 7 estrategista</span>
      </div>
      <div className={styles.escala}>
        {(niveis ?? []).map((n) => (
          <article key={n.nivel} className={styles.nivel}>
            <span className={styles.nivelNumero}>{n.nivel}</span>
            <div className={styles.nivelCorpo}>
              <h3 className={styles.nivelNome}>{n.nome}</h3>
              <p className={styles.nivelDesc}>{n.descricao}</p>
            </div>
          </article>
        ))}
      </div>

      <div className={styles.cabecalhoSecao}>
        <h2 className={styles.secaoTitulo}>Os 16 atributos</h2>
        <span className={styles.secaoMeta}>abertos por nível</span>
      </div>
      <div className={styles.atributos}>
        {detalhes.map(({ atributo, niveis: ns }) => (
          <details key={atributo.slug} className="acordeao">
            <summary>
              {atributo.codigo && <span className="codigo-sfia">{atributo.codigo}</span>}
              <span className={styles.atributoNome}>{atributo.nome}</span>
            </summary>
            <div className="acordeao-corpo">
              {ns.map((n) => (
                <div key={n.nivel} className={styles.atributoNivel}>
                  <span className={styles.atributoNumero}>{n.nivel}</span>
                  <div>
                    <span className={styles.atributoNivelNome}>{n.nomeNivel}</span>
                    <p className={styles.atributoDesc}>{n.descricao}</p>
                  </div>
                </div>
              ))}
            </div>
          </details>
        ))}
      </div>
    </div>
  );
}
