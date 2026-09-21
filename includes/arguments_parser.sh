#!/usr/bin/env bash

# Parse arguments.
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --*=*)
            KEY="${1%%=*}"; VALUE="${1#*=}"; KEY="${KEY#--}"
            export "ARG_${KEY^^}"="$VALUE"; shift 1
            ;;
        --*)
            KEY="${1#--}"
            if [[ -n "$2" && "$2" != -* ]]; then
                export "ARG_${KEY^^}"="$2"; shift 2
            else
                export "ARG_${KEY^^}"="true"; shift 1
            fi
            ;;
        *)
            echo_error "Invalid argument format for $(text_white "$1")"
            exit 2
            ;;
    esac
done

# Parameter getter:
get_arg() {
    local key="${1^^}"
    local var="ARG_${key}"
    printf "%s" "${!var}"
}
export -f get_arg
