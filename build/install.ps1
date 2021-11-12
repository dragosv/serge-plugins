$ErrorActionPreference = "Stop"

$version=$env:PERL_VERSION
$major,$minor,$build,$revision = $version.split('.')
$srcVersion = $major + '.' + $minor
Write-Host 'Installing Perl ' $srcVersion

If(!(Test-Path "C:\strawberry")) {
    choco install strawberry --version "$version"
}
$env:PATH = "C:\strawberry\perl\bin;C:\strawberry\perl\site\bin;C:\strawberry\c\bin;$env:PATH"
cd "C:\projects\$env:APPVEYOR_PROJECT_NAME"

cpan App::cpanminus

cpanm --installdeps --with-develop --force .
