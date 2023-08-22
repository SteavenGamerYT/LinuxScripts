#!/bin/bash
echo '#!/bin/bash' | sudo tee -a /usr/bin/prime-run
echo 'export DRI_PRIME=1' | sudo tee -a /usr/bin/prime-run
echo 'export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json' | sudo tee -a /usr/bin/prime-run
echo 'exec "$@"' | sudo tee -a /usr/bin/prime-run