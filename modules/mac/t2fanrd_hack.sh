#!/usr/bin/env bash

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "T2FANRD HACK"

    chroot_exec \
<< EOF
trap 'mv -f /usr/bin/systemctl.real /usr/bin/systemctl 2>/dev/null' EXIT INT TERM

mv /usr/bin/systemctl /usr/bin/systemctl.real
echo '#!/bin/sh' > /usr/bin/systemctl
echo 'exit 0' >> /usr/bin/systemctl
chmod +x /usr/bin/systemctl

install_full t2fanrd

mv -f /usr/bin/systemctl.real /usr/bin/systemctl

systemctl enable "t2fanrd.service" $SILENT

trap - EXIT INT TERM
EOF

    exit 0
fi
