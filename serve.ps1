<#
Serve the `dist` folder on localhost:8000 using Python if available.
Usage: ./serve.ps1
#>
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ScriptDir

$dist = Join-Path $ScriptDir 'dist'
if (-not (Test-Path $dist)) { Write-Error "dist not found. Run .\build.ps1 first."; exit 1 }

if (Get-Command python -ErrorAction SilentlyContinue) {
    Write-Output "Serving $dist at http://localhost:8000"
    Push-Location $dist
    & python -m http.server 8000
    Pop-Location
} else {
    Write-Output "Python not found. Install Python or use VS Code Live Server to preview the 'dist' folder."
}
