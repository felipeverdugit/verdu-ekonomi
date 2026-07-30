# deploy.ps1 — Regenerera och publicera alla tre sidor till GitHub Pages
# Kör med: .\deploy.ps1

$ErrorActionPreference = "Stop"

Write-Host "1/3  Genererar fire-rapport.html..." -ForegroundColor Cyan
py -3 "D:\arcgis\tjänstepension-pension\fire-rapport\generate_rapport_interaktiv.py"

Write-Host "2/3  Kopierar ekonomi.html och historik.html..." -ForegroundColor Cyan
Copy-Item "D:\arcgis\minaegnagrejer\fire-rapport\ekonomi.html"  "D:\arcgis\verdu-ekonomi\ekonomi.html"  -Force
Copy-Item "D:\arcgis\minaegnagrejer\fire-rapport\historik.html" "D:\arcgis\verdu-ekonomi\historik.html" -Force

Write-Host "3/3  Pushar till GitHub..." -ForegroundColor Cyan
Set-Location "D:\arcgis\verdu-ekonomi"
git add ekonomi.html fire-rapport.html historik.html
$changes = git status --porcelain
if ($changes) {
    git commit -m "Deploy: update HTML files $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    git push
    Write-Host "Klart! Live om ~1 minut på:" -ForegroundColor Green
} else {
    Write-Host "Inga ändringar — inget att pusha." -ForegroundColor Yellow
}

Write-Host "  https://felipeverdugit.github.io/verdu-ekonomi/ekonomi.html" -ForegroundColor Green
Write-Host "  https://felipeverdugit.github.io/verdu-ekonomi/fire-rapport.html" -ForegroundColor Green
Write-Host "  https://felipeverdugit.github.io/verdu-ekonomi/historik.html" -ForegroundColor Green
