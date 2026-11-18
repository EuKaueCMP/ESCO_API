import type { Metadata } from "next";
import { IBM_Plex_Mono, IBM_Plex_Sans, Instrument_Serif } from "next/font/google";
import Header from "@/components/Header/Header";
import Footer from "@/components/Footer/Footer";
import CommandPalette from "@/components/CommandPalette/CommandPalette";
import "./globals.css";

const sans = IBM_Plex_Sans({
  subsets: ["latin", "latin-ext"],
  weight: ["400", "500", "600"],
  variable: "--fonte-sans",
  display: "swap",
});

const mono = IBM_Plex_Mono({
  subsets: ["latin", "latin-ext"],
  weight: ["400", "500"],
  variable: "--fonte-mono",
  display: "swap",
});

const serif = Instrument_Serif({
  subsets: ["latin", "latin-ext"],
  weight: "400",
  style: ["normal", "italic"],
  variable: "--fonte-serif",
  display: "swap",
});

export const metadata: Metadata = {
  title: {
    default: "RBOSF — o índice de habilidades, níveis e ocupações",
    template: "%s · RBOSF",
  },
  description:
    "RBOSF — Relation Between Occupations and Skills Framework. SFIA 9 e ESCO integrados: 16 mil habilidades, 3 mil ocupações, descritores por nível, rubrica de avaliação, salários reais e trilhas de progressão.",
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html
      lang="pt-BR"
      suppressHydrationWarning
      className={`${sans.variable} ${mono.variable} ${serif.variable}`}
    >
      <head>
        <script
          dangerouslySetInnerHTML={{
            __html: `(function(){try{var t=localStorage.getItem("rbosf-tema");var c=window.matchMedia("(prefers-color-scheme: light)").matches?"claro":"escuro";document.documentElement.dataset.theme=(t==="claro"||t==="escuro")?t:c;}catch(e){document.documentElement.dataset.theme=window.matchMedia("(prefers-color-scheme: light)").matches?"claro":"escuro";}})();`,
          }}
        />
      </head>
      <body>
        <Header />
        <main>{children}</main>
        <Footer />
        <CommandPalette />
      </body>
    </html>
  );
}
