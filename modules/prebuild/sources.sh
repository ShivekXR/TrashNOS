#!/usr/bin/env bash

CODENAME="$1"

if [[ "$EXEC_MODE" == "validate_arguments" ]]; then
    if [[ -z "$CODENAME" ]]; then
        echo_error "Codename not specified."
        exit 2
    fi
    exit 0
fi

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "OFFICIAL REPOSITORIES"

    echo "Generating sources.list..."
    cat \
<< EOF > "$MOUNT_DIR/etc/apt/sources.list"
# Base
deb https://deb.debian.org/debian/ $CODENAME main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian/ $CODENAME main contrib non-free non-free-firmware

# Security
deb https://security.debian.org/debian-security $CODENAME-security main contrib non-free non-free-firmware
deb-src https://security.debian.org/debian-security $CODENAME-security main contrib non-free non-free-firmware

# Updates
deb https://deb.debian.org/debian/ $CODENAME-updates main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian/ $CODENAME-updates main contrib non-free non-free-firmware
EOF

    exit $?
fi
