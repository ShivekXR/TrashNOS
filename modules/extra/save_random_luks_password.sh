#!/usr/bin/env bash

LUKS_PASSWORD=$(get_arg "luks_password")

if [[ "$EXEC_MODE" == "execute" ]]; then
    if [[ "$LUKS_PASSWORD" != "random" ]]; then
        exit 0
    fi

    source "$STATE_MAIN"

    chroot_exec \
<< EOF
echo "$LUKS_PASSWORD" > "/home/\$ADMIN_NAME/___luks_password.txt"
EOF

    exit 0
fi
