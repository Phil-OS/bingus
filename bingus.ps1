# --- Configurable variables ---
$imageUrl = "https://static.wikia.nocookie.net/floppapedia-revamped/images/5/5f/ActualBingus.jpg"
$localPath = "C:\Windows\BINGUS.jpg"

# --- Download the image ---
Invoke-WebRequest -Uri $imageUrl -OutFile $localPath

# --- Set as desktop background using Windows API ---
Add-Type @"
using System;
using System.Runtime.InteropServices;

public class Wallpaper {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

$SPI_SETDESKWALLPAPER = 0x14
$SPIF_UPDATEINIFILE   = 0x01
$SPIF_SENDWININICHANGE = 0x02

[Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $localPath, $SPIF_UPDATEINIFILE -bor $SPIF_SENDWININICHANGE)
