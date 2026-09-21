#!/usr/bin/env bash

export EXEC_MODE="execute"

for entry in "${MODULES_LIST[@]}"; do
    parse_module_entry "$entry"
    script_path="$MODULES_DIR/$module"

    bash "$script_path" "${args[@]}"
    exit_code=$?

    if [[ $exit_code -eq 3 ]]; then
        echo_error_red "Safety check not passed."
        exit 3
    fi

    if [[ $exit_code -ne 0 ]]; then
        echo_error "Module $(text_white "$module") at $(text_white "$script_path") failed. Halting installation."
        while true; do
            continue_text="CONTINUE"
            quit_text="QUIT"
            echo_action "Type $continue_text to resume anyway or $quit_text to abort the installation:"
            
            read -r user_choice
            if [[ "$user_choice" == $continue_text ]]; then
                echo "Bypassing error. Installation resumed by user..."
                break
            elif [[ "$user_choice" == $quit_text ]]; then
                echo_error_red "Installation aborted by user."
                exit 2
            fi
        done
    fi
done
