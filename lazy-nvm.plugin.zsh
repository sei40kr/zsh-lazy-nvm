# lazy-nvm.plugin.zsh
# author: Seong Yong-ju <sei40kr@gmail.com>

__should_load_nvm() {
    local dir="$PWD"

    if [[ "$dir" == / ]]; then
        dir=''
    fi

    while true; do
        if [[ -f "${dir}/.nvmrc" ]]; then
            return 0
        fi

        if [[ "$dir" == '' ]]; then
            return 1
        fi

        dir="${dir%/*}"
    done
}

__load_nvm() {
    . "${NVM_DIR:-${HOME}/.nvm}/nvm.sh"
}

__load_nvm_if_should() {
    if __should_load_nvm; then
        unhash -f nvm
        __load_nvm
        chpwd_functions=( "${chpwd_functions[@]:#__load_nvm_if_should}" )
    fi
}

if __should_load_nvm; then
    __load_nvm
else
    nvm() {
        unhash -f nvm
        __load_nvm
        chpwd_functions=( "${chpwd_functions[@]:#__load_nvm_if_should}" )

        nvm "$@"
    }

    chpwd_functions+=( __load_nvm_if_should )
fi
