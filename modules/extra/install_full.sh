#!/usr/bin/env bash

PACKAGES="$1"

if [[ "$EXEC_MODE" == "execute" ]]; then
    chroot_exec \
<< EOF
install_full $PACKAGES
EOF

    exit 0
fi
