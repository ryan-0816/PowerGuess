# PowerGuess.ps1
# CSEC-473 Cyber Defense Techniques
# Interactive command-counting demonstration

$ErrorActionPreference = "Continue"
$count = 0
$limit = 10

Write-Host "GuessAndCheck started. Type 'exit' to quit." -ForegroundColor Cyan

while ($true) {
    $command = Read-Host "PS $((Get-Location).Path)>"

    if ([string]::IsNullOrWhiteSpace($command)) {
        continue
    }

    if ($command -eq "exit") {
        Write-Host "67" -ForegroundColor Red
        continue
    }

    $count++

    if ($count -ge $limit) {
        $count = 0
        $secret = Get-Random -Minimum 1 -Maximum 11

        Write-Host "Guess a number from 1 to 10!" -ForegroundColor Red
        $answer = Read-Host

        if ($answer -notmatch '^(10|[1-9])$' -or
            [int]$answer -ne $secret) {
            Write-Host "Wrong! Closing PowerShell." -ForegroundColor Red
            Start-Sleep -Seconds 1
            Stop-Process -Id $PID
        }

        Write-Host "Correct! Continue working." -ForegroundColor Green
    }

    try {
        Invoke-Expression $command
    }
    catch {
        Write-Host $_ -ForegroundColor Red
    }
}