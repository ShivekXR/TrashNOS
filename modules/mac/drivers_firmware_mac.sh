#!/usr/bin/env bash

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "DRIVERS FIRMWARE (MACBOOK)"

    chroot_exec \
<< EOF
PACKAGES_FULL=(
    intel-microcode                     # stability & security
    firmware-misc-nonfree               # many helpful stuff
    mesa-vulkan-drivers                 # 3D API
    intel-media-va-driver-non-free      # video codecs
)
install_packages
EOF

    exit 0
fi
