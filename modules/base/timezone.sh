#!/usr/bin/env bash

TIME_ZONE="$1"

if [[ "$EXEC_MODE" == "validate_arguments" ]]; then
    if [[ -z "$TIME_ZONE" ]]; then
        echo_error "No timezone provided."
        exit 2
    fi
    exit 0
fi

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "TIMEZONE"

    chroot_exec \
<< EOF
install_full systemd-timesyncd

echo -e "Setting timezone to $(text_white "$TIME_ZONE")..."
ln -fs "/usr/share/zoneinfo/$TIME_ZONE" "/etc/localtime"
echo "$TIME_ZONE" > "/etc/timezone"
dpkg-reconfigure -f noninteractive tzdata $SILENT
EOF

    exit 0
fi
