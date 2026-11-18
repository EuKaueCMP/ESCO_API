import type { Metadata } from "next";
import { Montserrat } from "next/font/google";
import Header from "@/components/Header/Header";
import Footer from "@/components/Footer/Footer";
import "./globals.css";

const montserrat = Montserrat({
  subsets: ["latin", "latin-ext"],
  variable: "--fonte-montserrat",
  display: "swap",
});

export const metadata: Metadata = {
  title: {
    default: "ESCO·SFIA — habilidades, ocupações e mercado real",
    template: "%s · ESCO·SFIA",
  },
  description:
    "Framework integrado de habilidades e ocupações: SFIA 9 + ESCO com dado real de mercado, trilhas de carreira e busca inteligente.",
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="pt-BR" className={montserrat.variable}>
      <body>
        <Header />
        <main>{children}</main>
        <Footer />
      </body>
    </html>
  );
}
