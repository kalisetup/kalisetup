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

# Path to download packages etc..
SCRIPTDLPATH="scriptdls/"

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

echo "[+] Downloading themes, icons and fonts..."
mkdir "$SCRIPTDLPATH" 2>/dev/null
wget -qO "$SCRIPTDLPATH/font.zip" https://assets.ubuntu.com/v1/fad7939b-ubuntu-font-family-0.83.zip
wget -qO "$SCRIPTDLPATH/icons.deb" http://ftp.iinet.net.au/pub/ubuntu/pool/main/h/humanity-icon-theme/humanity-icon-theme_0.6.15_all.deb
git clone -q https://github.com/horst3180/arc-theme --depth 1 "$SCRIPTDLPATH/arc-theme"

echo "[+] Installing theme, icons and fonts..."
cd "$SCRIPTDLPATH"
dpkg -i icons.deb
unzip -qq -d /usr/share/fonts/truetype/ttf-ubuntu font.zip
fc-cache -f

## Build and install arc-theme
cd arc-theme
./autogen.sh --prefix=/usr
make install


cd ../..
cp kalibg.png /usr/share/backgrounds
cp .vimrc ~

echo "[+] Updating mate settings..."
# Terminal 
gsettings set org.mate.terminal.profile:/org/mate/terminal/profiles/default/ scrollback-unlimited true	# unlimited terminal scrollback
gsettings set org.mate.terminal.keybindings help 'disabled' # hate hitting help accidently, noone cares
gsettings set org.mate.terminal.profile:/org/mate/terminal/profiles/default/ background-color $TERMBG
gsettings set org.mate.terminal.profile:/org/mate/terminal/profiles/default/ foreground-color $TERMFG
gsettings set org.mate.terminal.profile:/org/mate/terminal/profiles/default/ palette $TERMPAL

gsettings set org.mate.terminal.profile:/org/mate/terminal/profiles/default/ use-theme-colors false
gsettings set org.mate.terminal.profile:/org/mate/terminal/profiles/default/ bold-color-same-as-fg false

# Disable screensavers!
gsettings set org.mate.screensaver idle-activation-enabled false	# disable screensave
gsettings set org.mate.power-manager sleep-display-ac 0				# disable screen sleeping when plugged in

# Wallpaper settings
gsettings set org.mate.background picture-options 'centered'		# set wallpaper options
gsettings set org.mate.background picture-filename '/usr/share/backgrounds/kalibg.png'
gsettings set org.mate.background color-shading-type 'solid'
gsettings set org.mate.background primary-color '#23231f1f2020'

# Theme and fonts
gsettings set org.mate.interface gtk-theme 'Arc-Dark'
gsettings set org.mate.interface icon-theme 'Humanity-Dark'
gsettings set org.gnome.desktop.wm.preferences theme 'Arc-Dark'
gsettings set org.mate.Marco.general theme 'Arc-Dark'
gsettings set org.mate.font-rendering antialiasing 'rgba'
gsettings set org.mate.font-rendering hinting 'slight'
gsettings set org.mate.Marco.general titlebar-font 'Ubuntu Medium 11'
gsettings set org.mate.interface monospace-font-name 'Ubuntu Mono 13'
gsettings set org.mate.interface font-name 'Ubuntu 11'
gsettings set org.mate.caja.desktop font 'Ubuntu 11'


rm -fr "$SCRIPTDLPATH"
echo "[*] You need to reboot for the theme, MATE Xsession, and VM tools to fully take effect."
printf "[*] Before logging in, click the gear (\\u2699 ) icon on the password prompt and select MATE\n"











