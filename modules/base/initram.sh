#!/usr/bin/env bash

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "INITRAM"

    chroot_exec \
<< EOF
install_full initramfs-tools cryptsetup cryptsetup-initramfs
EOF

    exit 0
fi
