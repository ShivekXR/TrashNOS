#!/usr/bin/env bash

# TODO: Script parameters for different partition names

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "FORMATTING"

    source "$STATE_MAIN"

    install_full dosfstools

    echo "Formatting EFI..."
    mkfs.fat -F 32 "$UUID_DIR/$EFI_PARTITION_UUID" -n "DEBIAN EFI" > /dev/null

    echo "Formatting Boot..."
    mkfs.ext4 -q "$UUID_DIR/$BOOT_PARTITION_UUID" -L "Debian Boot"

    echo "Formatting LUKS..."
    mkfs.ext4 -q -L "Debian" "/dev/mapper/luks"

    exit $?
fi
