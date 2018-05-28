#!/bin/bash

echo ""
#
echo "=========================================================================="
echo "= Setup script for Kali VBox Image                                       ="
echo "= Personal Prefs for usability                                           ="
echo "=========================================================================="
echo ""

# -----------------------------------------------------------------------------
# => Install applications
# -----------------------------------------------------------------------------
apt-get install zsh terminator


#intall ohmyzsh


# Settings for the Desktop
gsettings set org.gnome.nautilus.icon-view default-zoom-level small
