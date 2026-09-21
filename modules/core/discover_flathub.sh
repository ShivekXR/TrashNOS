#!/usr/bin/env bash

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "DISCOVER & FLATHUB"

    chroot_exec \
<< EOF
PACKAGES_NO_RECOMMENDS=(
    plasma-discover packagekit appstream        # Plasma Discover
    flatpak plasma-discover-backend-flatpak     # Flatpak
)
install_packages

flatpak remote-add --system --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
appstreamcli refresh --force > /dev/null
EOF

    exit 0
fi
