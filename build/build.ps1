$ErrorActionPreference = "Stop"
Write-Host "Building project $env:APPVEYOR_PROJECT_NAME"

cd "C:/projects/$env:APPVEYOR_PROJECT_NAME"

perl build-bin/dzil-plugins.pl -c build