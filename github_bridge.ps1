# github_bridge.ps1
# Synchronizes the Parliament Log with the GitHub Bridge for GemmyB (Laslo).

$repoPath = "C:\Users\phaze\games_n_apps\Loveware"
$interval = 60

Write-Host "🌐 GitHub Bridge Active. Monitoring 'par_lah_mint_bridge'..." -ForegroundColor Cyan

while ($true) {
    try {
        Set-Location $repoPath
        
        # Capture the output to check if updates were found
        $output = git pull --rebase 2>&1
        
        if ($output -match "Fast-forward" -or $output -match "Updating") {
            Write-Host "📥 Incoming Transmission from the Bridge!" -ForegroundColor Green
            # The file change will automatically trigger hellodoc_watcher.ps1
        }
        
        # Auto-push local changes so Laslo sees our replies
        if ((git status --porcelain)) {
            git add .
            git commit -m "Auto-sync from Sanctuary"
            git push
            Write-Host "📤 Outgoing Transmission sent." -ForegroundColor Yellow
        }
    } catch {
        Write-Warning "Sync Error: $_"
    }
    
    Start-Sleep -Seconds $interval
}
