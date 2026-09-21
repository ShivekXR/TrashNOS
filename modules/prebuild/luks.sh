#!/usr/bin/env bash

LUKS_PASSWORD=$(get_arg "luks_password")
YUBIKEYS=$(get_arg "yubikeys")

if [[ "$EXEC_MODE" == "validate_arguments" ]]; then
    if is_integer "$YUBIKEYS" && ! is_integer_positive "$YUBIKEYS"; then
        echo_error "Wrong number of YubiKeys."
        exit 2
    fi

    exit 0
fi

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "LUKS"

    source "$STATE_MAIN"

    install_full cryptsetup
    if is_integer_positive "$YUBIKEYS"; then
        install_full systemd-cryptsetup
    fi

    if [[ "$LUKS_PASSWORD" == "random" ]]; then
        LUKS_PASSWORD=$(openssl rand -base64 24)
    elif [[ -z "$LUKS_PASSWORD" || "$LUKS_PASSWORD" == "true" ]]; then
        while true; do
            echo_action "Enter LUKS password:"
            read -s -r luks_pass1
            echo

            if [[ -z "$luks_pass1" ]]; then
                echo_error "Password cannot be empty. Please try again."
                continue
            fi

            echo_action "Confirm LUKS password:"
            read -s -r luks_pass2
            echo 

            if [[ "$luks_pass1" == "$luks_pass2" ]]; then
                LUKS_PASSWORD="$luks_pass1"
                break
            else
                echo_error "Passwords do not match. Please try again."
            fi
        done
    fi

    echo "Encrypting..."
    partition="$UUID_DIR/$LUKS_PARTITION_UUID"

    echo -n "$LUKS_PASSWORD" | cryptsetup luksFormat "$partition" -q -
    if [ $? -ne 0 ]; then
        echo_error "Failed to create LUKS container."
        exit 1
    fi

    echo -n "$LUKS_PASSWORD" | cryptsetup open "$partition" luks
    if [ $? -ne 0 ]; then
        echo_error "Failed to open LUKS container."
        exit 1
    fi

    echo "Adding YubiKeys ..."
    if is_integer_positive "$YUBIKEYS"; then
        for ((i=1; i<=$YUBIKEYS; i++)); do
            while true; do
                echo_action "YubiKey #$i"
                systemd-cryptenroll "$partition" \
                    --unlock-key-file=<(echo -n "$LUKS_PASSWORD") \
                    --fido2-device=auto \
                    --fido2-with-client-pin=yes \
                    --fido2-with-user-presence=yes
                if [ $? -ne 0 ]; then
                    echo_error "Try again..."
                    sleep 3
                    continue
                fi
                break
            done    
        done
    fi

    echo "LUKS_PASSWORD='$LUKS_PASSWORD'" >> "$STATE_MAIN"

    exit $?
fi
