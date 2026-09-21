#!/usr/bin/env bash

KERNEL="$1"

if [[ "$EXEC_MODE" == "validate_arguments" ]]; then
    if [[ -z "$KERNEL" ]]; then
        echo_error "Image not specified."
        exit 2
    fi
    exit 0
fi

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "KERNEL"

    chroot_exec \
<< EOF
install_full linux-image-$KERNEL linux-headers-$KERNEL dkms
EOF

    exit 0
fi
