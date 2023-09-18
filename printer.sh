#!/bin/bash
echo "Installing yay Aur helper"
sudo pacman -Syu --noconfirm --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin/ && makepkg -si --noconfirm
echo "Installing Printer Packages"
yay -Syu --noconfirm --needed cups foomatic-db-engine foomatic-db foomatic-db-ppds foomatic-db-nonfree foomatic-db-nonfree-ppds gutenprint foomatic-db-gutenprint-ppds simple-scan hplip hpoj hpuld hplip-plugin epson-inkjet-printer-escpr2 epson-inkjet-printer-escpr2 epson-inkjet-printer-201601w epson-printer-utility epsonscan2
echo "Enabling Printer"
sudo systemctl enable cups --now
sudo systemctl enable cups-browsed --now
