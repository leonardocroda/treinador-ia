# Tutorial 2 — Modelos melhores, de graça: NVIDIA NIM no OpenCode

> Parte 2 de 3 da série "Seu treinador de IA de corrida".
> Pré-requisito: [Tutorial 1](./tutorial-1-opencode-do-zero.md) (OpenCode instalado e abrindo).
> ⏱ Tempo: ~10 min · 💰 Custo: R$0

**Ao final você terá:** modelos de IA mais capazes que os do trial gratuito do OpenCode, sem os limites curtos de uso — conectados à sua conta, escolhidos por você, prontos para o dia a dia.

---

## Por que a NVIDIA? (30 segundos)

O trial do OpenCode é ótimo para degustar, mas os modelos Free têm limites de uso curtos e o catálogo gira (modelos entram e saem). A alternativa que uso no dia a dia é a **NVIDIA NIM** ([build.nvidia.com](https://build.nvidia.com)):

| | Trial do OpenCode | NVIDIA NIM |
|---|---|---|
| Modelos | Free com rate limit curto | GLM 5.3, Kimi K2.6, DeepSeek V4, Nemotron… |
| Limites | Curtos, para degustar | ~40 requisições/min por modelo, sem cota mensal de tokens |
| Catálogo | Gira com o tempo | Você escolhe e ele fica lá |
| Setup | API key do console | API key da NVIDIA (2 min) |

---

## Passo 1 — Criar conta na NVIDIA e gerar sua API key

1. Acesse https://build.nvidia.com e crie sua conta (login social ou e-mail — a NVIDIA pede verificação por SMS; número de telefone, sem cartão de crédito)
2. Vá em **API Keys** → **Generate API Key** (Generate API Key)
3. Dê um nome (ex.: `opencode`) e, se pedir, um prazo de expiração
4. **Copie a chave imediatamente** — ela começa com `nvapi-` e é mostrada uma única vez

✅ **Checkpoint:** a chave copiada começa com `nvapi-` e está na sua área de transferência.

---

## Passo 2 — Conectar a NVIDIA no OpenCode

**Na interface web (o caminho mais simples):**

1. Abra o seletor de modelos e clique em **Connect provider** (Conectar provedor)
2. Busque **nvidia**
3. Cole a API key (`nvapi-…`) e confirme
4. Os modelos da NVIDIA aparecem no seletor

**Ou no terminal:**

```text
/connect
# → escolha NVIDIA → cole a API key

/models
# → escolha um modelo nvidia/...
```

✅ **Checkpoint:** pergunte à IA "qual modelo você é?" — ela deve se identificar como um dos modelos NVIDIA (ex.: GLM, Kimi, Nemotron).

---

## Passo 3 — Escolher seu modelo de trabalho

No seletor de modelos, alguns pontos de partida testados e bons para o uso da série (análise de treinos, conversa, tarefas no PC):

- **GLM 5.3** (`zai/glm-5.3`) — forte em raciocínio e análise; é o que uso no dia a dia
- **Kimi K2.6** (`moonshotai/kimi-k2.6`) — respostas rápidas
- **Nemotron** (`nvidia/nemotron-…`) — a família da própria NVIDIA

> 💡 Não existe "o melhor" — existe o melhor para o seu uso. Teste dois ou três nos primeiros dias e fique com um. O modelo fica salvo na sua conta; trocar depois é só abrir o seletor de novo.

---

## Uma nota honesta sobre dados e limites

- **Não são créditos — é rate limit.** A NVIDIA encerrou o antigo modelo de créditos: o free tier roda hoje com um limite de **~40 requisições por minuto por modelo** (o número exato aparece na sua conta, no topo do build.nvidia.com, e pode variar com o modelo e o tráfego do momento) e **sem cota mensal de tokens**. Uso pessoal de análise de treinos raramente chega perto disso
- **Se estourar (erro 429):** espere um minuto ou troque de modelo no seletor — cada modelo tem o próprio limite, e a análise segue em outro tão bom quanto
- **O free tier é para uso de desenvolvimento/pessoal.** Uso comercial/produção exige licença da NVIDIA — irrelevante para analisar seus treinos, mas é o combinado
- **Privacidade:** os endpoints de teste operam em modo avaliação: a NVIDIA registra o uso para melhorar o serviço (não para treinar modelos). Dados de treino são de baixa sensibilidade, mas se for passar algo realmente confidencial, use um endpoint pago ou um modelo local
- **Sua API key fica salva no OpenCode, no seu PC** — não compartilhe-a nem cole em sites

---

## Deu ruim?

| Sintoma | Solução |
|---|---|
| Erro 401/403 ao conversar | Chave inválida ou expirada — gere outra em build.nvidia.com e reconecte |
| "NVIDIA" não aparece na busca de provedores | Atualize o OpenCode: `npm update -g @opencode/cli` |
| A chave foi recusada ao colar | Copie de novo, sem espaços antes/depois (`nvapi-` até o fim) |
| Erro 429 / resposta travou no meio | Você atingiu o limite de requisições do minuto — espere ~1 min ou troque de modelo no seletor |

---

## Próximo passo

- **[Tutorial 3 — Conecte seu Garmin: a IA que conhece seus treinos](tutorial-3-garmin-mcp.md)** → o motivo desta série existir
