#!/usr/bin/env bash

CODENAME="$1"
VERSION="$2"

if [[ "$EXEC_MODE" == "validate_arguments" ]]; then
    if [[ -z "$CODENAME" ]]; then
        echo_error "Codename not specified."
        exit 2
    fi
    exit 0
fi

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "T2 KERNEL"

    if [[ -z "$VERSION" ]]; then
        t2_package="linux-t2"
    else
        t2_package="linux-t2=$VERSION-$CODENAME"
    fi

    chroot_exec \
<< EOF
echo "Setting T2 repository..."
curl -s --compressed "https://adityagarg8.github.io/t2-ubuntu-repo/KEY.gpg" | gpg --dearmor > "/etc/apt/trusted.gpg.d/t2-ubuntu-repo.gpg"
curl -s --compressed -o "/etc/apt/sources.list.d/t2.list" "https://adityagarg8.github.io/t2-ubuntu-repo/t2.list"
echo "deb [signed-by=/etc/apt/trusted.gpg.d/t2-ubuntu-repo.gpg] https://github.com/AdityaGarg8/t2-ubuntu-repo/releases/download/${CODENAME} ./" >> "/etc/apt/sources.list.d/t2.list"

echo "Installing T2 Kernel..."
install_full $t2_package dkms
EOF

    exit 0
fi
