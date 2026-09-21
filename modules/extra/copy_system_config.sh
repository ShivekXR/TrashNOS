#!/usr/bin/env bash

SOURCE_FULL="$CONFIG_DIR/$1"
DESTINATION="/$2"
PERMISSIONS="$3"

if [[ "$EXEC_MODE" == "validate_arguments" ]]; then
    if [[ ! -f "$SOURCE_FULL" ]]; then
        echo_error "Missing $(text_white "$SOURCE_FULL") file."
        exit 2
    fi
    if [[ -z "$PERMISSIONS" ]]; then
        echo_error "Config file permissions not provided."
        exit 2
    fi
    exit 0
fi

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo -e "$(text_blue "Copying system config into:") $(text_white "$DESTINATION")."
    install -D -m $PERMISSIONS "$SOURCE_FULL" "$MOUNT_DIR$DESTINATION"

    exit 0
fi
