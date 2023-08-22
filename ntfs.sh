#!/bin/bash
sudo pacman -Syu --noconfirm ntfs-3g
echo 'SUBSYSTEM=="block", ENV{ID_FS_TYPE}=="ntfs", ENV{ID_FS_TYPE}="ntfs3"' | sudo tee -a /etc/udev/rules.d/ntfs3_by_default.rules
echo "[defaults]" | sudo tee -a /etc/udisks2/mount_options.conf
echo "ntfs_defaults=uid=1000,gid=1000,rw,user,exec,umask=000" | sudo tee -a /etc/udisks2/mount_options.conf