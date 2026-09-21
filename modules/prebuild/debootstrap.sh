#!/usr/bin/env bash

ARCH="$1"

if [[ "$EXEC_MODE" == "validate_arguments" ]]; then
    if [[ -z "$ARCH" ]]; then
        echo_error "Architecture not specified."
        exit 2
    fi
    exit 0
fi

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "DEBOOTSTRAP"

    install_full debootstrap

    echo "Running debootstrap..."
    debootstrap --arch $ARCH "$MOUNT_DIR" https://deb.debian.org/debian > /dev/null
    
    exit $?
fi
