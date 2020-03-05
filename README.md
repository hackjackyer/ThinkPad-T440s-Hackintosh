# MacOS ThinkPad T440s
Hackintosh MacOS Mojave 10.14.x and 10.15.x

## Pre-Installation

### 1. Warning: check you BIOS version !!!

**You should update(downgrade) BIOS to v2.36 version or MOD BIOS to remove Whitelist!**

### 2. BIOS settings

| Item | Setting |
| ------------- | ------------ |
| Security Chip | Disabled |
| Memory Protection Execution Prevention | Enabled |
| Virtualization | Disabled |
| Fingerprint Reader | Disabled |
| Anti Theft | Disabled |
| Computrace | Disabled |
| Secure Boot | Disabled |
| Startup Network Boot | PCI LAN |
| UEFI/Legacy Boot | UEFI Only |
| CSM Support | Yes |
| Boot Mode | Quick |

### 3. Know your hardware

|Compenent|Reference|
|---|---|
|CPU|Intel Core i5-4300U vPro|
|RAM|DDR3L 12GB Bus 1600MHz|
|GFX|Intel HD Graphics 4400|
|Sound|Intel HD Audio (Realtek ALC292)|
|Display|14" FHD IPS LCD|
|WIFI|Intel Wireless N7260|
|SD Card reader|Realtek PCI Express Card Reader|
|Camera|Integrated Camera (USB Internal port)|

#### What will work:
- Intel HD 4400 Graphics QE/CI
- USB Ports
- Intel Ethernet
- Audio (All Inputs & Outputs)
- Sleep and Wake
- Touch Screen
- Mini DisplayPort and Mini DisplayPort Audio
- VGA / D-Sub Port
- CPU and IGPU Power Management
- Battery Status
- Brightness
- Function Keys (Fn)
- ClickPad and TrackPad
- Integrated Camera

#### What will not work:
- Wireless

#### WIFI :
ThinPad T440s M.2 WIFI port is A+E keyed
- BCM94360CS2 (Recommend)
- DW1560 802.11a/b/g/n/ac 2.4 GHz & 5 GHz (Broadcom)
- DW1830 802.11a/b/g/n/ac 2.4 GHz & 5 GHz (Broadcom)
- DW1820A 802.11a/b/g/n/ac 2.4 GHz & 5 GHz (Broadcom)

## Installation

....

## Post-Installation

### 1. Tools needed

- Clover Installer (https://sourceforge.net/projects/cloverefiboot/)
- Clover Configurator (https://mackie100projects.altervista.org/download-clover-configurator/)
...
- OpenCore (soon)

### 2. Kexts used
- AirportBrcmFixup.kext (for DW1820A, DW1560)
- VirtualSMC.kext
- SMCProcessor.kext
- SMCBatteryManager.kext
- SMCSuperIO.kext
- BrcmBluetoothInjector.kext (requires for BrcmPatchRAM3.kext)
- BrcmFirmwareData.kext
- BrcmPatchRAM2.kext (BrcmPatchRAM3.kext for Catalina)
- Lilu.kext
- AppleALC.kext
- VoodooPS2Controller.kext
- VoodooInput.kext
- WhateverGreen.kext
- USBPorts.kext
- VoodooSDHC.kext
- EFICheckDisabler.kext

### 3. Patched
- Copy patch to /ACPI/patched/
