#!/usr/bin/env bash

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "EARLY BOOT KEYBOARD"

    chroot_exec \
<< EOF
echo -e "Adding $(text_white "t2bce") to initram."

echo "t2bce_dma" >> "/etc/initramfs-tools/modules"
echo "t2bce_core" >> "/etc/initramfs-tools/modules"
echo "t2bce_vhci" >> "/etc/initramfs-tools/modules"
EOF

    exit 0
fi
