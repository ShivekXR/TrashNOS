is_integer() {
    local val="$1"
    [[ "$val" =~ ^[0-9]+$ ]]
}
export -f is_integer

is_integer_positive() {
    local val="$1"
    is_integer $val && [ "$val" -gt 0 ]
}
export -f is_integer_positive
