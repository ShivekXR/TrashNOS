#!/usr/bin/env bash

LOCALES=("$@")

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "LOCALE GENERATION"

    chroot_exec \
<< EOF
export LC_ALL=C

install_full locales
EOF

    echo -e "Setting $(text_white "locale.gen")."
    locale_gen_path="$MOUNT_DIR/etc/locale.gen"
    > "$locale_gen_path"
    for locale in "${LOCALES[@]}"; do
        echo "$locale.UTF-8 UTF-8" >> "$locale_gen_path"
    done

    chroot_exec \
<< EOF
export LC_ALL=C

echo "Generating locales..."
locale-gen > /dev/null
EOF

    exit 0
fi
