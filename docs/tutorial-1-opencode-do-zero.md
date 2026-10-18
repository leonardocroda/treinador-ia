# Tutorial 1 — Sua primeira IA no terminal: OpenCode do zero (Windows)

> Parte 1 de 3 da série "Seu treinador de IA de corrida".
> ✔ Este tutorial é independente — você pode parar aqui e já ter uma IA conversando com você no PC.
> ⏱ Tempo: ~20 min · 💰 Custo: R$0

**Ao final você terá:** uma IA conversando com você no navegador do seu PC, usando modelos de graça — a base sobre a qual os próximos tutoriais conectam seu Garmin (tutorial 2 e 3).

---

## O que é o OpenCode (30 segundos)

[OpenCode](https://opencode.ai) é um agente de IA open source que roda no seu terminal e também abre numa interface web no navegador. Ele conversa, lê e escreve arquivos, executa comandos — e é a "sala de controle" que vamos usar em toda a série. Você não precisa saber programar: aqui ele é só um chat que também faz coisas no seu PC quando você pede.

---

## Passo 1 — Instalar o Node.js

O OpenCode é distribuído pelo npm, que vem junto com o Node.js.

1. Baixe a versão **LTS** em https://nodejs.org
2. Instale: next → next → instalar (não precisa mudar nada)

✅ **Checkpoint:** feche **todas** as janelas do PowerShell, abra uma nova (tecla Windows → digite "PowerShell" → Enter) e rode:

```powershell
node --version
npm --version
```

Se aparecerem versões (ex.: `v22.x`), funcionou.

> 💡 **Sem Node?** Existe um binário standalone do OpenCode para Windows em https://opencode.ai/v2/docs/ (seção "Download a standalone CLI binary"). Mas o caminho pelo npm é o mais simples para instalar e atualizar — seguimos com ele.

---

## Passo 2 — Instalar o OpenCode

No PowerShell:

```powershell
npm install -g @opencode/cli
```

✅ **Checkpoint:**

```powershell
opencode --version
```

Deve aparecer algo como `opencode v2.0.26` (ou mais novo).

---

## Passo 3 — Abrir o OpenCode

Você tem duas portas de entrada — use a que preferir:

**Opção A — Interface web no navegador (recomendada):**

```powershell
opencode pair
```

O comando imprime um link com login e senha descartáveis. Abra o link no navegador e pronto — a interface completa abre, com chat, sessões e tudo. *(O `opencode pair` gera credenciais de uso único a cada execução — é o jeito oficial e seguro de acessar a interface web.)*

**Opção B — Terminal (TUI):**

```powershell
opencode
```

Abre a interface em tela cheia direto no PowerShell/Windows Terminal. Aperte `Ctrl+C` duas vezes para sair.

✅ **Checkpoint:** em qualquer das duas, a interface abriu sem erro vermelho.

---

## Passo 4 — Conectar sua primeira IA (o trial grátis do OpenCode)

O OpenCode tem um catálogo de modelos próprio (o [Console](https://opencode.ai/console)), com vários modelos marcados como **Free** — dá para testar tudo sem pagar nada.

1. Crie sua conta em https://opencode.ai/console e gere sua **API key**
2. Conecte o provedor no OpenCode:
   - **Na interface web (o caminho mais simples):** abra o seletor de modelos e clique em **Connect provider** (Conectar provedor), escolha **OpenCode** e cole a API key
   - **Ou no terminal:** rode `/connect`, escolha o provedor OpenCode e cole a API key
3. Escolha o modelo no mesmo seletor (ou rode `/models` no terminal) — selecione um marcado **Free** (ex.: Nemotron 3 Ultra Free, Space Bunny Free, Big Pickle)

✅ **Checkpoint:** digite qualquer coisa ("olá, qual modelo você é?") e receba uma resposta.

> ⚠️ **Sobre os limites:** os modelos Free do OpenCode são um "trial" — ótimos para conhecer a ferramenta, mas com **limites de uso curtos** (rate limit por período). É o esperado: são cortesias para teste. Para uso de verdade, o próximo tutorial conecta modelos melhores, de graça, sem esses limites.

---

## Deu ruim?

| Sintoma | Solução |
|---|---|
| "npm não é reconhecido…" | Feche **todas** as janelas do PowerShell e abra uma nova. O Windows só enxerga o npm depois de reabrir o terminal |
| `npm install -g` deu erro de permissão | Abra o PowerShell como Administrador e rode de novo |
| `opencode` não abre / trava | `opencode service restart` e tente de novo (veja [troubleshooting](https://opencode.ai/v2/docs/troubleshooting/)) |
| `/connect` não mostra o provedor OpenCode | Atualize: `npm update -g @opencode/cli` |
| Interface web não abre pelo link do `opencode pair` | Confirme que o comando continua rodando na janela do PowerShell — copie o link completo com um clique |

---

## Próximos passos

- **[Tutorial 2 — Modelos melhores, ainda de graça: NVIDIA NIM](tutorial-2-nvidia-modelos.md)** → modelos mais capazes, sem os limites curtos do trial, e 2 minutos para configurar
- **[Tutorial 3 — Conecte seu Garmin ao OpenCode: a IA que conhece seus treinos](tutorial-3-garmin-mcp.md)** → o motivo desta série existir
