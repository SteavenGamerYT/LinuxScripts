#!/bin/bash
sudo pacman -Syu --noconfirm --needed flatpak curl
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak install com.spotify.Client -y
sudo flatpak override --user --filesystem=~/Music com.spotify.Client
sudo flatpak update --commit=44e179795004a87090214404d13e672b1873b523f1b6e4863f32390bf34de7c8 com.spotify.Client -y
sudo flatpak mask com.spotify.Client
bash <(curl -sSL https://raw.githubusercontent.com/SpotX-CLI/SpotX-Linux/main/install.sh) -P /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/