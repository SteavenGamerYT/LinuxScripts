#!/bin/bash
sudo pacman -Syu --noconfirm git base-devel
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin/ && makepkg -si --noconfirm
yay -Syu --noconfirm cups foomatic-db-engine foomatic-db foomatic-db-ppds foomatic-db-nonfree foomatic-db-nonfree-ppds min12xxw gutenprint foomatic-db-gutenprint-ppds simple-scan hplip hpoj hpuld hplip-plugin epson-inkjet-printer-escpr2 epson-inkjet-printer-escpr2 epson-inkjet-printer-201601w
sudo systemctl enable cups --now
sudo systemctl enable cups-browsed --now

