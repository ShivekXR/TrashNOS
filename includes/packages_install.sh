check_install_exit_code() {
    install_exit_code=$?
    
    if [ $install_exit_code -ne 0 ]; then
        echo_error "Installation failed."
        exit $install_exit_code
    fi
}
export -f check_install_exit_code

install_full() {
    echo -e "$(text_blue "Installing fully:") $(text_white "$*")..."
    apt-get update > /dev/null
    apt-get install -y $* > /dev/null
    check_install_exit_code
}
export -f install_full

install_no_recommends() {
    echo -e "$(text_blue "Installing without recommends:") $(text_white "$*")..."
    apt-get update > /dev/null
    apt-get install -y --no-install-recommends $* > /dev/null
    check_install_exit_code
}
export -f install_no_recommends

install_packages() {
    if [[ ${#PACKAGES_FULL[@]} -ne 0 ]]; then
        install_full ${PACKAGES_FULL[*]}
    fi

    if [[ ${#PACKAGES_NO_RECOMMENDS[@]} -ne 0 ]]; then
        install_no_recommends ${PACKAGES_NO_RECOMMENDS[*]}
    fi
}
export -f install_packages
