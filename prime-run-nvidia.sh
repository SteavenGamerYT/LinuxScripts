#!/bin/bash
yay -Rns --noconfirm nvidia-prime prime-run
if grep -q '#!/bin/bash
export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __VK_LAYER_NV_optimus=NVIDIA_only
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json
exec "$@"' /usr/local/bin/prime-run
    then
            echo "prime-run IS altraday installed"
    else
            echo '#!/bin/bash
export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __VK_LAYER_NV_optimus=NVIDIA_only
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json
exec "$@"' | sudo tee -a /usr/local/bin/prime-run
 fi
sudo chmod +x /usr/local/bin/prime-run
