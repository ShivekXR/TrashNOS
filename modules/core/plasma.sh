#!/usr/bin/env bash

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "PLASMA"

    chroot_exec \
<< EOF
PACKAGES_NO_RECOMMENDS=(
    plasma-desktop                                                      # minimal Plasma
    breeze-gtk-theme kde-config-gtk-style                               # GTK
    sddm sddm-theme-breeze kde-config-sddm                              # login screen
    systemsettings kscreen                                              # settings
    xdg-desktop-portal-kde kdialog plasma-integration                   # without those some parts of apps would render weirdly
)

PACKAGES_FULL=(
    konsole                                                             # terminal
    dolphin                                                             # file browser
    plasma-firewall                                                     # firewall
    plasma-nm                                                           # WiFi
    plasma-pa                                                           # audio
    bluedevil                                                           # bluetooth
    powerdevil                                                          # battery
    kinfocenter                                                         # system info / diagnostics
    kio-extras                                                          # trash settings, network drives, discover devices on local network, generate thumbnails, etc
)
install_packages

echo -e "Enabling $(text_white "sddm")."
systemctl enable sddm $SILENT
EOF

    exit 0
fi
