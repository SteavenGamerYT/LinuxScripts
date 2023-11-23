#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install packages based on the distribution
install_packages() {
    local distro=$1
    case $distro in
        arch)
            echo "Installing Flatpak for Arch Linux"
            sudo pacman -Syu --noconfirm --needed flatpak
            ;;
        fedora)
            echo "Installing Flatpak for Fedora"
            sudo dnf install flatpak -y
            ;;
        debian|ubuntu)
            echo "Installing Flatpak for Debian/Ubuntu"
            sudo apt install flatpak -y
            ;;
        *)
            echo "Unsupported distribution: $distro"
            exit 1
            ;;
    esac
}

# Detect Linux distribution
if command_exists lsb_release; then
    distro=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
elif [ -e /etc/os-release ]; then
    distro=$(awk -F= '/^ID=/{print $2}' /etc/os-release | tr '[:upper:]' '[:lower:]')
else
    echo "Unable to determine the distribution"
    exit 1
fi

# Install Flatpak
install_packages "$distro" || {
    echo "Error: Flatpak installation failed."
    exit 1
}

install_packages "$distro"

# Add Flathub repository
echo "Adding Flathub to Flatpak"
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install Kvantum in Flatpak
echo "Installing Kvantum in Flatpak"
sudo flatpak install flathub org.kde.KStyle.Kvantum -y || {
    echo "Error: Kvantum installation failed."
    exit 1
}

# Install Mangohud in Flatpak
echo "Installing Mangohud in Flatpak"
sudo flatpak install flathub org.freedesktop.Platform.VulkanLayer.MangoHud -y || {
    echo "Error: Mangohud installation failed."
    exit 1
}

# Fix Flatpak permission issues
echo "Fixing Flatpak permission Issues"
sudo flatpak override --filesystem=~/.themes
sudo flatpak override --filesystem=~/.icons
sudo flatpak override --filesystem=xdg-config/gtk-3.0:ro
sudo flatpak override --filesystem=xdg-config/gtk-4.0:ro
sudo flatpak override --filesystem=xdg-config/qt5ct:ro
sudo flatpak override --filesystem=xdg-config/qt6ct:ro
sudo flatpak override --filesystem=xdg-config/Kvantum:ro
sudo flatpak override --filesystem=xdg-config/fontconfig:ro
sudo flatpak override --env=XCURSOR_PATH=/run/host/user-share/icons:/run/host/share/icons

echo "Flatpak installation and configuration completed."
