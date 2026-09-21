#!/usr/bin/env bash

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "AUDIO"

    chroot_exec \
<< EOF
PACKAGES_FULL=(
    pipewire-audio pipewire-jack wireplumber            # core
    pipewire-pulse pulseaudio-utils                     # compatibility
    pipewire-alsa alsa-utils                            # ALSA
    rtkit                                               # scheduler
)
install_packages

echo -e "Enabling $(text_white "pipewire")."
systemctl --global enable pipewire wireplumber pipewire-pulse
EOF

    exit 0
fi
