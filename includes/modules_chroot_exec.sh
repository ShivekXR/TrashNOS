chroot_exec() {
    target_state_file=/root/state_chroot.env
    cp "$STATE_CHROOT" "$MOUNT_DIR$target_state_file"
    
    arch-chroot "$MOUNT_DIR" /bin/bash \
<< EOF
source $target_state_file
$(cat)
EOF
    chroot_exit_code=$?
    
    rm -f "$MOUNT_DIR$target_state_file"

    if [ $chroot_exit_code -ne 0 ]; then
        echo_error "Chroot operation failed."
        exit $chroot_exit_code
    fi
}
export -f chroot_exec
