# TrashNOS
<img src="https://raw.githubusercontent.com/ShivekXR/TrashNOS/Main/icon.png" align="right" width="100px"/>

**Error: Project failed successfully!**

I wish this project had a better introduction, knowing how much time I have spent on it this year. Let's be real - it is trash! It is NOT an OS, but it generates a trashable Debian installation, by design. I also like the **NOS** for short, as it is the word for nose in Polish, thus the partial recyclable logo.

## Background
The first version was a mediocre hardcoded installation script, and it was clunky to port for my MacBook. It was even harder to manage two variants at the same time. The second (current) version solves some of the initial problems, and obviously introduces new ones, which I was not aware at the start and in the middle of the creation process. The techincal debt of my (still) limited Linux knowledge. However, I am more than satisfied with the outcome - in less than hour I have fully functional and configured setups for my MacBook and XMG Fusion laptop. There is a promising future for the project, which I will most likely continue in the following year. Now I wish to cool down and refocus on other stuff.

## Kind of Success
* Profiles - Two slightly different minimalistic Debian installation variants. (I am posting minimal debloated profiles as privately mine have 250 lines each.)
* Modules - Reusable subscripts.

## Kind of Failure
* Profiles - They are not strictly data-oriented yet. They are like a data-oriented set of instructions. The *set of instructions* part shall be removed in V3 with a proper profile structure.
* Modules - Some (or most) of the modules are written and reused poorly. (I chased making my installation functional for myself first, and at some point I started to care less about the script quality / hardcoding.)
* Only one user account with root privileges.

## Installation
Download Debian Live ISO and burn it into your USB stick / CD / put it in VenToy. Boot into Live ISO and follow this little instruction:
```bash
apt-get update
date -s "YYYY-MM-DD HH:mm" # Set a proper date while installing on MacBook!
cd ~/
mkdir deb
mount LIVE_ISO_DEVICE_NAME ~/deb
cd deb
bash debian.sh --profile PROFILE_NAME --device TARGET_DEVICE_NAME
# There are also --luks_password PASSWORD; --luks_size XYZGiB; --admin_password PASSWORD; --yubikeys NUMBER; and --silent; options.
```

## Warning!
* The `mbp13` profile is for the 2020 13-inch MacBookPro 16,3. If you want to try it out, first you need to get the firmware from your MacBook! Follow this guide: https://wiki.t2linux.org/guides/wifi-bluetooth/ and put the package in `configs/apple_firmware/macfw.deb`.
* If you want to use your yubikeys, you need to download fido2luks package. It is not on Trixie yet, but on Forky. Check the official Debian repository: https://packages.debian.org/forky/fido2luks and put the package in `configs/yubikey/fido2luks.deb`.
