#!/usr/bin/env bash

SOURCE_FULL="$CONFIG_DIR/$1"
DESTINATION="/$2"

if [[ "$EXEC_MODE" == "validate_arguments" ]]; then
    if [[ ! -f "$SOURCE_FULL" ]]; then
        echo_error "Missing $(text_white "$SOURCE_FULL") file."
        exit 2
    fi
    exit 0
fi

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo -e "$(text_blue "Copying system script into:") $(text_white "$DESTINATION")."
    install -D -m 755 "$SOURCE_FULL" "$MOUNT_DIR$DESTINATION"
    chmod +x "$MOUNT_DIR$DESTINATION"

    exit 0
fi
