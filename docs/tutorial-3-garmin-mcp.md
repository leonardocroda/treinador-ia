# Tutorial 3 — Conecte seu Garmin à IA: a IA que conhece seus treinos

> Parte 3 de 3 da série "Seu treinador de IA de corrida".
> Pré-requisitos: [Tutorial 1](./tutorial-1-opencode-do-zero.md) (OpenCode instalado) e [Tutorial 2](./tutorial-2-nvidia-modelos.md) (modelo conectado).
> ⏱ Tempo: ~30 min · 💰 Custo: R$0
> **Prefere tudo numa pasta só, sem instalar nada global?** Veja a [Rota B](#rota-b).
> **Quer usar o Claude em vez do OpenCode?** Vá para a [Rota C](#rota-c).

**Ao final você terá uma IA que, sozinha:**

- 🔥 **Avalia seu treino do dia** — busca a corrida no Garmin, compara km a km com **suas zonas pessoais** (calibradas no seu último teste) e olha sono, HRV e clima antes de dar o veredito
- 🗓️ **Monta treinos e joga no calendário do Garmin** — "cria um 5x1km com 2min de recovery pra terça" aparece no seu relógio
- 📸 **Gera a foto do treino pronta pro story** — 1080×1920, com gráfico de ritmo e coração

Tudo por conversa, no navegador — **funcionando em qualquer pasta** do OpenCode.

---

## Como funciona (30 segundos)

Três peças conversando:

1. **Seus dados no Garmin Connect** — treinos, sono, HRV, zonas. Continuam no Garmin.
2. **Um conector open source** ([garmin_mcp](https://github.com/Taxuspt/garmin_mcp)) no seu PC que dá à IA acesso de leitura (e criação de treinos) — o "MCP" é só o nome do protocolo que permite isso. Seu login do Garmin fica **só no seu computador**.
3. **A IA** (OpenCode + o modelo que você conectou no Tutorial 2), que agora sabe buscar seus dados quando você pede.

Além do conector, existem **4 habilidades de corrida** prontas — as instruções que ensinam a IA a ser treinadora (calibrar zonas VDOT, avaliar treino contra elas, criar treinos, gerar a imagem do story). É o que separa "uma IA com seus dados" de "um treinador".

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

## Qual rota é a sua? {: #qual-rota }

| Sua situação | Rota | O que você ganha |
|---|---|---|
| Quero o mais simples possível / uso o OpenCode onde der / primeira vez | **[Rota A](#rota-a)** (recomendada) | Treinador instalado globalmente — funciona em qualquer pasta, 4 comandos de colar |
| Prefiro tudo isolado **numa única pasta** (fácil de apagar depois) | **[Rota B](#rota-b)** | O mesmo treinador, morando num diretório só |
| Quero usar o **Claude** (Desktop/Code), não o OpenCode | **[Rota C](#rota-c)** | Seus dados do Garmin no Claude |

> 💡 **A diferença em uma frase:** as duas primeiras rotas instalam exatamente o mesmo conjunto (conector + habilidades). A A deixa o OpenCode enxergar isso em qualquer pasta; a B concentra tudo num diretório. Escolha pela preferência — o resultado do dia a dia é o mesmo.

---

## ROTA A — Instalação global (a mais simples) {: #rota-a }

A partir daqui, seu treinador está disponível no OpenCode **em qualquer pasta** — você abre onde estiver trabalhando e conversa.

### A.1 — Conectar o Garmin ao OpenCode

Primeiro, um aquecimento (baixa o conector e evita timeout na primeira conexão):

```powershell
uvx --python 3.12 --from git+https://github.com/leonardocroda/garmin_mcp garmin-mcp
```

Espere aparecer o log de inicialização (algo como "Trying to login…") e feche com `Ctrl+C`.

Agora, o registro global:

```powershell
opencode mcp add garmin --global -- uvx --python 3.12 --from git+https://github.com/leonardocroda/garmin_mcp garmin-mcp
opencode mcp list
```

✅ **Checkpoint:** `opencode mcp list` mostra:

```text
✓ garmin   connected
```

### A.2 — Instalar as habilidades do treinador

Um comando — baixa e instala as 4 habilidades (calibrar zonas, analisar treino, criar treinos, gerar a foto do story) na pasta global do OpenCode:

```powershell
iex ((New-Object Net.WebClient).DownloadString("https://leonardocroda.github.io/treinador-ia/install-skills.ps1"))
```

✅ **Checkpoint:** o script lista as habilidades instaladas (`analyze-garmin-run`, `calibrate-garmin-zones`, `create-garmin-training`, `generate-run-summary-image`) e a pasta delas.

> 🔍 **Transparência:** não gosta de colar comandos às cegas? Justo. Este script só baixa o repositório de origem e copia a pasta `.opencode/skills` para `%USERPROFILE%\.config\opencode\skills` — [leia o código-fonte aqui](https://github.com/leonardocroda/treinador-ia/blob/main/docs/install-skills.ps1) (é curto). Para remover depois: apague essa pasta.

### A.3 — Gerador de imagem (recomendado, ~2 min)

Só quem quer a foto pro story (é o 3º superpoder — vale os 2 minutos):

```powershell
python -m pip install playwright
python -m playwright install chromium
```

✅ **Checkpoint:** o segundo comando baixa o Chromium e termina sem erro.

### A.4 — Teste de fumaça 🎉

Abra o OpenCode **em qualquer pasta** (só não dentro da instalação dele):

```powershell
opencode pair     # interface web (abra o link que aparecer)
# ou
opencode          # interface no terminal
```

Na conversa, digite:

```text
pega meu treino de ontem
```

Se a IA responder com os dados reais da sua corrida — funcionou. Ela acabou de buscar seus dados do Garmin sozinha.

### A.5 — Calibrar SUAS zonas (antes da primeira análise)

Suas zonas de ritmo são pessoais: nascem do **seu** último teste. Na conversa:

```text
calibra minhas zonas
```

Ela entrevista você: **qual foi seu último teste** (5K, 10K, meia…) → **tempo** → **data**. Calcula seu VDOT (método Jack Daniels) e salva suas 5 zonas num arquivo que fica só no seu PC. Todas as análises passam a usar essas zonas.

> 🏃 Sem teste recente? Vale qualquer resultado cronometrado honesto — 10K serve, 5K serve. Quando fizer um teste novo, é só pedir "calibra minhas zonas" de novo.

### A.6 — A rotina (as frases mágicas)

| Você digita | A IA faz |
|---|---|
| `avalia meu treino de hoje` | Busca a corrida, compara km a km com suas zonas, olha sono/HRV/clima e dá o veredito |
| `avalia minha semana` | Review dos 7 dias com carga e sugestões |
| `cria um 5x1km com 2min de recovery pra terça` | Monta o treino com SEU ritmo de intervalo e joga no calendário do Garmin |
| `cria 2x3km a threshold com 5min recovery, sábado` | Idem, no seu ritmo de limiar |
| `gera a imagem do treino de hoje` | Monta a foto 1080×1920 pro story, com gráfico de ritmo e coração |

Depois de sincronizar, os treinos criados aparecem no calendário do relógio. No dia, é apertar play — o relógio apita cada série no ritmo certo.

---

## ROTA B — Pacote do treinador (tudo numa pasta) {: #rota-b }

A mesma experiência da Rota A, mas tudo mora num único diretório — e some do sistema se você apagá-lo. Pense como instalar um app: você baixa **uma pasta** uma única vez, e ela passa a ser onde o treinador mora. O OpenCode, ao abrir dentro dela, encontra o conector **e** as habilidades sozinho.

> **Pré-requisito:** a [Preparação](#preparacao) acima (Python, uv e login do Garmin feitos).

### B.1 — Baixar o pacote (ZIP, sem GitHub, sem Git)

1. Abra o repositório: https://github.com/leonardocroda/garmin_mcp
2. Botão verde **`<> Code`** → **Download ZIP**
3. Clique com o direito → **Extrair tudo…** → extraia em **`C:\garmin-ia`**

> Se o Windows extrair como `garmin_mcp-main`, renomeie a pasta para `garmin-ia`.

✅ **Checkpoint:** dentro de `C:\garmin-ia` existem `pyproject.toml`, `opencode.json` e a pasta `.opencode` (as habilidades de corrida moram lá).

### B.2 — Instalar o conector

```powershell
cd C:\garmin-ia
uv sync
```

Baixa o Python e as dependências do servidor. Pode demorar alguns minutos na primeira vez.

✅ **Checkpoint:** termina sem erro vermelho.

### B.3 — Gerador de imagem (recomendado)

Os mesmos dois comandos da Rota A — [Passo A.3](#a3-gerador-de-imagem-recomendado-2-min).

### B.4 — Abrir a IA dentro da pasta do treinador

```powershell
cd C:\garmin-ia
opencode pair     # interface web (abra o link que aparecer)
# ou
opencode          # interface no terminal
```

✅ **Checkpoint:** em outro PowerShell, rode `opencode mcp list` — deve mostrar `✓ garmin connected`. Teste de fumaça: peça `pega meu treino de ontem`.

**Zonas e rotina:** idênticas à [Rota A](#rota-a) — [A.5](#a5-calibrar-suas-zonas-antes-da-primeira-analise) e [A.6](#a6-a-rotina-as-frases-magicas).

> 💡 **Mudou de ideia e quer isso em qualquer pasta?** Rode a [Rota A](#rota-a) depois — nada do que você configurou aqui se perde.

---

## ROTA C — Usar no Claude {: #rota-c }

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

## Deu ruim? {: #deu-ruim }

| Sintoma | Solução |
|---|---|
| "uv não é reconhecido" / "python não é reconhecido" | Feche **todas** as janelas do PowerShell e abra uma nova |
| Login Garmin recusado | Confira a senha em https://connect.garmin.com primeiro; com MFA, use o código que o Garmin manda na hora |
| Garmin parou de responder depois de meses | Token expirou (~6 meses): rode o login da Preparação com `--force-reauth` no fim |
| `opencode mcp list` mostra o garmin como connecting/não conecta | Primeira execução baixa o servidor — rode o aquecimento do Passo A.1 e tente de novo |
| Conecta (`✓ garmin connected`), mas toda chamada trava em "Request timed out" | Seu `opencode.json` é de uma versão antiga, com timeout de 30s por requisição — baixe o ZIP de novo (Passo B.1), extraia por cima, ou migre para a [Rota A](#rota-a) (global, sem esse arquivo) |
| O instalador de habilidades (A.2) falhou | Rode de novo; se persistir, siga a [Rota B](#rota-b) (as habilidades vêm dentro da pasta) |
| A IA diz que não encontrou as zonas | Você ainda não calibrou — rode `calibra minhas zonas` (Passo A.5) |
| A geração de imagem falha | Falta o Playwright — rode o Passo A.3 |
| Windows bloqueou o `uv` (Smart App Control) | Siga [esta seção do README do projeto](https://github.com/leonardocroda/garmin_mcp#windows-smart-app-control-blocks-uv--uvx) |
| Erro 429 (limite de requisições) | Espere ~1 min ou troque de modelo no seletor — detalhes no [Tutorial 2](./tutorial-2-nvidia-modelos.md) |

---

## FAQ {: #faq }

**Preciso fazer tudo isso toda vez que treinar?**
Não. Rota A: abra o OpenCode em qualquer pasta e converse. Rota B: `cd C:\garmin-ia` → `opencode pair`. O login do Garmin vale ~6 meses.

**Quanto custa?**
R$0: conector open source + free tier da NVIDIA — sem cota mensal de tokens, com limite de ~40 requisições/min por modelo (detalhes no [Tutorial 2](./tutorial-2-nvidia-modelos.md)). Se um dia quiser mais, dá pra trocar de provedor sem mexer em nada do que você configurou.

**Meus dados estão seguros?**
Login do Garmin: tokens só no seu PC. API da NVIDIA: só a chave, no seu PC. Os dados que você pede para analisar passam pela API do modelo — como qualquer IA em nuvem. Se um dia quiser privacidade total, dá para rodar modelos locais (Ollama) no lugar.

**Funciona no celular?**
A IA roda no PC. Da pra usar a interface pelo celular na mesma rede: rode `opencode serve --hostname 0.0.0.0 --port 4096`, descubra o IP do PC com `ipconfig` e abra `http://SEU-IP:4096` no navegador do celular. (Só na sua rede doméstica — o PC precisa ficar ligado.)

**E Mac/Linux?**
Funciona com pequenos ajustes (o [README do projeto](https://github.com/leonardocroda/garmin_mcp) cobre). Este guia é Windows porque é onde todo o fluxo foi testado ponta a ponta.

**Atualizou as habilidades — como pego a versão nova?**
Rota A: rode o comando do Passo A.2 de novo (ele sobrescreve). Rota B: baixe o ZIP de novo (Passo B.1) e extraia por cima. Suas zonas ficam no seu `vdot_zones.json` — só recalibre se quiser.

**Como desinstalo tudo?**
Rota A: apague a pasta `%USERPROFILE%\.config\opencode\skills` e o bloco `garmin` dentro de `%USERPROFILE%\.config\opencode\opencode.json`. Rota B: apague a pasta `C:\garmin-ia`. O login do Garmin mora em `~/.garminconnect`, se quiser remover também.

---

## Créditos

- Conector (MCP): [Taxuspt/garmin_mcp](https://github.com/Taxuspt/garmin_mcp), via [python-garminconnect](https://github.com/cyberjunky/python-garminconnect)
- Habilidades de corrida (zonas VDOT, análise, treinos, imagem do story): [@leonardocroda](https://github.com/leonardocroda) — [fork com as skills](https://github.com/leonardocroda/garmin_mcp)
- Zonas: método VDOT de *Jack Daniels' Running Formula*
- Série: Tutorial 1 (OpenCode) → Tutorial 2 (NVIDIA) → Tutorial 3 (este)
