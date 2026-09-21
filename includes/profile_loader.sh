#!/usr/bin/env bash

PROFILES_DIR="$SCRIPT_DIR/profiles"
PROFILE_NAME=$(get_arg "profile")

# Ensure profile name was provided.
if [[ -z "$PROFILE_NAME" || "$PROFILE_NAME" == "true" ]]; then
    echo_error "Profile name not provided. Use $(text_white "--profile <name>")."
    exit 2
fi

PROFILE_FILE="$PROFILES_DIR/${PROFILE_NAME}.conf"

# Ensure profile file exists.
if [[ ! -f "$PROFILE_FILE" ]]; then
    echo_error "Profile $(text_white "$PROFILE_NAME") not found at $(text_white "$PROFILE_FILE")."
    exit 2
fi

# Load module list.
source "$PROFILE_FILE"

# Ensure module list is loaded and non empty.
if [[ ${#MODULES_LIST[@]} -eq 0 ]]; then
    echo_error "Profile $(text_white "$PROFILE_NAME") is empty or invalid."
    exit 2
fi
