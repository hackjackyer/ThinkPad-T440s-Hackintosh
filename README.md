# MacOS ThinkPad T440s

## NEW UPDATE : https://github.com/banhbaoxamlan/T440-Hackintosh

Hackintosh MacOS Mojave 10.14.6 and 10.15.x

## Pre-Installation

### 1. Warning: check you BIOS version

**You should update(downgrade) BIOS to v2.36 version or MOD BIOS to remove Wireless Whitelist!**

### 2. BIOS settings

| Item | Setting |
| ------------- | ------------ |
| Security Chip | Disabled |
| Memory Protection Execution Prevention | Enabled |
| Virtualization | Enabled |
| Fingerprint Reader | Disabled |
| Anti Theft | Disabled |
| Computrace | Disabled |
| Secure Boot | Disabled |
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
- Mini DisplayPort and Mini DisplayPort Audio
- CPU and IGPU Power Management
- Battery Status
- Brightness
- Function Keys (Fn)
- ClickPad and TrackPad
- Integrated Camera

#### What will not work

- Fingerprint Reader
- VGA
- WIFI + Bluetooth

#### WIFI

Inbuilt Intel WiFi won't work out of the box.

You can flash the BIOS and remove the whitelist if you plan to use other WLAN cards. ThinkPad T440s M.2 WIFI port is A+E keyed

- BCM94360CSAX (Recommend)
- DW1560 (BCM9435Z) - 802.11a/b/g/n/ac 2.4 GHz & 5 GHz
- DW1830 (BCM943602BAED) - 802.11a/b/g/n/ac 2.4 GHz & 5 GHz
- DW1820A (BCM94350ZAE) - 802.11a/b/g/n/ac 2.4 GHz & 5 GHz (Broadcom)

## Installation

....

## Post-Installation

### DOWNLOAD HERE: [EFI](https://github.com/banhbaoxamlan/T440-Hackintosh/releases/latest)

### 1. Tools needed

- Clover Bootloader

### 2. Kexts used

- ACPIBatteryManager.kext
- AirportBrcmFixup.kext (for DW1820A, DW1560)
- AppleALC.kext
- BrcmBluetoothInjector.kext (requires for BrcmPatchRAM3.kext)
- BrcmFirmwareData.kext
- BrcmPatchRAM2.kext (BrcmPatchRAM3.kext for Catalina)
- EFICheckDisabler.kext
- FakeSMC.kext
- IntelMausi.kext
- Lilu.kext
- USBPorts.kext
- VoodooPS2Controller.kext
- VoodooInput.kext
- VoodooSDHC.kext
- WhateverGreen.kext

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

## Support me

- Paypal: <https://www.paypal.me/thebinhluong0519>
- Ethereum: 0xC202255193D95979A7C937aA3CB5220FAD9E2aBe
