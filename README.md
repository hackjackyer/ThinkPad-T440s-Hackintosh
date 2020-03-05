# MacOS ThinkPad T440s

Hackintosh MacOS Mojave 10.14.x and 10.15.x

## Pre-Installation

### 1. Warning: check you BIOS version

**You should update(downgrade) BIOS to v2.36 version or MOD BIOS to remove Wireless Whitelist!**

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

#### What will work

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

#### What will not work

- Wireless

#### WIFI

Inbuilt Intel WiFi won't work out of the box.

You can flash the BIOS and remove the whitelist if you plan to use other WLAN cards. ThinkPad T440s M.2 WIFI port is A+E keyed

- BCM94360CS2 (Recommend)
- DW1560 802.11a/b/g/n/ac 2.4 GHz & 5 GHz (Broadcom)
- DW1830 802.11a/b/g/n/ac 2.4 GHz & 5 GHz (Broadcom)
- DW1820A 802.11a/b/g/n/ac 2.4 GHz & 5 GHz (Broadcom)

## Installation

....

## Post-Installation

### 1. Tools needed

- Clover Installer (<https://sourceforge.net/projects/cloverefiboot/)>
- Clover Configurator (<https://mackie100projects.altervista.org/download-clover-configurator/)>
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
- VoodooSDHC.kext (<https://github.com/OSXLatitude/EDP/tree/master/kextpacks/USB/VoodooSDHC/VoodooSDHC.kext)>
- EFICheckDisabler.kext (<https://github.com/RehabMan/hack-tools/tree/master/kexts/EFICheckDisabler.kext)>

### 3. Patched

- Copy patch to /ACPI/patched/

## Issue:

### Sound (Headphones and External Microphones)

The only thing we need is the "alc fix" which does fix the problem with Headphones and External Microphones.

This audio codec doesn't do the correction and detection on laptops with Combo Jack so it is required.

Copy the alc_fix folder which is inside the Audio folder from my Github Repo.

Open terminal and type the following commands:

`cd desktop/alc_fix`

`./install.sh`

Or you can simply drag the install.sh file and drop it on the terminal window after you typed the first command

Pres enter and the alc_fix installation is completed