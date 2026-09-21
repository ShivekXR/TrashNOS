#!/usr/bin/env bash

KEYBOARD="$1"
KEYBOARD_FULL="$CONFIG_DIR/keyboard/${KEYBOARD}.conf"

if [[ "$EXEC_MODE" == "validate_arguments" ]]; then
    if [[ -z "KEYBOARD" || ! -f "$KEYBOARD_FULL" ]]; then
        echo_error "No keyboard configuration file provided."
        exit 2
    fi
    exit 0
fi

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "CONSOLE & KEYBOARD"

    echo -e "Copying configuration from $(text_white "$KEYBOARD")..."
    cp "$KEYBOARD_FULL" "$MOUNT_DIR/etc/default/keyboard"

    chroot_exec \
<< EOF
install_full console-setup console-setup-linux kbd

echo "Applying keyboard layout..."
setupcon $SILENT
EOF

    exit 0
fi
