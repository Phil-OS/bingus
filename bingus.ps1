# --- Configurable variables ---
$imageUrl  = "https://static.wikia.nocookie.net/floppapedia-revamped/images/5/5f/ActualBingus.jpg"
$localPath = "C:\Windows\Web\Wallpaper\boingus.jpg"

# --- Download the image to a permanent location ---
start-bitstransfer -source $imageUrl -destination $localpath

# --- Registry path for Group Policy wallpaper ---
$regPath = "HKLM:\Software\Policies\Microsoft\Windows\Control Panel\Desktop"

# Create key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the wallpaper path
Set-ItemProperty -Path $regPath -Name "Wallpaper" -Value $localPath

# Set the wallpaper style (0 = Center, 2 = Stretch, 6 = Fit, 10 = Fill, etc.)
Set-ItemProperty -Path $regPath -Name "WallpaperStyle" -Value "10"

# Force Group Policy update
gpupdate /force
