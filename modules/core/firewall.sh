#!/usr/bin/env bash

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "FIREWALL"

    chroot_exec \
<< EOF
PACKAGES_NO_RECOMMENDS=(
    firewalld
)
PACKAGES_FULL=(
    python3-cap-ng                                      # privileges
)
install_packages

echo -e "Enabling $(text_white "firewalld")."
systemctl enable firewalld
EOF

    exit 0
fi
