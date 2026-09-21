#!/usr/bin/env bash

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "MOUNT"

    source "$STATE_MAIN"

    echo "Mounting..."
    mount "/dev/mapper/luks" "$MOUNT_DIR"
    mount --mkdir "$UUID_DIR/$EFI_PARTITION_UUID" "$MOUNT_DIR/efi"
    mount --mkdir "$UUID_DIR/$BOOT_PARTITION_UUID" "$MOUNT_DIR/boot"

    exit $?
fi
