# RAW Akai S5K/S6K USB Driver

A Windows 10/11 x64 USB driver package for the **AKAI S5000 / S6000** samplers (USB `VID_09E8&PID_005E`), used by RAW.

It was rebuilt from a reverse-engineered analysis of the original S56Sys driver package. Like the original, it contains no kernel code of its own. It binds Microsoft's inbox **WinUSB** driver to the sampler and sets:

| Setting | Value |
|---|---|
| Device Manager name | RAW Akai S5K/S6K USB Driver |
| Provider / version | RAW / 2.1.0.0 |
| Device class | AKAI Samplers `{EB781AAF-9C70-4523-A5DF-642A87ECA567}` |
| Device interface GUID | `{DFCC27D2-EDD0-2E75-3FCC-9BB9E8347723}` (same as the original, so libusb / WinUSB software finds the sampler unchanged) |
| WinUSB power keys | DeviceIdleEnabled=1, DefaultIdleTimeout=5000 (same as the original) |
| Extra files | libusbK.dll 3.0.7 (x64 to System32, x86 to SysWOW64), unchanged from the original package |

## Install

1. Download or clone this repository.
2. Open PowerShell **as Administrator** in the repository folder.
3. Run:

   ```powershell
   powershell -ExecutionPolicy Bypass -File install.ps1
   ```

4. Connect and power on the S5000. Device Manager shows **AKAI Samplers → RAW Akai S5K/S6K USB Driver**.

The catalog is signed with a self-signed certificate (`driver/RAW-Akai-S5K-S6K-signing-cert.cer`, thumbprint `73E8174750A9184B7E87363A42B4DA8DFEE8CD1D`, valid to 2046). `install.ps1` adds that public certificate to the PC's trusted Root and TrustedPublisher stores, which Windows requires before it accepts a driver that isn't signed by Microsoft. That is the same approach the original installer used. Only install it on machines where you accept that.

## Uninstall

```powershell
powershell -ExecutionPolicy Bypass -File uninstall.ps1
```

This removes the driver package and the certificate. Windows then falls back to any other driver installed for the device.

## Contents

```
driver/akai_s5000_rebuilt.inf               driver INF
driver/akai_s5000_rebuilt.cat               signed catalog
driver/RAW-Akai-S5K-S6K-signing-cert.cer    public signing certificate (no private key)
driver/amd64/libusbK.dll                    libusbK 3.0.7 (third-party, from the original package)
driver/x86/libusbK_x86.dll                  libusbK 3.0.7 x86
install.ps1 / uninstall.ps1
```

## Compatibility

Works with the **AKAI S5000 and S6000**. They share the same USB hardware and USB ID (`VID_09E8&PID_005E`).
If your sampler isn't recognised, please open an issue on this repository.
