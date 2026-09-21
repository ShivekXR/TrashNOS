#!/usr/bin/env bash

ADMIN_NAME="$1"
ADMIN_PASSWORD=$(get_arg "admin_password")

if [[ "$EXEC_MODE" == "validate_arguments" ]]; then
    if [[ -z "$ADMIN_NAME" ]]; then
        echo_error "Admin name not provided."
        exit 2
    fi
    exit 0
fi

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "ADMIN ACCOUNT"

    echo "export ADMIN_NAME='$ADMIN_NAME'" >> "$STATE_CHROOT"

    if [[ -z "$ADMIN_PASSWORD" || "$ADMIN_PASSWORD" == "true" ]]; then
        while true; do
            echo_action "Enter password for $ADMIN_NAME:"
            read -s -r admin_pass1
            echo

            if [[ -z "$admin_pass1" ]]; then
                echo_error "Password cannot be empty. Please try again."
                continue
            fi

            echo_action "Confirm password:"
            read -s -r admin_pass2
            echo 

            if [[ "$admin_pass1" == "$admin_pass2" ]]; then
                ADMIN_PASSWORD="$admin_pass1"
                break
            else
                echo_error "Passwords do not match. Please try again."
            fi
        done
    fi

    echo -e "Setting $(text_white "$ADMIN_NAME") account..."
    
    chroot_exec \
<< EOF
useradd "$ADMIN_NAME" --groups "sudo" --shell "/bin/bash" --create-home

cat << PASS_EOF | chpasswd
$ADMIN_NAME:$ADMIN_PASSWORD
PASS_EOF

passwd -l root > /dev/null
EOF

    exit 0
fi
