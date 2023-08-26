#!/bin/bash
echo "Installing NTFS-3G"
sudo pacman -Syu --noconfirm --needed ntfs-3g
echp "Configuring Ntfs3 as default"
if grep -q 'SUBSYSTEM=="block", ENV{ID_FS_TYPE}=="ntfs", ENV{ID_FS_TYPE}="ntfs3"' /etc/udev/rules.d/ntfs3_by_default.rules
    then
            echo "NTFS 3 is Alaraday Set as The Default"
    else
            echo 'SUBSYSTEM=="block", ENV{ID_FS_TYPE}=="ntfs", ENV{ID_FS_TYPE}="ntfs3"' | sudo tee -a /etc/udev/rules.d/ntfs3_by_default.rules
 fi
echo "Configuring Ntfs mount options"
 if grep -q '[defaults]
ntfs_defaults=uid=1000,gid=1000,rw,user,exec,umask=000' /etc/udisks2/mount_options.conf
    then
            echo "NTFS Mount Options is altraday Configured"
    else
            echo '[defaults]
ntfs_defaults=uid=1000,gid=1000,rw,user,exec,umask=000' | sudo tee -a /etc/udisks2/mount_options.conf
 fi