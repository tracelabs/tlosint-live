# Trace Labs Kali Linux build configuration 

## Overview
The repository includes a recipe file to build a Linux OSINT Distribution for Trace Labs based on the Kali Linux live-build-config (https://gitlab.com/kalilinux/build-scripts/live-build-config/-/tree/master).

![alt text](https://github.com/tracelabs/tlosint-live/blob/master/image.png?raw=true "Tracelabs kali desktop")

The following changes have been made to the default Kali git repo:
* Creation of a folder for Tracelabs under the `kali-config/variant-tracelabs/package-lists/kali-list.chroot` path. The `kali-list.chroot` can be modified to add additional packages or remove pre-configured packages that are required as part of the build process. 
* Creation of the `kali-config/common/hooks/normal/osint-packages.chroot` file to include the installation steps for all the git repositories that have been included in the build, and do not already have a package. The `osint-packages.chroot` file can be modified to add additional git repositories or remove pre-configured git repositories that are required as part of the build process. Please add any pre-requisite packages to the `kali-live/kali-config/variant-tracelabs/package-lists/kali-list.chroot` file. 
* Creation of the following folders under the directory `kali-config/common/includes.chroot/usr/share/` 
    * `applications`: linked to the menu for applications
    * `backgrounds`: default Tracelabs background
    * `desktop-directories`: desktop directories with tools
    * `firefox-esr/distribution`: default Firefox policy

## Build Steps

### Setup
This build has only been tested on a pre-existing Kali environment, as recommended by Offensive Security. 
```
sudo wget -O - https://raw.githubusercontent.com/tracelabs/tlosint-live/master/build_tracelabsiso_recipe.sh | sudo bash
```
If the build process is successful, a .iso file will be created in the `/opt/live-build-config/images` directory. The .iso file can be used for live boot or to install the Virtual Machine. The .iso file can also be converted to a .ova file using the `ovftool` as outlined in the "Converting to an OVA" page (https://www.kali.org/docs/virtualization/converting-to-ova/).

## OVA Download
We have set up Version 1.0 of this build in an OVA for you to easily try out. To get started, download the OVA file via the link below and run it in your choice of VM software (ie. VMware Workstation, Virtualbox etc.). The default credentials to log in to the TL OSINT VM are **osint:osint**

https://www.tracelabs.org/trace-labs-osint-vm/

## Applications included in the build 

**Browsers**
* Chromium Web Browser
* Firefox ESR
* Tor Browser

**Data Analysis**
* DumpsterDiver
* Exifprobe
* Exifscan
* Stegosuite

**Domains**
* Sublist3r

**Downloaders**
* Browse Mirrored Websites
* Metagoofil
* Spiderpig
* WebHTTrack Website Copier
* Youtube-DL

**Email**
* Buster
* Infoga
* OSINT-Search
* theHarvester

**Frameworks**
* Little Brother
* sn0int
* Spiderfoot
* Maltego

**Phone Numbers**
* OSINT-Search
* PhoneInfoga

**Social Media**
* Instaloader
* Twint

**Usernames**
* Sherlock

**Other tools (not listed in the menu)**
* checkdmarc
* Photon
* Carbon14
* Sherlock
* h8mail
* Shodan
* Wireshark

## Configuration Settings
**Firefox**
* Delete cookies/history on shutdown
* Block geo tracking
* Block mic/camera detection
* Block Firefox tracking
* Preload OSINT Bookmarks

## References:
* https://docs.kali.org/development/live-build-a-custom-kali-iso 
* https://github.com/prateepb/kali-live-build 
