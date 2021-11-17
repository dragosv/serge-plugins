$ErrorActionPreference = "Stop"
Write-Host "Running tests for project $env:APPVEYOR_PROJECT_NAME"

cd "C:/projects/$env:APPVEYOR_PROJECT_NAME"

perl build-bin/dzil-plugins.pl -c test