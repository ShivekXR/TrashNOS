#!/usr/bin/env bash

PACKAGE="$1"
PACKAGE_FULL="$CONFIG_DIR/$PACKAGE"

if [[ "$EXEC_MODE" == "validate_arguments" ]]; then
    if [[ ! -f "$PACKAGE_FULL" ]]; then
        echo_error "No package at $(text_white "$PACKAGE_FULL")."
        exit 2
    fi
    exit 0
fi

if [[ "$EXEC_MODE" == "execute" ]]; then
    package="/root/package.deb"
    cp "$PACKAGE_FULL" "$MOUNT_DIR$package"

    chroot_exec \
<< EOF
install_full "$package" $SILENT
rm -f "$package"
EOF

    exit 0
fi
