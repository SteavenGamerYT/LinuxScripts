#!/bin/bash
sudo pacman -Syu --noconfirm distrobox podman
distrobox-create --name ubuntu --image docker.io/library/ubuntu:latest -y
distrobox-create --name fedora --image fedora:latest -y
echo 'stv-install() {' | sudo tee -a ~/.bashrc
echo '  if [[ $1 == "-v" ]]; then | sudo tee -a ~/.bashrc
echo '    x=$@ | sudo tee -a ~/.bashrc
echo '    if [[ $2 == "arch" ]]; then | sudo tee -a ~/.bashrc
echo '        x=${x/-v arch/} | sudo tee -a ~/.bashrc
echo '        sudo pacman $x | sudo tee -a ~/.bashrc
echo '    elif [[ $2 == "ubuntu" ]]; then | sudo tee -a ~/.bashrc
echo '        x=${x/-v ubuntu/} | sudo tee -a ~/.bashrc
echo '        distrobox-enter -H ubuntu -- sudo apt $x | sudo tee -a ~/.bashrc
echo '    elif [[ $2 == "fedora" ]]; then | sudo tee -a ~/.bashrc
echo '        x=${x/-v fedora/} | sudo tee -a ~/.bashrc
echo '        distrobox-enter -H fedora -- sudo dnf $x | sudo tee -a ~/.bashrc
echo '    else | sudo tee -a ~/.bashrc
echo '        echo "Command Not Found" | sudo tee -a ~/.bashrc
echo '    fi | sudo tee -a ~/.bashrc
echo '  fi | sudo tee -a ~/.bashrc
echo '} | sudo tee -a ~/.bashrc
echo 'stv() { | sudo tee -a ~/.bashrc
echo '  if [[ $1 == "-v" ]]; then | sudo tee -a ~/.bashrc
echo '    x=$@ | sudo tee -a ~/.bashrc
echo '    if [[ $2 == "arch" ]]; then | sudo tee -a ~/.bashrc
echo '        x=${x/-v arch/} | sudo tee -a ~/.bashrc
echo '         $x | sudo tee -a ~/.bashrc
echo '    elif [[ $2 == "ubuntu" ]]; then | sudo tee -a ~/.bashrc
echo '        x=${x/-v ubuntu/} | sudo tee -a ~/.bashrc
echo '        distrobox-enter -H ubuntu -- $x | sudo tee -a ~/.bashrc
echo '    elif [[ $2 == "fedora" ]]; then | sudo tee -a ~/.bashrc
echo '        x=${x/-v fedora/} | sudo tee -a ~/.bashrc
echo '        distrobox-enter -H fedora -- $x | sudo tee -a ~/.bashrc
echo '    else | sudo tee -a ~/.bashrc
echo '        echo "Command Not Found" | sudo tee -a ~/.bashrc
echo '    fi | sudo tee -a ~/.bashrc
echo '  fi | sudo tee -a ~/.bashrc
echo '} | sudo tee -a ~/.bashrc