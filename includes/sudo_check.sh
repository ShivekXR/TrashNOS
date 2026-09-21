#!/usr/bin/env bash

# Ensure SUDO permission.
if [[ "$USER" != "root" ]]; then
    echo_error "No root privilege."
    exit 2
fi
