# lazy-nvm.plugin.zsh
# author: Seong Yong-ju <sei40kr@gmail.com>

__nvm_loaded=false

__load_nvm() {
    unhash -f nvm_find_nvmrc
    unhash -f nvm

    __nvm_loaded=true
    . "${NVM_DIR:-${HOME}/.nvm}/nvm.sh"
}

nvm_find_nvmrc() {
    local dir="$PWD"

    while [[ "$dir" != '' && ! -f "${dir}/.nvmrc" ]]; do
        dir="${dir%/*}"
    done

    echo "${dir:+${dir}/.nvmrc}"
}

nvm() {
    __load_nvm

    nvm "$@"
}

__lazy_nvm_chpwd() {
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [[ "$__nvm_loaded" != true ]]; then
        if [[ -n "$nvmrc_path" ]]; then
            __load_nvm
        else
            return
        fi
    fi

    if [[ -n "$nvmrc_path" ]]; then
        local node_version="$(nvm version)"
        local nvmrc_node_version="$(nvm version "$(cat "$nvmrc_path")")"

        if [[ "$nvmrc_node_version" == 'N/A' ]]; then
            if [[ "$LAZY_NVM_AUTO_INSTALL" == true ]]; then
                nvm install
            fi
        elif [[ "$nvmrc_node_version" != "$node_version" ]]; then
            if [[ "$LAZY_NVM_SILENT_USE" == true ]]; then
                nvm use --silent
            else
                nvm use
            fi
        fi
    elif [[ "$node_version" != "$(nvm version default)" ]]; then
        if [[ "$LAZY_NVM_SILENT_USE" != true ]]; then
            echo "Reverting to nvm default version"
        fi

        nvm use default
    fi
}

chpwd_functions+=( __lazy_nvm_chpwd )

__lazy_nvm_chpwd
