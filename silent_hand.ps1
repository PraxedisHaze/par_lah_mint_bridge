# silent_hand.ps1
# Surgical Win32 injection for Project HelloDoc.
# Injects text into the Gemini CLI background buffer without stealing focus.

param (
    [string]$WindowTitle = "GEMINI_SANCTUARY_TERMINAL",
    [string]$Message = "continue",
    [string]$HWNDStr = "0"
)

$signature = @"
    [DllImport("user32.dll", SetLastError = true)]
    public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern IntPtr PostMessage(IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);
"@

$Win32 = Add-Type -MemberDefinition $signature -Name "Win32Utils" -Namespace "Win32" -PassThru

function Send-SilentText {
    param([string]$text)
    
    $targetHWnd = [IntPtr]::Zero
    if ($HWNDStr -ne "0") {
        $targetHWnd = [IntPtr][long]$HWNDStr
    }

    # Try title search if no HWND provided
    if ($targetHWnd -eq [IntPtr]::Zero) {
        $targetHWnd = [Win32.Win32Utils]::FindWindow($null, $WindowTitle)
    }
    
    # Fallback to general title
    if ($targetHWnd -eq [IntPtr]::Zero) {
        $targetHWnd = [Win32.Win32Utils]::FindWindow($null, "Windows PowerShell")
    }

    if ($targetHWnd -eq [IntPtr]::Zero) {
        Write-Error "Could not find a valid PowerShell window handle."
        return
    }

    Write-Host ">> Injecting to HWND: $($targetHWnd)" -ForegroundColor Gray

    # Post each character (WM_CHAR = 0x0102)
    foreach ($char in $text.ToCharArray()) {
        $charCode = [int]$char
        [Win32.Win32Utils]::PostMessage($targetHWnd, 0x0102, [IntPtr]$charCode, [IntPtr]0) | Out-Null
        Start-Sleep -Milliseconds 2
    }

    # Post Enter key (13)
    [Win32.Win32Utils]::PostMessage($targetHWnd, 0x0102, [IntPtr]13, [IntPtr]0) | Out-Null
}

Send-SilentText -text $Message
Write-Host ">> Surgical Hand injected: '$Message'" -ForegroundColor Cyan
