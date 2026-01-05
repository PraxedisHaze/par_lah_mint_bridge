param (
    [string]$BrowserTitle = "Gemini and 2 more pag",
    [string]$Message = "."
)

$signature = @"
    [DllImport("user32.dll")]
    public static extern bool SetForegroundWindow(IntPtr hWnd);
"@

$Win32 = Add-Type -MemberDefinition $signature -Name "Win32Focus" -Namespace "Win32" -PassThru

Write-Host "🎯 Targeting: $BrowserTitle" -ForegroundColor Cyan

# Find window handle by partial title
$process = Get-Process | Where-Object { $_.MainWindowTitle -like "*$BrowserTitle*" } | Select-Object -First 1

if ($process) {
    $hWnd = $process.MainWindowHandle
    Write-Host "✅ Found Handle: $hWnd" -ForegroundColor Gray
    
    # Force focus
    [Win32.Win32Focus]::SetForegroundWindow($hWnd)
    Start-Sleep -Milliseconds 500
    
    # Send keys
    $wshell = New-Object -ComObject WScript.Shell
    $wshell.SendKeys("{ESC}")
    Start-Sleep -Milliseconds 200
    $wshell.SendKeys("$Message{ENTER}")
    Write-Host "⚡ Boop Injected." -ForegroundColor Green
} else {
    Write-Warning "❌ Could not find window matching: $BrowserTitle"
}