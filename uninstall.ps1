# Remove the RAW Akai S5K/S6K USB Driver (run as Administrator).
#   powershell -ExecutionPolicy Bypass -File uninstall.ps1
$ErrorActionPreference = 'Stop'
$out = pnputil /enum-drivers
$pkgs = @()
for ($i = 0; $i -lt $out.Count; $i++) {
    if ($out[$i] -match 'Original Name:\s+akai_s5000_rebuilt\.inf') { $pkgs += ($out[$i-1] -replace '.*:\s+', '').Trim() }
}
if (-not $pkgs) { 'RAW driver package not found in the driver store.' }
foreach ($p in $pkgs) { pnputil /delete-driver $p /uninstall; "removed $p (exit $LASTEXITCODE)" }
$thumb = '73E8174750A9184B7E87363A42B4DA8DFEE8CD1D'
foreach ($s in 'Root', 'TrustedPublisher') { certutil -delstore $s $thumb | Out-Null; "certificate removed from LocalMachine\$s" }
