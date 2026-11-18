import { GraduationCap, Layers, Ruler } from "lucide-react";
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
      <h1 className="titulo-pagina" style={{ paddingTop: 30 }}>Níveis de responsabilidade</h1>
      <p className="subtitulo-pagina">
        A escala 1–7 que organiza todas as habilidades do framework — e os 16 atributos que explicam
        o que muda de um nível para outro.
      </p>

      <h2 className="titulo-secao">
        <Layers size={18} />
        A escala
      </h2>
      <div className={styles.escala}>
        {(niveis ?? []).map((n) => (
          <div key={n.nivel} className="bloco">
            <div className={styles.cabecalhoNivel}>
              <span className={styles.numeroNivel}>{n.nivel}</span>
              <div className={styles.nomeNivel}>{n.nome}</div>
            </div>
            <p className={styles.descNivel}>{n.descricao}</p>
          </div>
        ))}
      </div>

      <h2 className="titulo-secao">
        <Ruler size={18} />
        Os 16 atributos que definem os níveis
      </h2>
      <div className={styles.atributos}>
        {detalhes.map(({ atributo, niveis: ns }) => (
          <details key={atributo.slug} className="acordeao">
            <summary>
              {atributo.codigo && <span className="codigo-sfia">{atributo.codigo}</span>}
              {atributo.nome}
              <GraduationCap size={15} className={styles.setaIcone} />
            </summary>
            <div className="acordeao-corpo">
              {ns.map((n) => (
                <div key={n.nivel} className={styles.atributoNivel}>
                  <span className={styles.atributoNumero}>{n.nivel}</span>
                  <div>
                    <span className={styles.atributoNome}>{n.nomeNivel}</span>
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
