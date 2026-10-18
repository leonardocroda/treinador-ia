# treinador-ia

Site dos tutoriais **"Seu Treinador de IA de Corrida"** — a série que ensina a montar, no próprio PC, uma IA que avalia treinos do Garmin com zonas personalizadas, cria treinos no calendário do relógio e gera a imagem do story.

Publicado via **GitHub Pages + MkDocs Material**. A cada push na `main`, a Action faz o build e publica no branch `gh-pages`.

## Rodando local

```powershell
uv run --with mkdocs-material mkdocs serve
# abre http://localhost:8000
```

(ou `pip install -r requirements.txt && mkdocs serve`, se preferir)

## Como publicar

1. Criar o repo `leonardocroda/treinador-ia` no GitHub e dar push na `main`
2. O primeiro push dispara a Action, que cria o branch `gh-pages`
3. No GitHub: **Settings → Pages → Source: Deploy from a branch → Branch: `gh-pages`, `/ (root)` → Save**
4. O site sobe em `https://leonardocroda.github.io/treinador-ia`

> Se escolher outro nome de repo, atualize `site_url` e `repo_url` no `mkdocs.yml`.

## Conteúdo

| Arquivo | Página |
|---|---|
| `docs/index.md` | Início — visão geral da série |
| `docs/tutorial-1-opencode-do-zero.md` | Tutorial 1 — OpenCode do zero (Windows) |
| `docs/tutorial-2-nvidia-modelos.md` | Tutorial 2 — Modelos melhores: NVIDIA NIM |
| `docs/tutorial-3-garmin-mcp.md` | Tutorial 3 — Conecte seu Garmin (OpenCode + Claude) |

## Fonte dos tutoriais

Os tutoriais são mantidos junto ao projeto-mãe (`garmin_mcp`) durante o rascunho; a versão publicada vive aqui. Créditos completos estão na página Início do site.
