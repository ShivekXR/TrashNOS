#!/usr/bin/env bash

DEVICE="/dev/$1"
ROWS="$2"
COLS="$3"

if [[ "$EXEC_MODE" == "validate_arguments" ]]; then
    if [[ ! -c "$DEVICE" ]]; then
        echo_error "$(text_white "$DEVICE") does not exist."
        exit 1
    fi

    if ! is_integer_positive "$ROWS"; then
        echo_error "Can't set stty size."
        exit 2
    fi

    if [[ ! -z "$COLS" ]] && ! is_integer_positive "$COLS"; then
        echo_error "Can't set stty size."
        exit 2
    fi

    exit 0
fi

if [[ "$EXEC_MODE" == "execute" ]]; then
    if is_integer_positive $COLS; then
        stty -F "$DEVICE" rows $ROWS cols $COLS
    else
        stty -F "$DEVICE" rows $ROWS
    fi
    exit $?
fi
