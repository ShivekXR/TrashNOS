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
    echo -e "$(text_blue "Adding apt repo:") $(text_white "$FILENAME")."
    install -D "$SOURCE_FULL" "$MOUNT_DIR/etc/apt/sources.list.d/$FILENAME"

    exit 0
fi
