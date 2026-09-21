#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
INCLUDES_DIR="$SCRIPT_DIR/includes"
MODULES_DIR="$SCRIPT_DIR/modules"
export UUID_DIR="/dev/disk/by-partuuid"
export MOUNT_DIR="/mnt"
export CONFIG_DIR="$SCRIPT_DIR/configs"

source "$INCLUDES_DIR/messages.sh"
source "$INCLUDES_DIR/sudo_check.sh"
source "$INCLUDES_DIR/state_files.sh"
source "$INCLUDES_DIR/functions.sh"
source "$INCLUDES_DIR/arguments_parser.sh" $@
source "$INCLUDES_DIR/silent.sh"
source "$INCLUDES_DIR/profile_loader.sh"
source "$INCLUDES_DIR/packages_install.sh"
source "$INCLUDES_DIR/curls.sh"
source "$INCLUDES_DIR/modules_entry_parser.sh"
source "$INCLUDES_DIR/modules_chroot_exec.sh"
source "$INCLUDES_DIR/modules_check.sh"
source "$INCLUDES_DIR/modules_execute.sh"
source "$INCLUDES_DIR/cleanup.sh"
