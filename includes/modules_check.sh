#!/usr/bin/env bash

# Ensure required modules exist.
for entry in "${MODULES_LIST[@]}"; do
    parse_module_entry "$entry"
    script_path="$MODULES_DIR/$module"
    if [[ ! -f "$script_path" ]]; then
        echo_error "Module $(text_white "$module") not found at $(text_white "$script_path")."
        exit 2
    fi
done

# Validate arguments.
export EXEC_MODE="validate_arguments"

for entry in "${MODULES_LIST[@]}"; do
    parse_module_entry "$entry"
    script_path="$MODULES_DIR/$module"

    bash "$script_path" "${args[@]}"
    exit_code=$?

    if [[ $exit_code -ne 0 ]]; then
        echo_error "Argument validation failed in $(text_white "$module") module at $(text_white "$script_path"). Aborting installation."
        exit $exit_code
    fi
done
