#!/usr/bin/env bash

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "BATTERY"

    chroot_exec \
<< EOF
PACKAGES_FULL=(
    power-profiles-daemon                               # toggle
    upower                                              # monitor
)
install_packages
EOF

    exit 0
fi
