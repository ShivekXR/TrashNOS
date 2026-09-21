#!/usr/bin/env bash

DEVICE=$(get_arg "device")

if [[ "$EXEC_MODE" == "validate_arguments" ]]; then
    pt_type=$(lsblk -d -n -o PTTYPE "$DEVICE")
    if [[ "$pt_type" != "gpt" ]]; then
        echo_error "Device $(text_white "$DEVICE") is not GPT."
        exit 1
    fi

    exit 0
fi

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "PARTITIONING"

    source "$STATE_MAIN"

    install_full parted

    echo "Creating partitions..."
    sfdisk --quiet --append --wipe always --wipe-partitions always "$DEVICE" \
<< EOF
$EFI_SFDISK
$BOOT_SFDISK
$LUKS_SFDISK
EOF

    if [ $? -ne 0 ]; then
        echo_error "Failed to create partitions. Aborting installation."
        exit 1
    fi

    # Update device UUID list to prevent race condition.
    partprobe "$DEVICE" > /dev/null
    udevadm settle > /dev/null

    exit $?
fi
