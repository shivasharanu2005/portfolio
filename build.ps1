<#
Simple build script for the portfolio.
Usage: In PowerShell run: ./build.ps1
This will create/replace the `dist` folder and produce `deploy.zip`.
#>
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ScriptDir

$files = @('sk.portfolio.html','gmail.html')
$dist = Join-Path $ScriptDir 'dist'

if (Test-Path $dist) { Remove-Item $dist -Recurse -Force }
New-Item -Path $dist -ItemType Directory | Out-Null

Write-Output "Building into: $dist"

foreach ($f in $files) {
    $src = Join-Path $ScriptDir $f
    if (-not (Test-Path $src)) { Write-Warning "$f not found, skipping."; continue }
    $content = Get-Content $src -Raw -ErrorAction Stop
    # Remove HTML comments, collapse multiple whitespace and remove whitespace between tags
    $min = $content -replace '<!--(?s).*?-->','' -replace '\s{2,}',' ' -replace '>\s+<','><'
    $out = Join-Path $dist $f
    Set-Content -Path $out -Value $min -Encoding UTF8
    Write-Output "Wrote: $out"
}

# Ensure there's an index.html for static hosts (copy main portfolio)
$main = Join-Path $dist 'sk.portfolio.html'
if (Test-Path $main) {
    Copy-Item -Path $main -Destination (Join-Path $dist 'index.html') -Force
    Write-Output "Wrote: $dist\index.html"
}

$zip = Join-Path $ScriptDir 'deploy.zip'
if (Test-Path $zip) { Remove-Item $zip -Force }
Compress-Archive -Path (Join-Path $dist '*') -DestinationPath $zip -Force
Write-Output "Created archive: $zip"

Write-Output "Build complete. To preview: run './serve.ps1' or serve the 'dist' folder with any static server."
