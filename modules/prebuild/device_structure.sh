#!/usr/bin/env bash

# TODO: Script parameters for different partition names
# TODO: Script parameters for different partition sizes

DEVICE=$(get_arg "device")
LUKS_SIZE=$(get_arg "luks_size")

if [[ "$EXEC_MODE" == "validate_arguments" ]]; then
    # Ensure device was specified.
    if [[ -z "$DEVICE" || "$DEVICE" == "true" ]]; then
        echo_error "$(text_white "--device") parameter is required."
        exit 2
    fi

    # Ensure device exists.
    if [[ ! -b "$DEVICE" ]]; then
        echo_error "Device $(text_white "$DEVICE") does not exist or is invalid."
        exit 2
    fi

    exit 0
fi

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "PRE-PARTITIONING CHECK"

    echo -e "$(text_yellow "Please verify current") $(text_white "$DEVICE") $(text_yellow "structure:")"
    lsblk $DEVICE

    EFI_PARTITION_UUID=$(uuidgen)
    EFI_SFDISK="size=512MiB, type=uefi, name=\"Debian EFI\", uuid=$EFI_PARTITION_UUID"
    echo_warn "New $(text_white "EFI partition") will be created with following parameters:"
    echo "$EFI_SFDISK"

    BOOT_PARTITION_UUID=$(uuidgen)
    BOOT_SFDISK="size=1GiB, type=linux, name=\"Debian Boot\", uuid=$BOOT_PARTITION_UUID"
    echo_warn "New $(text_white "BOOT partition") will be created with following parameters:"
    echo "$BOOT_SFDISK"

    LUKS_PARTITION_UUID=$(uuidgen)
    if [[ -z "$LUKS_SIZE" || "$LUKS_SIZE" == "true" ]]; then
        echo_warn "$(text_white "--luks_size") was not specified!"
        LUKS_SFDISK="type=linux, name=\"Debian LUKS\", uuid=$LUKS_PARTITION_UUID"
    else
        LUKS_SFDISK="size=$LUKS_SIZE, type=linux, name=\"Debian LUKS\", uuid=$LUKS_PARTITION_UUID"
    fi
    echo_warn "New $(text_white "LUKS partition") will be created with following parameters:"
    echo "$LUKS_SFDISK"

    echo "EFI_PARTITION_UUID='$EFI_PARTITION_UUID'" >> "$STATE_MAIN"
    echo "EFI_SFDISK='$EFI_SFDISK'" >> "$STATE_MAIN"
    echo "BOOT_PARTITION_UUID='$BOOT_PARTITION_UUID'" >> "$STATE_MAIN"
    echo "BOOT_SFDISK='$BOOT_SFDISK'" >> "$STATE_MAIN"
    echo "LUKS_PARTITION_UUID='$LUKS_PARTITION_UUID'" >> "$STATE_MAIN"
    echo "LUKS_SFDISK='$LUKS_SFDISK'" >> "$STATE_MAIN"

    exit $?
fi
