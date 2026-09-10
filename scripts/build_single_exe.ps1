param(
    [string]$OutputName = "ShadowDepths.exe"
)

$ErrorActionPreference = "Stop"
$rootDir = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$buildDir = Join-Path $rootDir "build\windows\x64\runner\Release"
$sedFile = Join-Path $rootDir ".iexpress_config.sed"
$singleExePath = Join-Path $rootDir $OutputName

Write-Host "=== Building Flutter Windows Release ===" -ForegroundColor Cyan
Push-Location $rootDir
flutter build windows --release
if ($LASTEXITCODE -ne 0) { throw "Flutter build failed" }
Pop-Location

if (!(Test-Path "$buildDir\shadow_depths.exe")) {
    throw "Build output not found at $buildDir\shadow_depths.exe"
}

Write-Host "=== Collecting files ===" -ForegroundColor Cyan
$files = Get-ChildItem -Path $buildDir -Recurse -File |
    ForEach-Object { $_.FullName.Substring($buildDir.TrimEnd('\').Length + 1) }

Write-Host "Found $($files.Count) files to bundle" -ForegroundColor Gray

$sedLines = @(
    "[Version]"
    "Class=IEXPRESS"
    "SEDVersion=3"
    ""
    "[Options]"
    "PackagePurpose=Install"
    "Compress=2"
    "ShowInstallProgramWindow=0"
    "HideExtractAnimation=1"
    "UseLongFileName=1"
    "InsideInstaller=0"
    "Peristed=1"
    "NoRestart=1"
    "NoModification=1"
    "InstallPrompt="
    "DisplayLicense="
    "FinishMessage="
    "TargetName=$OutputName"
    "FriendlyName=Shadow Depths"
    "AppLaunched=shadow_depths.exe"
    "PostInstallCmd=<None>"
    "AdminQuietInstCmd="
    "UserQuietInstCmd="
    "SourceFiles=SourceFiles"
    ""
    "[SourceFiles]"
    "SourceFiles0=$buildDir\"
    ""
    "[SourceFiles0]"
)

foreach ($file in $files) {
    $sedLines += $file
}

$sedContent = $sedLines -join "`r`n"
$sedContent | Set-Content -Path $sedFile -Encoding ASCII -NoNewline

Write-Host "=== Packaging single .exe with IExpress ===" -ForegroundColor Cyan
if (Test-Path $singleExePath) { Remove-Item $singleExePath -Force }

$process = Start-Process -FilePath "iexpress.exe" `
    -ArgumentList "/N", "/Q", "`"$sedFile`"" `
    -Wait -PassThru -NoNewWindow

if ($process.ExitCode -ne 0) {
    throw "IExpress failed with exit code $($process.ExitCode)"
}

if (!(Test-Path $singleExePath)) {
    throw "Single .exe was not created at $singleExePath"
}

$sizeMB = [math]::Round((Get-Item $singleExePath).Length / 1MB, 1)
Write-Host "=== SUCCESS ===" -ForegroundColor Green
Write-Host "Single .exe: $singleExePath ($sizeMB MB)" -ForegroundColor Green
Write-Host "IExpress config cleaned up." -ForegroundColor Gray

Remove-Item $sedFile -Force -ErrorAction SilentlyContinue
