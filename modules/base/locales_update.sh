#!/usr/bin/env bash

LANGUAGE="$1"
shift
PARAMS=("$@")

if [[ "$EXEC_MODE" == "validate_arguments" ]]; then
    if [[ -z "$LANGUAGE" || ${#PARAMS[@]} -eq 0 ]]; then
        echo_error "Missing locale parameters."
        exit 2
    fi
    exit 0
fi

if [[ "$EXEC_MODE" == "execute" ]]; then
    echo_title "LOCALE DEFAULTS"

    echo "Saving preffered locales."
    echo "export LANGUAGE=$LANGUAGE" >> "$STATE_CHROOT"
    for param in "${PARAMS[@]}"; do
        echo "export $param.UTF-8" >> "$STATE_CHROOT"
    done

    chroot_exec \
<< EOF
echo "Updating locales..."
update-locale LANGUAGE=$LANGUAGE
for param in ${PARAMS[@]}; do
    update-locale \$param.UTF-8
done
EOF

    exit 0
fi
