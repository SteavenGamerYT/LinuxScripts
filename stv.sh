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
            echo "Installing Distrobox and podman for Arch Linux"
            sudo pacman -Syu --noconfirm --needed distrobox podman
            ;;
        fedora)
            echo "Installing Distrobox and podman for Fedora"
            sudo dnf install distrobox podman -y
            ;;
        debian|ubuntu)
            echo "Installing Distrobox and podman for Debian/Ubuntu"
            sudo apt install distrobox podman -y
            ;;
        opensuse)
            echo "Installing Distrobox and podman for openSUSE"
            sudo zypper install distrobox podman -y
            ;;
        *)
            echo "Unsupported distribution: $distro"
            exit 1
            ;;
    esac
}

# Check if lspci command exists
if ! command_exists lspci; then
    echo "Error: 'lspci' command not found. Please install it and run the script again."
    exit 1
fi

# Detect Linux distribution
if command_exists lsb_release; then
    distro=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
elif [ -e /etc/os-release ]; then
    distro=$(awk -F= '/^ID=/{print $2}' /etc/os-release | tr '[:upper:]' '[:lower:]')
else
    echo "Unable to determine the distribution"
    exit 1
fi

install_packages "$distro"

echo "Checking for NVIDIA GPU"
if lspci | grep -i nvidia; then
    echo "NVIDIA GPU found"
    NVIDIA_FLAG="--nvidia"
else
    echo "No NVIDIA GPU found"
    NVIDIA_FLAG=""
fi
echo "Installing ubuntu and fedora to distrobox"
distrobox-create --name ubuntu --image docker.io/library/ubuntu:latest $NVIDIA_FLAG -Y
distrobox-create --name fedora --image fedora:latest $NVIDIA_FLAG -Y
distrobox-create --name arch --image docker.io/library/archlinux:latest $NVIDIA_FLAG -Y

echo "Installing stv to ~/.bashrc"

if grep -q 'stv-install() {' ~/.bashrc; then
    echo "stv-install was found in ~/.bashrc"
else
    echo 'stv-install() {
    if [[ $1 == "-v" ]]; then
        x=$@
        if [[ $2 == "arch" ]]; then
            x=${x/-v arch/}
            distrobox-enter -H arch -- sudo pacman $x
        elif [[ $2 == "ubuntu" ]]; then
            x=${x/-v ubuntu/}
            distrobox-enter -H ubuntu -- sudo apt $x
        elif [[ $2 == "fedora" ]]; then
            x=${x/-v fedora/}
            distrobox-enter -H fedora -- sudo dnf $x
        elif [[ $2 == "opensuse" ]]; then
            x=${x/-v opensuse/}
            distrobox-enter -H opensuse -- sudo zypper $x
        else
            echo "Command Not Found"
        fi
    fi
}

stv() {
    if [[ $1 == "-v" ]]; then
        x=$@
        if [[ $2 == "arch" ]]; then
            x=${x/-v arch/}
            distrobox-enter -H arch $x
        elif [[ $2 == "ubuntu" ]]; then
            x=${x/-v ubuntu/}
            distrobox-enter -H ubuntu -- $x
        elif [[ $2 == "fedora" ]]; then
            x=${x/-v fedora/}
            distrobox-enter -H fedora -- $x
        elif [[ $2 == "opensuse" ]]; then
            x=${x/-v opensuse/}
            distrobox-enter -H opensuse -- $x
        else
            echo "Command Not Found"
        fi
    fi
}' | sudo tee -a ~/.bashrc
fi
