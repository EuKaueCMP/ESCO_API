import { NextRequest, NextResponse } from "next/server";

export const dynamic = "force-dynamic";

export async function GET(
  request: NextRequest,
  { params }: { params: Promise<{ caminho: string[] }> },
) {
  const base = process.env.API_BASE_URL ?? "http://localhost:5116/rbosfapi/v1";
  const { caminho } = await params;
  const alvo = `${base}/${caminho.map((parte) => encodeURIComponent(parte)).join("/")}${request.nextUrl.search}`;

  try {
    const resposta = await fetch(alvo, {
      cache: "no-store",
      headers: { accept: "application/json" },
    });

    const corpo = await resposta.text();
    return new NextResponse(corpo, {
      status: resposta.status,
      headers: {
        "content-type": resposta.headers.get("content-type") ?? "application/json; charset=utf-8",
      },
    });
  } catch {
    return NextResponse.json(
      { erro: "Não foi possível falar com a API." },
      { status: 502 },
    );
  }
}
