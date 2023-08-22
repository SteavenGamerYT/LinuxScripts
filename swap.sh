#!/bin/bash
sudo truncate -s 0 /swapfile
sudo chattr +C /swapfile
sudo fallocate -l 16G /swapfile
sudo chmod 0600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '# Swap' | sudo tee -a /etc/fstab
echo '/swapfile        none        swap        defaults      0 0' | sudo tee -a /etc/fstab
