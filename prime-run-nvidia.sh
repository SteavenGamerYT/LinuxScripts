#!/bin/bash
echo '#!/bin/bash' | sudo tee -a /usr/bin/prime-run
echo 'export __NV_PRIME_RENDER_OFFLOAD=1' | sudo tee -a /usr/bin/prime-run
echo 'export __GLX_VENDOR_LIBRARY_NAME=nvidia' | sudo tee -a /usr/bin/prime-run
echo 'export __VK_LAYER_NV_optimus=NVIDIA_only' | sudo tee -a /usr/bin/prime-run
echo 'export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json' | sudo tee -a /usr/bin/prime-run
echo 'exec "$@"' | sudo tee -a /usr/bin/prime-run