#!/usr/bin/env bash

TARGET="$1"
SWAP_FROM="$2"
SWAP_INTO="$3"

if [[ "$EXEC_MODE" == "execute" ]]; then
    chroot_exec \
<< EOF
target_full="/home/\$ADMIN_NAME/$TARGET"
sed -i "s|%%$SWAP_FROM%%|$SWAP_INTO|g" "\$target_full"
EOF

    exit 0
fi
