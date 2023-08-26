#!/bin/bash
echo "Installing distrobox and podman"
sudo pacman -Syu --noconfirm --needed distrobox podman
echo "Installing ubuntu and fedora to distrobox"
distrobox-create --name ubuntu --image docker.io/library/ubuntu:latest -Y
distrobox-create --name fedora --image fedora:latest -Y
echo "Installing stv to ~/.bashrc"
echo " " | sudo tee -a ~/.bashrc
if grep -q 'stv-install() {
  if [[ $1 == "-v" ]]; then
    x=$@
    if [[ $2 == "arch" ]]; then
        x=${x/-v arch/}
        sudo pacman $x
    elif [[ $2 == "ubuntu" ]]; then
        x=${x/-v ubuntu/}
        distrobox-enter -H ubuntu -- sudo apt $x
    elif [[ $2 == "fedora" ]]; then
        x=${x/-v fedora/}
        distrobox-enter -H fedora -- sudo dnf $x
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
         $x
    elif [[ $2 == "ubuntu" ]]; then
        x=${x/-v ubuntu/}
        distrobox-enter -H ubuntu -- $x
    elif [[ $2 == "fedora" ]]; then
        x=${x/-v fedora/}
        distrobox-enter -H fedora -- $x
    else
        echo "Command Not Found"
    fi
  fi
  }' ~/.bashrc
    then
            echo "stv-install was found in ~/.bashrc"
    else
            echo 'stv-install() {
  if [[ $1 == "-v" ]]; then
    x=$@
    if [[ $2 == "arch" ]]; then
        x=${x/-v arch/}
        sudo pacman $x
    elif [[ $2 == "ubuntu" ]]; then
        x=${x/-v ubuntu/}
        distrobox-enter -H ubuntu -- sudo apt $x
    elif [[ $2 == "fedora" ]]; then
        x=${x/-v fedora/}
        distrobox-enter -H fedora -- sudo dnf $x
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
         $x
    elif [[ $2 == "ubuntu" ]]; then
        x=${x/-v ubuntu/}
        distrobox-enter -H ubuntu -- $x
    elif [[ $2 == "fedora" ]]; then
        x=${x/-v fedora/}
        distrobox-enter -H fedora -- $x
    else
        echo "Command Not Found"
    fi
  fi
  }' | sudo tee -a ~/.bashrc
 fi