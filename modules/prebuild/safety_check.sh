#!/usr/bin/env bash

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "SAFETY CHECK"
    
    confirm_text="CONTINUE"
    echo_action "Type $confirm_text to resume:"
    read -r user_choice
    
    if [ "$user_choice" != $confirm_text ]; then
        echo_error "User typed $(text_white "$user_choice") instead of $(text_white "$confirm_text")."
        exit 3
    fi

    exit $?
fi
