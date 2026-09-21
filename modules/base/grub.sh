#!/usr/bin/env bash

GRUB_PACKAGES="$1"
GRUB_PARAMS="$2"
GRUB_CMDLINE="$3"

if [[ "$EXEC_MODE" == "validate_arguments" ]]; then
    if [[ -z "$GRUB_PACKAGES" ]]; then
        echo_error "Grub packages not specified."
        exit 2
    fi

    if [[ -z "$GRUB_PARAMS" ]]; then
        echo_error "Grub params not specified."
        exit 2
    fi

    exit 0
fi

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "BOOTLOADER"

    mkdir -p "$MOUNT_DIR/etc/default/grub.d"
    echo "GRUB_CMDLINE_LINUX_DEFAULT=\"$GRUB_CMDLINE\"" > "$MOUNT_DIR/etc/default/grub.d/99_cmdline.cfg"
    echo "GRUB_TIMEOUT=1" > "$MOUNT_DIR/etc/default/grub.d/99_timeout.cfg"

    chroot_exec \
<< EOF
install_full $GRUB_PACKAGES

echo "Creating bootloader..."
update-initramfs -u -k all $SILENT
grub-install --efi-directory=/efi $GRUB_PARAMS $SILENT
update-grub $SILENT
EOF

    exit 0
fi
