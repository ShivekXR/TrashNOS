#!/usr/bin/env bash

SOURCE_FULL="$CONFIG_DIR/$1"
FILENAME=$(basename "$1")

if [[ "$EXEC_MODE" == "validate_arguments" ]]; then
    if [[ ! -f "$SOURCE_FULL" ]]; then
        echo_error "Missing $(text_white "$SOURCE_FULL") file."
        exit 2
    fi
    exit 0
fi

if [[ "$EXEC_MODE" == "execute" ]]; then
    destination="/etc/systemd/system/$FILENAME"
    echo -e "$(text_blue "Copying service into:") $(text_white "$destination")."
    destination_full="$MOUNT_DIR$destination"
    install -D -m 644 "$SOURCE_FULL" "$destination_full"
    
    echo -e "$(text_blue "Enabling:") $(text_white "$FILENAME")."
    chroot_exec \
<< EOF
systemctl enable "$FILENAME" $SILENT
EOF

    exit 0
fi


