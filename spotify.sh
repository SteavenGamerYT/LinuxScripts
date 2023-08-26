#!/bin/bash
echo "Installing flatpak and curl"
sudo pacman -Syu --noconfirm --needed flatpak curl
echo "Adding flathub to Flatpak"
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
echo "Installing Lastest Spdofiy from flatpak"
sudo flatpak install com.spotify.Client -y
echo "Fixing Spdofiy flatpak permission issues"
flatpak override --user --filesystem=~/Music com.spotify.Client
echo "Downgrading Spdofiy to working version"
sudo flatpak update --commit=44e179795004a87090214404d13e672b1873b523f1b6e4863f32390bf34de7c8 com.spotify.Client -y
echo "Blocking Spdofiy updates"
sudo flatpak mask com.spotify.Client
echo "Removing ads from Spdofiy"
bash <(curl -sSL https://raw.githubusercontent.com/SpotX-CLI/SpotX-Linux/main/install.sh) -P /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/