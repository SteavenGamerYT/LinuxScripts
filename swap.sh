#!/bin/bash
echo "Createing swap file to /swapfile with 16gb"
sudo truncate -s 0 /swapfile
sudo chattr +C /swapfile
sudo fallocate -l 16G /swapfile
sudo chmod 0600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo "Adding swap to /etc/fstab"
if grep -q '# Swap
/swapfile        none        swap        defaults      0 0' /etc/fstab
    then
            echo "Swap is altraday at fstab"
    else
            echo '# Swap
/swapfile        none        swap        defaults      0 0' | sudo tee -a /etc/fstab
 fi
echo "Enabling hibernation for BTRFS + Systemd-Boot"
find /boot/loader/entries -type f ! -name "*fallback*" -exec grep -q 'options' {} \; -exec  sudo sed -i "s/options.*/& resume_offset=$(sudo btrfs inspect-internal map-swapfile -r \/swapfile)/" {} +
diskuuid=$(eval $(lsblk -oMOUNTPOINT,UUID  -P -M | grep 'MOUNTPOINT="/"'); echo $UUID )
find /boot/loader/entries -type f ! -name "*fallback*" -exec grep -q 'options' {} \; -exec  sudo sed -i "s/options.*/& resume=UUID=$(echo $diskuuid)/" {} +
sudo sed -i 's/\(HOOKS=.*filesystems\) \(fsck.*\)/\1 resume \2/' /etc/mkinitcpio.conf
sudo mkinitcpio -P