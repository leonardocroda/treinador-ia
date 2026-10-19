# Instalador das habilidades do "treinador de IA de corrida"
# Fonte das habilidades: github.com/leonardocroda/garmin_mcp (branch main)
# Tutorial: leonardocroda.github.io/treinador-ia
#
# O que faz: baixa o repositório de origem, extrai SOMENTE as habilidades de
# corrida (.opencode/skills) e instala em %USERPROFILE%\.config\opencode\skills.
# Nao mexe em mais nada. Para desinstalar: apague essa pasta.

$ErrorActionPreference = "Stop"

$url  = "https://github.com/leonardocroda/garmin_mcp/archive/refs/heads/main.zip"
$dest = Join-Path $env:USERPROFILE ".config\opencode\skills"
$tmp  = Join-Path $env:TEMP "treinador-ia-install"

function Fail($msg) {
    Write-Host "ERRO: $msg" -ForegroundColor Red
    Write-Host "Abra o tutorial (leonardocroda.github.io/treinador-ia) na secao 'Deu ruim?' ou me chame no Instagram." -ForegroundColor Yellow
    exit 1
}

try {
    Write-Host "Baixando as habilidades do treinador (do GitHub, ~2 MB)..." -ForegroundColor Cyan

    New-Item -ItemType Directory -Force $tmp | Out-Null
    $zip = Join-Path $tmp "garmin-ia.zip"
    Invoke-WebRequest -UseBasicParsing $url -OutFile $zip
    if (-not (Test-Path $zip)) { Fail "o download nao concluiu" }

    $extract = Join-Path $tmp "src"
    Expand-Archive $zip -DestinationPath $extract -Force

    $srcSkills = Join-Path $extract "garmin_mcp-main\.opencode\skills"
    if (-not (Test-Path $srcSkills)) { Fail "a estrutura do pacote mudou - atualize o tutorial" }

    New-Item -ItemType Directory -Force $dest | Out-Null
    Copy-Item -Recurse -Force (Join-Path $srcSkills "*") $dest

    Write-Host ""
    Write-Host "Pronto! Habilidades instaladas em:" -ForegroundColor Green
    Write-Host "  $dest"
    Write-Host ""
    Write-Host "Instaladas:" -ForegroundColor Green
    Get-ChildItem $dest -Directory | ForEach-Object { Write-Host ("  - " + $_.Name) -ForegroundColor Green }
    Write-Host ""
    Write-Host "Teste: abra o OpenCode em QUALQUER pasta e peca 'avalia meu treino de hoje'." -ForegroundColor Cyan
    Write-Host "Na primeira vez ela vai pedir para calibrar suas zonas - e o treinador nasce." -ForegroundColor Cyan
}
finally {
    Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
}
