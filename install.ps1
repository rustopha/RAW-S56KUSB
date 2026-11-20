# Install the RAW Akai S5K/S6K USB Driver (run as Administrator).
#   powershell -ExecutionPolicy Bypass -File install.ps1
# 1. trusts the driver's public signing certificate on this PC (Root + TrustedPublisher)
# 2. adds the signed driver package to Windows and installs it on any connected S5000
$ErrorActionPreference = 'Stop'
$drv = Join-Path $PSScriptRoot 'driver'
$cer = Join-Path $drv 'RAW-Akai-S5K-S6K-signing-cert.cer'
$x509 = [System.Security.Cryptography.X509Certificates.X509Certificate2]::new($cer)
foreach ($s in 'Root', 'TrustedPublisher') {
    $st = New-Object System.Security.Cryptography.X509Certificates.X509Store($s, 'LocalMachine')
    $st.Open('ReadWrite'); $st.Add($x509); $st.Close()
    "certificate $($x509.Thumbprint) trusted in LocalMachine\$s"
}
$sig = Get-AuthenticodeSignature (Join-Path $drv 'akai_s5000_rebuilt.cat')
"catalog signature: $($sig.Status)"
if ($sig.Status -ne 'Valid') { throw 'catalog signature not valid' }
pnputil /add-driver (Join-Path $drv 'akai_s5000_rebuilt.inf') /install
"pnputil exit code: $LASTEXITCODE"
