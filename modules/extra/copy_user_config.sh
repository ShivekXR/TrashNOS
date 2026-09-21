#!/usr/bin/env bash

SOURCE_FULL="$CONFIG_DIR/$1"
FILENAME=$(basename "$2")
DESTINATION="$2"
PERMISSIONS="$3"

if [[ "$EXEC_MODE" == "validate_arguments" ]]; then
    if [[ ! -f "$SOURCE_FULL" ]]; then
        echo_error "Missing $(text_white "$SOURCE_FULL") file."
        exit 2
    fi
    if [[ -z "$PERMISSIONS" ]]; then
        echo_error "Config file permissions not provided."
        exit 2
    fi
    exit 0
fi

if [[ "$EXEC_MODE" == "execute" ]]; then
    tmp_file="/root/$FILENAME"
    tmp_file_full="$MOUNT_DIR$tmp_file"
    cp "$SOURCE_FULL" "$tmp_file_full"

    chroot_exec \
<< EOF
home_dir="/home/\$ADMIN_NAME"
destination_full="\$home_dir/$DESTINATION"

echo -e "$(text_blue "Copying user config into:") $(text_white "\$destination_full")."
install -D -m $PERMISSIONS "$tmp_file" "\$destination_full"

# Incrementally chown each part of the destination
current_path="\$home_dir"
IFS='/' read -ra path_parts <<< "$DESTINATION"

for part in "\${path_parts[@]}"; do
    if [[ -n "\$part" ]]; then
        current_path="\$current_path/\$part"
        chown \$ADMIN_NAME:\$ADMIN_NAME "\$current_path"
    fi
done
EOF

    rm -f "$tmp_file_full"

    exit 0
fi
