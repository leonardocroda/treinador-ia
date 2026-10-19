# Tutorial 3 — Conecte seu Garmin à IA: a IA que conhece seus treinos

> Parte 3 de 3 da série "Seu treinador de IA de corrida".
> Pré-requisitos: [Tutorial 1](./tutorial-1-opencode-do-zero.md) (OpenCode instalado) e [Tutorial 2](./tutorial-2-nvidia-modelos.md) (modelo conectado).
> ⏱ Tempo: ~30 min · 💰 Custo: R$0
> **Já usa o OpenCode com outro provedor?** Pule direto para a [Rota B](#rota-b-global-seus-dados-em-qualquer-pasta).
> **Quer usar o Claude em vez do OpenCode?** Vá para a [Rota C](#rota-c-usar-no-claude).

**Ao final você terá uma IA que, sozinha:**

- 🔥 **Avalia seu treino do dia** — busca a corrida no Garmin, compara km a km com **suas zonas pessoais** (calibradas no seu último teste) e olha sono, HRV e clima antes de dar o veredito
- 🗓️ **Monta treinos e joga no calendário do Garmin** — "cria um 5x1km com 2min de recovery pra terça" aparece no seu relógio
- 📸 **Gera a foto do treino pronta pro story** — 1080×1920, com gráfico de ritmo e coração

Tudo por conversa, no navegador. Os comandos abaixo são os únicos do processo inteiro — depois disso, é só pedir.

---

## Como funciona (30 segundos)

Três peças conversando:

1. **Seus dados no Garmin Connect** — treinos, sono, HRV, zonas. Continuam no Garmin.
2. **Um conector open source** ([garmin_mcp](https://github.com/Taxuspt/garmin_mcp)) no seu PC que dá à IA acesso de leitura (e criação de treinos) — o "MCP" é só o nome do protocolo que permite isso. Seu login do Garmin fica **só no seu computador**.
3. **A IA** (OpenCode + o modelo que você conectou no Tutorial 2), que agora sabe buscar seus dados quando você pede.

Além do conector, existe um pacote com **4 habilidades de corrida** prontas — as instruções que ensinam a IA a ser treinadora (calibrar zonas VDOT, avaliar treino contra elas, criar treinos, gerar a imagem do story). É o que separa "uma IA com seus dados" de "um treinador".

---

## PREPARAÇÃO (uma vez só — vale para qualquer rota) {: #preparacao }

### P.1 — Python

Baixe em **https://www.python.org/downloads/** e, na instalação, **marque "Add python.exe to PATH"** (as habilidades de corrida usam Python).

✅ **Checkpoint:** abra um PowerShell **novo** e rode `python --version` — deve aparecer `Python 3.x`.

### P.2 — uv

O `uv` instala e roda o resto (inclusive o Python do conector, se faltar):

```powershell
winget install --id=astral-sh.uv -e
```

✅ **Checkpoint:** feche e reabra o PowerShell, rode `uv --version` — um número de versão aparece.

### P.3 — Login no Garmin (vale ~6 meses, sem baixar nada)

O login cria seus tokens no seu usuário (`~/.garminconnect`), apenas no seu PC — e vale para **qualquer rota** deste tutorial (incluindo a do Claude):

```powershell
uvx --python 3.12 --from git+https://github.com/leonardocroda/garmin_mcp garmin-mcp-auth
```

Ele pede **e-mail → senha → código MFA** (se sua conta tiver).

✅ **Checkpoint:** mensagem de sucesso/tokens salvos.

---

## Qual rota é a sua?

| Sua situação | Rota | O que você ganha |
|---|---|---|
| Primeira vez / não uso OpenCode ainda / quero o treinador **completo** com o mínimo de passos | **[Rota A](#rota-a-o-pacote-do-treinador-recomendada-na-primeira-vez)** (recomendada) | Tudo em uma pasta: conector + habilidades funcionando sozinhos |
| Já uso o OpenCode com outro modelo/projeto / quero os dados do Garmin **em qualquer pasta** | **[Rota B](#rota-b-global-seus-dados-em-qualquer-pasta)** | Conector global em 2 comandos (+ habilidades em 1 passo, se quiser o treinador completo) |
| Quero usar o **Claude** (Desktop/Code), não o OpenCode | **[Rota C](#rota-c-usar-no-claude)** | Seus dados do Garmin no Claude |

> 💡 **A diferença em uma frase:** o conector (dados) pode ser global em qualquer rota; as **habilidades de treinador** (zonas VDOT, análise, treinos, story) são um pacote de arquivos — na Rota A ele já vem pronto na pasta, na Rota B você o instala à mão.

---

## ROTA A — O pacote do treinador (recomendada na primeira vez)

Pense nela como instalar um app: você baixa **uma pasta** uma única vez, e ela passa a ser onde o treinador mora. O OpenCode, ao abrir dentro dela, encontra o conector **e** as habilidades sozinho — sem você configurar nada à mão.

### A.1 — Baixar o pacote (ZIP, sem GitHub, sem Git)

1. Abra o repositório: https://github.com/leonardocroda/garmin_mcp
2. Botão verde **`<> Code`** → **Download ZIP**
3. Clique com o direito → **Extrair tudo…** → extraia em **`C:\garmin-ia`**

> Se o Windows extrair como `garmin_mcp-main`, renomeie a pasta para `garmin-ia`.

✅ **Checkpoint:** dentro de `C:\garmin-ia` existem `pyproject.toml`, `opencode.json` e a pasta `.opencode` (as habilidades de corrida moram lá).

### A.2 — Instalar o conector

```powershell
cd C:\garmin-ia
uv sync
```

Baixa o Python e as dependências do servidor. Pode demorar alguns minutos na primeira vez.

✅ **Checkpoint:** termina sem erro vermelho.

### A.3 — Gerador de imagem (recomendado, ~2 min)

Só quem quer a foto pro story (é o 3º superpoder — vale os 2 minutos):

```powershell
python -m pip install playwright
python -m playwright install chromium
```

✅ **Checkpoint:** o segundo comando baixa o Chromium e termina sem erro.

### A.4 — Abrir a IA dentro da pasta do treinador

O OpenCode descobre o que existe na pasta em que você o abre. Dentro de `C:\garmin-ia`, ele encontra o conector Garmin **e** as habilidades de corrida sozinho:

```powershell
cd C:\garmin-ia
opencode pair     # interface web (abra o link que aparecer)
# ou
opencode          # interface no terminal
```

✅ **Checkpoint:** em outro PowerShell, rode `opencode mcp list` — deve mostrar:

```text
✓ garmin   connected
```

> Se aparecer "connecting" na primeira vez, espere alguns segundos e rode de novo.

**Teste de fumaça 🎉** — na conversa, digite:

```text
pega meu treino de ontem
```

Se a IA responder com os dados reais da sua corrida — funcionou. Ela acabou de buscar seus dados do Garmin sozinha.

### A.5 — Calibrar SUAS zonas (antes da primeira análise)

Suas zonas de ritmo são pessoais: nascem do **seu** último teste. Na conversa:

```text
calibra minhas zonas
```

Ela entrevista você: **qual foi seu último teste** (5K, 10K, meia…) → **tempo** → **data**. Calcula seu VDOT (método Jack Daniels) e salva suas 5 zonas num arquivo que fica só no seu PC (`vdot_zones.json`). Todas as análises passam a usar essas zonas.

> 🏃 Sem teste recente? Vale qualquer resultado cronometrado honesto — 10K serve, 5K serve. Quando fizer um teste novo, é só pedir "calibra minhas zonas" de novo.
> 📄 O arquivo de exemplo `vdot_zones.example.json` na pasta da habilidade mostra o formato, com dados fictícios (VDOT 45).

### A.6 — A rotina (as frases mágicas)

| Você digita | A IA faz |
|---|---|
| `avalia meu treino de hoje` | Busca a corrida, compara km a km com suas zonas, olha sono/HRV/clima e dá o veredito |
| `avalia minha semana` | Review dos 7 dias com carga e sugestões |
| `cria um 5x1km com 2min de recovery pra terça` | Monta o treino com SEU ritmo de intervalo e joga no calendário do Garmin |
| `cria 2x3km a threshold com 5min recovery, sábado` | Idem, no seu ritmo de limiar |
| `gera a imagem do treino de hoje` | Monta a foto 1080×1920 pro story, com gráfico de ritmo e coração |

Depois de sincronizar, os treinos criados aparecem no calendário do relógio. No dia, é apertar play — o relógio apita cada série no ritmo certo.

> 💡 **Quer isso funcionando em qualquer pasta, não só em `C:\garmin-ia`?** Depois que tudo estiver rodando, dá pra globalizar o conector e as habilidades com a [Rota B](#rota-b-global-seus-dados-em-qualquer-pasta) — sem perder nada do que você já configurou.

---

## ROTA B — Global: seus dados em qualquer pasta

> **Pré-requisito:** a [Preparação](#preparacao) acima (Python, uv e login do Garmin feitos).
>
> **O que esta rota entrega sozinha:** o conector — você conversa com seus dados do Garmin em **qualquer pasta** do OpenCode. **O treinador completo** (análise com suas zonas VDOT, treinos com seu ritmo, foto do story) vem das habilidades do passo B.3 — sem elas, a análise fica genérica e a imagem do story não existe.

**B.1 — Aquecer o cache (evita timeout na primeira conexão):**

```powershell
uvx --python 3.12 --from git+https://github.com/leonardocroda/garmin_mcp garmin-mcp
```

Espere aparecer o log de inicialização (algo como "Trying to login…") e feche com `Ctrl+C`.

**B.2 — Adicionar o servidor globalmente:**

```powershell
opencode mcp add garmin --global -- uvx --python 3.12 --from git+https://github.com/leonardocroda/garmin_mcp garmin-mcp
opencode mcp list
```

✅ **Checkpoint:** `opencode mcp list` mostra `✓ garmin connected` — em qualquer projeto. Teste: `pega meu treino de ontem`.

**B.3 — As habilidades de treinador (recomendado):**

1. Baixe o pacote e extraia em `C:\garmin-ia` como no [Passo A.1](#a1-baixar-o-pacote-zip-sem-github-sem-git)
2. Copie as habilidades para a pasta global do OpenCode:

```powershell
Copy-Item -Recurse C:\garmin-ia\.opencode\skills\* "$env:USERPROFILE\.config\opencode\skills\"
```

✅ **Checkpoint:** em qualquer projeto, peça `avalia meu treino de hoje` — na primeira vez a IA pede para calibrar suas zonas (comportamento correto: `calibra minhas zonas`).

**B.4 — Gerador de imagem (se quiser o story):**

```powershell
python -m pip install playwright
python -m playwright install chromium
```

---

## ROTA C — Usar no Claude

O conector é um servidor MCP padrão: funciona no Claude Desktop (e Claude Code) igual ao OpenCode. O que muda é só onde você cola a configuração.

> 💡 Fez a [Preparação](#preparacao) acima? O login do Garmin já está feito — pule direto para a instalação. Se veio direto pra esta rota, autentique primeiro:

```powershell
uvx --python 3.12 --from git+https://github.com/Taxuspt/garmin_mcp garmin-mcp-auth
```

**Opção 1 — Claude Desktop, instalação com 1 clique (recomendada):**

1. Baixe `garmin-mcp.dxt` em https://github.com/Taxuspt/garmin_mcp/releases
2. Arraste o arquivo para a janela do Claude Desktop (ou Settings → Extensions → Install Extension)
3. Se ele pedir e-mail/senha na configuração, pode deixar em branco — você já se autenticou no passo acima

**Opção 2 — Claude Desktop, configuração manual:**

Edite `%APPDATA%\Claude\claude_desktop_config.json` (Settings → Developer → Edit Config):

```json
{
  "mcpServers": {
    "garmin": {
      "command": "uvx",
      "args": [
        "--python", "3.12",
        "--from", "git+https://github.com/leonardocroda/garmin_mcp",
        "garmin-mcp"
      ]
    }
  }
}
```

**Depois de qualquer opção:** feche o Claude Desktop **completamente** (quit, não só fechar a janela) e abra de novo.

✅ **Checkpoint:** no Claude, no ícone de conectores da caixa de mensagem, o **garmin** aparece com as ferramentas dele (peça "pega meu treino de ontem").

**Claude Code (terminal):** `claude mcp add garmin -- uvx --python 3.12 --from git+https://github.com/leonardocroda/garmin_mcp garmin-mcp`

> ℹ️ **Duas notas honestas sobre o Claude:**
> - No claude.ai (web) os "connectors" só aceitam servidores MCP **remotos** com URL pública — o conector local do seu PC não conecta lá. Funciona no Claude Desktop e Claude Code, que rodam na sua máquina
> - As 4 habilidades de corrida prontas são carregadas pelo OpenCode. No Claude você conversa com seus dados do Garmin normalmente (peça a análise na conversa) — mas as instruções "de treinador" não vêm de fábrica

---

## Deu ruim?

| Sintoma | Solução |
|---|---|
| "uv não é reconhecido" / "python não é reconhecido" | Feche **todas** as janelas do PowerShell e abra uma nova |
| Login Garmin recusado | Confira a senha em https://connect.garmin.com primeiro; com MFA, use o código que o Garmin manda na hora |
| Garmin parou de responder depois de meses | Token expirou (~6 meses): rode o login da Preparação com `--force-reauth` no fim |
| `opencode mcp list` mostra o garmin como connecting/não conecta | Primeira execução baixa o servidor — rode o aquecimento da Rota B e tente de novo. Se persistir, rode o opencode de dentro de `C:\garmin-ia` |
| Conecta (`✓ garmin connected`), mas toda chamada trava em "Request timed out" | Seu `opencode.json` é de uma versão antiga, com timeout de 30s por requisição — baixe o ZIP de novo (Passo A.1) e extraia por cima, ou use a [Rota B](#rota-b-global-seus-dados-em-qualquer-pasta) |
| A IA diz que não encontrou as zonas | Você ainda não calibrou — rode `calibra minhas zonas` (Passo A.5) |
| A geração de imagem falha | Falta o Playwright — rode o Passo A.3 (ou B.4) |
| Windows bloqueou o `uv` (Smart App Control) | Siga [esta seção do README do projeto](https://github.com/leonardocroda/garmin_mcp#windows-smart-app-control-blocks-uv--uvx) |
| Erro 429 (limite de requisições) | Espere ~1 min ou troque de modelo no seletor — detalhes no [Tutorial 2](./tutorial-2-nvidia-modelos.md) |

---

## FAQ

**Preciso fazer tudo isso toda vez que treinar?**
Não. No dia a dia (Rota A): `cd C:\garmin-ia` → `opencode pair` → conversa. Na Rota B, abra o OpenCode em qualquer pasta e converse. O login do Garmin vale ~6 meses.

**Quanto custa?**
R$0: conector open source + free tier da NVIDIA — sem cota mensal de tokens, com limite de ~40 requisições/min por modelo (detalhes no [Tutorial 2](./tutorial-2-nvidia-modelos.md)). Se um dia quiser mais, dá pra trocar de provedor sem mexer em nada do que você configurou.

**Meus dados estão seguros?**
Login do Garmin: tokens só no seu PC. API da NVIDIA: só a chave, no seu PC. Os dados que você pede para analisar passam pela API do modelo — como qualquer IA em nuvem. Se um dia quiser privacidade total, dá para rodar modelos locais (Ollama) no lugar.

**Funciona no celular?**
A IA roda no PC. Da pra usar a interface pelo celular na mesma rede: rode `opencode serve --hostname 0.0.0.0 --port 4096` dentro da pasta, descubra o IP do PC com `ipconfig` e abra `http://SEU-IP:4096` no navegador do celular. (Só na sua rede doméstica — o PC precisa ficar ligado.)

**E Mac/Linux?**
Funciona com pequenos ajustes (o [README do projeto](https://github.com/leonardocroda/garmin_mcp) cobre). Este guia é Windows porque é onde todo o fluxo foi testado ponta a ponta.

**Atualizou as habilidades — como pego a versão nova?**
Baixe o ZIP de novo (Passo A.1) e extraia por cima (Rota B: re-copie as habilidades do passo B.3). Suas zonas ficam no seu `vdot_zones.json` — só recalibre se quiser.

---

## Créditos

- Conector (MCP): [Taxuspt/garmin_mcp](https://github.com/Taxuspt/garmin_mcp), via [python-garminconnect](https://github.com/cyberjunky/python-garminconnect)
- Habilidades de corrida (zonas VDOT, análise, treinos, imagem do story): [@leonardocroda](https://github.com/leonardocroda) — [fork com as skills](https://github.com/leonardocroda/garmin_mcp)
- Zonas: método VDOT de *Jack Daniels' Running Formula*
- Série: Tutorial 1 (OpenCode) → Tutorial 2 (NVIDIA) → Tutorial 3 (este)
