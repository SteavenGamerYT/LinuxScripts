#!/bin/bash

echo "Removing Prime packages from pacman"
sudo pacman -Rns --noconfirm nvidia-prime

echo "Adding prime-run in /usr/local/bin/prime-run"
if grep -q '#!/bin/bash
export DRI_PRIME=1
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json
exec "$@"' /usr/local/bin/prime-run; then
    echo "prime-run IS already installed"
else
    echo '#!/bin/bash
export DRI_PRIME=1
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json
exec "$@"' | sudo tee -a /usr/local/bin/prime-run > /dev/null
fi

echo "Making /usr/local/bin/prime-run executable"
sudo chmod +x /usr/local/bin/prime-run
