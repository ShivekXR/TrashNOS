echo_title "POST INSTALL"
echo "Cleaning up..."
umount -R "$MOUNT_DIR" &> /dev/null
cryptsetup close luks
