#!/usr/bin/env bash

GROUPS_TEXT="$1"

if [[ "$EXEC_MODE" == "execute" ]]; then
    chroot_exec \
<< EOF
usermod "\$ADMIN_NAME" --append --groups "$GROUPS_TEXT"
echo -e "$(text_blue "Adding groups to admin:") $(text_white "$GROUPS_TEXT")."
EOF
    exit 0
fi
