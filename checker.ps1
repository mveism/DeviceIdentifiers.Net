Write-Host "`n🔍 Checking for DeviceLookup.cs and verifying DeviceLookup.Generated.cs location..." -ForegroundColor Cyan

$projectFile = Get-ChildItem -Path . -Recurse -Filter "DeviceIdentifiers.Net.csproj" -File -ErrorAction SilentlyContinue | Select-Object -First 1

if (-not $projectFile) {
    Write-Host "❌ Could not find DeviceIdentifiers.Net.csproj in repository." -ForegroundColor Red
    Write-Host "##[error] Missing DeviceIdentifiers.Net.csproj"
    exit 1
}

$projectDir = $projectFile.Directory.FullName
Write-Host "📁 Project found at:" -NoNewline
Write-Host " $projectDir" -ForegroundColor Green

$generatedFile = Join-Path $projectDir "DeviceLookup.Generated.cs"

if (-not (Test-Path $generatedFile)) {
    Write-Host "❌ Missing DeviceLookup.Generated.cs next to project file:" -ForegroundColor Red
    Write-Host "   $generatedFile" -ForegroundColor Yellow
    Write-Host "##[error] Missing DeviceLookup.Generated.cs"
    exit 1
}

$lookupFiles = Get-ChildItem -Path . -Recurse -Filter "DeviceLookup.cs" -File -ErrorAction SilentlyContinue

if (-not $lookupFiles) {
    Write-Host "❌ No DeviceLookup.cs files found in this repository." -ForegroundColor Red
    Write-Host "##[error] No DeviceLookup.cs found"
    exit 1
}

Write-Host "✅ Found $($lookupFiles.Count) DeviceLookup.cs file(s)." -ForegroundColor Green
Write-Host "✅ Found DeviceLookup.Generated.cs next to project file." -ForegroundColor Green
Write-Host "`n🎉 All checks passed successfully!" -ForegroundColor Cyan