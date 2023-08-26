#!/bin/bash
echo "Installing Flatpak"
sudo pacman -Syu --noconfirm flatpak
echo "Adding Flathub to Flatpak"
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
echo "Installing Kvantum in Flatpak"
sudo flatpak install runtime/org.kde.KStyle.Kvantum/x86_64/5.15-22.08 runtime/org.kde.KStyle.Kvantum/x86_64/5.15 runtime/org.kde.KStyle.Kvantum/x86_64/5.15-21.08 -y
echo "Installing Mangohud in Flatpak"
sudo flatpak install runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/21.08 runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/22.08 -y 
echo "Fixing Flatpak permsision Issues"
sudo flatpak override --filesystem=~/.themes
sudo flatpak override --filesystem=~/.icons
sudo flatpak override --filesystem=xdg-config/gtk-3.0:ro
sudo flatpak override --filesystem=xdg-config/gtk-4.0:ro
sudo flatpak override --filesystem=xdg-config/qt5ct:ro
sudo flatpak override --filesystem=xdg-config/qt6ct:ro
sudo flatpak override --filesystem=xdg-config/Kvantum:ro
sudo flatpak override --filesystem=xdg-config/fontconfig:ro
sudo flatpak override --filesystem=xdg-config/MangoHud:ro