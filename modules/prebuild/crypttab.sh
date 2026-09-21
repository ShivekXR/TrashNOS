#!/usr/bin/env bash

YUBIKEYS=$(get_arg "yubikeys")

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "CRYPTTAB"

    source "$STATE_MAIN"

    echo "Setting crypttab..."
    LUKS_UUID=$(blkid -s UUID -o value "$UUID_DIR/$LUKS_PARTITION_UUID")
    
    if is_integer_positive "$YUBIKEYS"; then
        entry="luks UUID=$LUKS_UUID none luks,keyscript=/usr/lib/fido2luks/keyscript.sh"
    else
        entry="luks UUID=$LUKS_UUID none luks"
    fi
    echo "$entry" > "$MOUNT_DIR/etc/crypttab"

    exit $?
fi
