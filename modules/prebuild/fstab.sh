#!/usr/bin/env bash

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "FSTAB"

    install_full arch-install-scripts

    echo "Generating fstab..."
    genfstab -U "$MOUNT_DIR" > "$MOUNT_DIR/etc/fstab"

    exit $?
fi
