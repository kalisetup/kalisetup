#!/bin/bash

echo ""
echo "=========================================================================="
echo "= Setup script for Kali VBox Image                                       ="
echo "= Personal Prefs for usability                                           ="
echo "=========================================================================="
echo ""

## Ideas can be found in these locations:
# https://github.com/P4l1ndr0m/Kali-post-install/blob/master/kali.sh
# https://github.com/ysf/kali-post-install

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
