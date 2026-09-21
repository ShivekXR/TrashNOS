#!/usr/bin/env bash

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "UTILITIES"


    chroot_exec \
<< EOF
PACKAGES_FULL=(
    curl wget gnupg
    nano
    sudo
)
install_packages
EOF

    exit 0
fi
