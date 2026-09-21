if [[ $(get_arg "silent") == "true" ]]; then
    export SILENT="&> /dev/null"
else
    export SILENT=""
fi
