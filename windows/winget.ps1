# 
#
#
# How to run this script:
#
# 1. Open PowerShell.
# 2. Navigate to this script's folder (e.g., cd "C:\path\to\folder").
# 3. If you have script execution blocked, temporarily allow it for this session:
#      Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
# 4. Run the script:
#      .\winget.ps1
#
# This installs listed packages if they are not already installed.

$packages = @(
    "7zip.7zip",
    "ShareX.ShareX",
    "Microsoft.WindowsTerminal",
    "Microsoft.VisualStudioCode",
    "Microsoft.WSL",
    "Microsoft.Sysinternals",
    "VideoLAN.VLC",
    "OBSProject.OBSStudio",
    "HandBrake.HandBrake",
    "Microsoft.PowerToys",
    "AntibodySoftware.WizTree",
    "sylikc.JPEGView",
    "AutoHotkey.AutoHotkey",
    "Obsidian.Obsidian",
    "GIMP.GIMP.3",
    "KDE.Krita",
    "Inkscape.Inkscape",
    "Audacity.Audacity",
    "mpv.net",
    "dotPDN.paintdotnet",
    "WinsiderSS.SystemInformer",
    "Discord.Discord",
    "Audacious.MediaPlayer",
)

$log = @()

foreach ($pkg in $packages) {
    Write-Host "Checking $pkg..."
    $installed = winget list --source winget --id $pkg | Select-String $pkg

    if ($installed) {
        Write-Host "[OK]  $pkg is already installed." -ForegroundColor Green
        $log += "Already installed: $pkg"
    } else {
        Write-Host "[INSTALL] Installing $pkg..." -ForegroundColor Cyan
        winget install --accept-source-agreements --id $pkg
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[DONE] Installed $pkg successfully." -ForegroundColor Green
            $log += "Installed: $pkg"
        } else {
            Write-Host "[FAIL] Failed to install $pkg." -ForegroundColor Red
            $log += "FAILED: $pkg"
        }
    }
}
# Optionally dump the log afterward
# $log | Out-File -Encoding utf8 "winget-install-log.txt"
# Write-Host "Done. Log saved to winget-install-log.txt."
