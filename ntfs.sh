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
            echo "Installing NTFS-3G for Arch Linux"
            sudo pacman -Syu --noconfirm --needed ntfs-3g
            ;;
        fedora)
            echo "Installing NTFS-3G for Fedora"
            sudo dnf install ntfs-3g udisks2 -y
            ;;
        debian|ubuntu)
            echo "Installing NTFS-3G for Debian/Ubuntu"
            sudo apt install ntfs-3g -y
            ;;
        opensuse)
            echo "Installing NTFS-3G for openSUSE"
            sudo zypper install ntfs-3g -y
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

install_packages "$distro"

echo "Configuring Ntfs3 as default"
ntfs3_default_rule='SUBSYSTEM=="block", ENV{ID_FS_TYPE}=="ntfs", ENV{ID_FS_TYPE}="ntfs3"'
ntfs3_default_file='/etc/udev/rules.d/ntfs3_by_default.rules'

if grep -q "$ntfs3_default_rule" "$ntfs3_default_file"; then
    echo "NTFS3 is already set as the default"
else
    sudo mkdir -p "$(dirname "$ntfs3_default_file")"
    echo "$ntfs3_default_rule" | sudo tee -a "$ntfs3_default_file"
    echo "NTFS3 set as the default"
fi

echo "Configuring Ntfs mount options"
ntfs_mount_options='[defaults]\nntfs_defaults=uid=1000,gid=1000,rw,user,exec,umask=000,windows_names'
mount_options_file='/etc/udisks2/mount_options.conf'

if grep -q '[defaults]' "$mount_options_file"; then
    echo "NTFS Mount Options are already configured"
else
    sudo mkdir -p "$(dirname "$mount_options_file")"
    echo -e "\n$ntfs_mount_options" | sudo tee -a "$mount_options_file"
    echo "NTFS Mount Options configured"
fi
