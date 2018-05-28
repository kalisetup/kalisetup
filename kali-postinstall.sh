#!/bin/bash
# -Info--------------------------------------------------------------------
# Filename: kali-postinstall.sh
# Date: 2018-05-28
# Version: 2018.2
#-Notes--------------------------------------------------------------------
# These are the things I do after installing Kali 2018.2 on a new VM/System. 
#
# Run this as root after an install of Kali 2018.2
# 
# This is provided as-is and is not meant for others. However, you might 
# find some of this stuff useful.
## Ideas can be found in these locations:
# https://github.com/g0tmi1k/os-scripts/blob/master/kali.sh
# https://github.com/ysf/kali-post-install
# https://github.com/sourcekris/kali-postinstall/blob/master/kali-postinstall.sh

VERSION="2018.2"

# We do VM detection later, default case it false, set manually to true if the 
# detection fails for you
VM=false

# Terminal Palette
TERMPAL="#000000000000:#CDCB00000000:#0000CDCB0000:#CDCBCDCB0000:#1E1A908FFFFF:#CDCB0000CDCB:#0000CDCBCDCB:#E5E2E5E2E5E2:#4CCC4CCC4CCC:#FFFF00000000:#0000FFFF0000:#FFFFFFFF0000:#46458281B4AE:#FFFF0000FFFF:#0000FFFFFFFF:#FFFFFFFFFFFF"
TERMBG="#000000000000"
TERMFG="#FFFFFFFFDDDD"

# Check we're root
if [[ $EUID -ne 0 ]]
then
	echo "[-] This script must be run as root." 
	exit
fi

echo "[*] Improving Kali $VERSION"

# Check if we are running in a VM
if [[ `dmidecode | grep -ic virtual` -gt 0 ]]
then
	VM=true
fi

# Setup VM Tools?
#if [ "$VM" == "true" ]
#then
#	echo "[+] Installing open-vm-tools..."
#	apt-get -y -qq install open-vm-tools-desktop fuse 
#else
#	echo "[*] Virtual machine NOT detected, skipping vmtools installation..."
#fi

## - Update Repos
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" > /etc/apt/sources.list.d/sublime-text.list

echo "[+] Updating repos from new mirror..."
apt-get -qq update

## - Updating Desktop
echo "[+] Installing mate desktop and theme pre-reqs..."
apt-get -y -qq install mate-core mate-desktop-environment-extra mate-desktop-environment-extras autoconf automake pkg-config libgtk-3-dev gnome-themes-standard gtk2-engines-murrine sublime-text




echo ""
echo "=========================================================================="
echo "= Setup script for Kali VBox Image                                       ="
echo "= Personal Prefs for usability                                           ="
echo "=========================================================================="
echo ""













##### Location information
keyboardApple=true         # Using a Apple/Macintosh keyboard? Change to anything other than 'false' to enable
keyboardlayout="gb"         # Great Britain
timezone="Europe/London"    # London, Europe

##### (Cosmetic) Colour output
RED="\033[01;31m"
GREEN="\033[01;32m"
YELLOW="\033[01;33m"
BLUE="\033[01;34m"
RESET="\033[00m"

##### Updating location information - set either value to "" to skip.
echo -e "\n$GREEN[+]$RESET Updating location information ~ keyboard layout & time zone ($keyboardlayout & $timezone)"
#keyboardlayout="gb"         # Great Britain
#timezone="Europe/London"    # London, Europe
#--- Configure keyboard layout
if [ ! -z "$keyboardlayout" ]; then
  file=/etc/default/keyboard; #[ -e "$file" ] && cp -n $file{,.bkup}
  sed -i 's/XKBLAYOUT=".*"/XKBLAYOUT="'$keyboardlayout'"/' "$file"
  [ "$keyboardApple" != "false" ] && sed -i 's/XKBVARIANT=".*"/XKBVARIANT="mac"/' "$file"   ## Enable if you are using Apple based products.
  #dpkg-reconfigure -f noninteractive keyboard-configuration   #dpkg-reconfigure console-setup   #dpkg-reconfigure keyboard-configuration -u    #need to restart xserver for effect
fi






# -----------------------------------------------------------------------------
# => Install applications
# -----------------------------------------------------------------------------
apt-get install zsh terminator


#intall ohmyzsh


# Settings for the Desktop
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface monospace-font-name "Monospace 10"
gsettings set org.gnome.desktop.interface document-font-name 'Sans 10'




gsettings set org.gnome.nautilus.icon-view default-zoom-level small
