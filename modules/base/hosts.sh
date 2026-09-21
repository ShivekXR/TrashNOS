#!/usr/bin/env bash

HOST_NAME="$1"

if [[ "$EXEC_MODE" == "validate_arguments" ]]; then
    if [[ -z "$HOST_NAME" ]]; then
        echo_error "Hostname not provided."
        exit 2
    fi

    exit 0
fi

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "HOSTS"

    echo -e "Setting $(text_white "/etc/hostname") to $(text_white "$HOST_NAME")."
    echo "$HOST_NAME" > "$MOUNT_DIR/etc/hostname"

    echo -e "Configuring $(text_white "/etc/hosts")."
    cat \
<< EOF > "$MOUNT_DIR/etc/hosts"
127.0.0.1 localhost
127.0.1.1 $HOST_NAME
::1       localhost ip6-localhost ip6-loopback
ff02::1   ip6-allnodes
ff02::2   ip6-allrouters
EOF

    exit 0
fi