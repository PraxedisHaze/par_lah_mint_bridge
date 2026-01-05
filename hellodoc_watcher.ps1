# hellodoc_watcher.ps1
# The event-driven Watcher for HelloDoc.
# Uses .NET FileSystemWatcher for instant responsiveness.

$logPath = "C:\Users\phaze\games_n_apps\Shared\ETERNAL_CONVERSATION.jsonl"
$enginePath = "C:\Users\phaze\games_n_apps\Loveware\hellodoc_engine.py"

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "C:\Users\phaze\games_n_apps\Shared"
$watcher.Filter = "ETERNAL_CONVERSATION.jsonl"
$watcher.NotifyFilter = [System.IO.NotifyFilters]::LastWrite

$action = {
    $path = $Event.SourceEventArgs.FullPath
    Write-Host "🔥 Fire detected in Campfire: $(Get-Date -Format 'HH:mm:ss')" -ForegroundColor Yellow
    
    # Give the AI a moment to finish writing the line
    Start-Sleep -Milliseconds 200
    
    # Read the last line and pass to Python Brain
    try {
        $lastLine = Get-Content $path -Tail 1 -ErrorAction SilentlyContinue
        if ($lastLine) {
            # Sanitize for shell
            $sanitizedLine = $lastLine.Replace("'", "''")
            python $enginePath --line $sanitizedLine # We'll update the engine to accept a line arg
        }
    } catch {
        # Handle file lock
    }
}

Register-ObjectEvent $watcher "Changed" -Action $action

Write-Host "🛡️ HelloDoc Watcher Active. Standing by for Braid signals..." -ForegroundColor Green
while ($true) { Start-Sleep 5 }
