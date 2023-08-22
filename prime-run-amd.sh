#!/bin/bash
if grep -q '#!/bin/bash
export DRI_PRIME=1
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json
exec "$@"' /usr/bin/prime-run
    then
            echo "prime-run IS ALRDAY installed"
    else
            echo '#!/bin/bash
export DRI_PRIME=1
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json
exec "$@"' | sudo tee -a /usr/bin/prime-run
 fi