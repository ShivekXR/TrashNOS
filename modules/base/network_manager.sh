#!/usr/bin/env bash

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "NETWORK"

    chroot_exec \
<< EOF
install_full network-manager rfkill

echo -e "Enabling $(text_white "NetworkManager")."
systemctl enable NetworkManager
EOF

    exit 0
fi
