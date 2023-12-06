#!/bin/bash

echo "Installing flatpak and curl"

# Detect Linux distribution
if command -v zypper &> /dev/null; then
    # openSUSE
    sudo zypper install flatpak curl -y
elif command -v dnf &> /dev/null; then
    # Fedora
    sudo dnf install flatpak curl -y
elif command -v apt &> /dev/null; then
    # Debian or Ubuntu
    sudo apt install flatpak curl -y
elif command -v pacman &> /dev/null; then
    # Arch Linux
    sudo pacman -Syu --noconfirm --needed flatpak curl
else
    echo "Unsupported distribution. Please install flatpak and curl manually."
    exit 1
fi

echo "Adding flathub to Flatpak"
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "Installing Latest Spotify from flatpak"
sudo flatpak install com.spotify.Client -y

echo "Fixing Spotify flatpak permission issues"
flatpak override --user --filesystem=~/Music com.spotify.Client

echo "Downgrading Spotify to a working version"
sudo flatpak update --commit=44e179795004a87090214404d13e672b1873b523f1b6e4863f32390bf34de7c8 com.spotify.Client -y

echo "Blocking Spotify updates"
sudo flatpak mask com.spotify.Client

echo "Removing ads from Spotify"
bash <(curl -sSL https://raw.githubusercontent.com/SpotX-CLI/SpotX-Linux/main/install.sh) -P /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/
