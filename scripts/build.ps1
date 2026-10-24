param(
    [string]$UV4 = 'D:\Keil_v5\UV4\UV4.exe'
)

$ErrorActionPreference = 'Stop'
$r01Root = Split-Path -Parent $PSScriptRoot
$r01Project = Join-Path $r01Root 'firmware\SmartHomeDemo\MDK-ARM\SmartHomeDemo.uvprojx'
$r01Output = Join-Path $r01Root 'artifacts'
$r01Log = Join-Path $r01Output 'keil-build.log'
if (-not (Test-Path -LiteralPath $UV4 -PathType Leaf)) {
    throw "Keil executable not found: $UV4. Supply -UV4 with your installation path."
}
if (-not (Test-Path -LiteralPath $r01Project -PathType Leaf)) {
    throw "Keil project not found: $r01Project"
}
New-Item -ItemType Directory -Path $r01Output -Force | Out-Null
if (Test-Path -LiteralPath $r01Log) { Remove-Item -LiteralPath $r01Log }
$r01Process = Start-Process -FilePath $UV4 -ArgumentList @(
    '-r', ('"' + $r01Project + '"'), '-j0', '-t', 'SmartHomeDemo',
    '-o', ('"' + $r01Log + '"')
) -WindowStyle Hidden -Wait -PassThru
if (-not (Test-Path -LiteralPath $r01Log)) {
    throw "Keil did not produce a build log. Exit code: $($r01Process.ExitCode)"
}
$r01BuildText = Get-Content -LiteralPath $r01Log -Raw
Write-Output $r01BuildText
if ($r01Process.ExitCode -ne 0 -or
    $r01BuildText -notmatch '0 Error\(s\), 0 Warning\(s\)') {
    throw "Keil build did not pass with zero errors and warnings. Exit code: $($r01Process.ExitCode)"
}
$r01Firmware = Join-Path $r01Root 'firmware\SmartHomeDemo\MDK-ARM\SmartHomeDemo\SmartHomeDemo.hex'
if (-not (Test-Path -LiteralPath $r01Firmware -PathType Leaf)) {
    throw "Build reported success but HEX file is missing: $r01Firmware"
}
Write-Output "Build verified. HEX: $r01Firmware"
