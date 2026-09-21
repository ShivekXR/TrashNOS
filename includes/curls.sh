curl_download() {
    curl -fsSL --retry 5 --retry-delay 2 --retry-all-errors "$1" -o "$2"
}
export -f curl_download
