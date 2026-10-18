# Seu Treinador de IA de Corrida 🏃‍♂️🤖

> **"Avalia meu treino de hoje."** — e uma IA que conhece suas zonas, seu sono e seu clima responde com um veredito de verdade… no seu PC, de graça.

Esta série monta, passo a passo, o que antes era privilégio de plataformas pagas: um agente de IA conectado aos **seus** dados do Garmin.

## O que você vai ter ao final

- 🔥 **Análise real do treino** — a IA busca sua corrida no Garmin, compara km a km com **suas zonas** (calibradas no seu último teste) e olha sono, HRV e o clima antes de dar o veredito
- 🗓️ **Treino por conversa** — "cria um 5x1km com 2min de recovery pra terça" e ele aparece no calendário do seu relógio
- 📸 **A foto do story pronta** — 1080×1920, com gráfico de ritmo e coração

## A série (3 tutoriais, ~1 hora no total)

| # | Tutorial | O que você conquista | Tempo |
|---|---|---|---|
| 1 | [OpenCode do zero (Windows)](tutorial-1-opencode-do-zero.md) | Uma IA conversando com você no navegador | ~20 min |
| 2 | [Modelos melhores: NVIDIA NIM](tutorial-2-nvidia-modelos.md) | Modelos capazes, grátis, sem limites curtos | ~10 min |
| 3 | [Conecte seu Garmin](tutorial-3-garmin-mcp.md) | O treinador completo — no OpenCode ou no Claude | ~30 min |

**Pré-requisitos:** um PC com Windows 10/11, internet, e uma conta no Garmin Connect com seus treinos. Nenhuma experiência com programação é necessária — os poucos comandos vêm prontos para copiar e colar, e cada passo tem um checkpoint de verificação.

## Quanto custa?

**R$0.** O conector é open source e os modelos rodam no free tier da NVIDIA (sem cota mensal de tokens — limite de ~40 requisições/min por modelo, mais do que suficiente para uso pessoal).

## Sobre os dados

Seu login do Garmin fica **só no seu computador**. Os dados que você pede para analisar passam pela API do modelo que você escolher — como qualquer IA em nuvem, inclusive quando você manda um print de treino para um chatbot. O que muda aqui: a IA **busca tudo sozinha, com o contexto completo, e compara com as suas zonas**.

## Acompanhe a série de vídeos

Este guia nasceu junto de uma série de vídeos no meu Instagram — se você chegou por aqui por um deles, bem-vindo(a). *(link do perfil aqui)*

---

**Créditos:** conector Garmin — [Taxuspt/garmin_mcp](https://github.com/Taxuspt/garmin_mcp) via [python-garminconnect](https://github.com/cyberjunky/python-garminconnect) · habilidades de corrida (zonas VDOT, análise, treinos, imagem do story) — [@leonardocroda](https://github.com/leonardocroda) no [fork com as skills](https://github.com/leonardocroda/garmin_mcp) · zonas de ritmo — método VDOT de *Jack Daniels' Running Formula* · IA — [OpenCode](https://opencode.ai) + modelos via [NVIDIA build](https://build.nvidia.com)

Conteúdo licenciado sob [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.pt-br).
