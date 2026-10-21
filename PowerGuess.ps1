# PowerGuess.ps1
# Author: Ryan Tagen
# CSEC-473 Cyber Defense Techniques
# Interrupts a PowerShell session with occasional number challenges

$global:AnnoyanceCommandCount = 0

# save the prompt that was already configured.
$global:AnnoyanceOriginalPrompt = (Get-Command prompt -CommandType Function -ErrorAction SilentlyContinue).ScriptBlock

function global:prompt {
    $global:AnnoyanceCommandCount++

    if ($global:AnnoyanceCommandCount -ge 10) {
        $global:AnnoyanceCommandCount = 0

        $secret = Get-Random -Minimum 1 -Maximum 11
        $answer = Read-Host "Guess a number from 1 to 10!"

        if ($answer -notmatch '^(10|[1-9])$' -or [int]$answer -ne $secret) {
            Write-Host "Incorrect! Closing this PowerShell session." -ForegroundColor Red
            exit
        }

        Write-Host "Correct! Continue working." -ForegroundColor Green
    }

    if ($global:AnnoyanceOriginalPrompt) {
        & $global:AnnoyanceOriginalPrompt
    } else {
        "PS $($executionContext.SessionState.Path.CurrentLocation)> "
    }
}
