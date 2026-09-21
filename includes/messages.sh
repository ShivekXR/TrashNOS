# Colors:
export RED='\e[91m'
export GREEN='\e[92m'
export YELLOW='\e[93m'
export BLUE='\e[94m'
export WHITE='\e[97m'
export NOCOLOR='\e[0m'

# Error message:
echo_error() {
    echo -e "${RED}ERROR:${NOCOLOR} $1" >&2
}
export -f echo_error

# Red text:
text_red() {
    printf "%s" "${RED}$1${NOCOLOR}"
}
export -f text_red

# Full red error message:
echo_error_red() {
    echo -e "$(text_red "ERROR: $1")" >&2
}
export -f echo_error_red

# Yellow text:
text_yellow() {
    printf "%s" "${YELLOW}$1${NOCOLOR}"
}
export -f text_yellow

# User action message:
echo_action() {
    echo -e -n "$(text_yellow "$1") "
}
export -f echo_action

# User warn:
echo_warn() {
    echo -e "${YELLOW}WARNING:${NOCOLOR} $1"
}
export -f echo_warn

# White text:
text_white() {
    printf "%s" "${WHITE}$1${NOCOLOR}"
}
export -f text_white

# White message:
echo_white() {
    echo -e "$(text_white "$1")"
}
export -f echo_white

# Error message:
echo_title() {
    echo -e "    $(text_white "---- $1 ----")"
}
export -f echo_title

# Blue text:
text_blue() {
    printf "%s" "${BLUE}$1${NOCOLOR}"
}
export -f text_blue
