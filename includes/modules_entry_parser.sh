parse_module_entry() {
    IFS='|' read -r -a parsed_array <<< "$1"
    module="${parsed_array[0]}"
    args=("${parsed_array[@]:1}")
}
export -f parse_module_entry
