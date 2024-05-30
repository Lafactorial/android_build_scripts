#!/bin/bash

set -e

# Initialize repo with specified manifest
repo init -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs --depth=1

# Run inside foss.crave.io devspace, in the project folder
# Remove existing local_manifests
crave run --no-patch -- "rm -rf .repo/local_manifests && \
# Initialize repo with specified manifest
repo init -u https://github.com/alphadroid-project/manifest -b alpha-14 --git-lfs --depth=1 ;\

# Clone local_manifests repository
git clone https://github.com/Lafactorial/local_manifest --depth 1 -b sweet2-alpha .repo/local_manifests ;\

# Sync the repositories
/opt/crave/resync.sh && \ 
repo forall -c "git lfs install && git lfs pull && git lfs checkout" ;\

# Signing
curl https://raw.githubusercontent.com/sounddrill31/crave_aosp_builder/signing/scripts/signing-script.sh | bash; \

# Set up build environment
source build/envsetup.sh && \

# Lunch configuration
lunch lineage_sweet2-ap1a-userdebug ;\

croot ;\
make bacon ; \
# echo "Date and time:" ; \

# Print out/build_date.txt
# cat out/build_date.txt; \

# Print SHA256
# sha256sum out/target/product/*/*.zip"
