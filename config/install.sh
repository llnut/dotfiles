#!/usr/bin/env bash

set -x

CONFIG_DIR="${HOME}/.config"
LOCAL_DIR="${HOME}/.local"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

doIt() {
    lnbk ${SCRIPT_DIR}/.config/nushell ${CONFIG}/nushell
    lnbk ${SCRIPT_DIR}/.config/nvim ${CONFIG}/nvim
    lnbk ${SCRIPT_DIR}/.config/gitui ${CONFIG}/gitui
    lnbk ${SCRIPT_DIR}/.config/alacritty ${CONFIG}/alacritty
    lnbk ${SCRIPT_DIR}/.config/himalaya ${CONFIG}/himalaya
    lnbk ${SCRIPT_DIR}/.config/bottom ${CONFIG}/bottom
    lnbk ${SCRIPT_DIR}/.config/leftwm ${CONFIG}/leftwm
    lnbk ${SCRIPT_DIR}/.config/starship ${CONFIG}/starship
    lnbk ${SCRIPT_DIR}/.config/zellij ${CONFIG}/zellij
    lnbk ${SCRIPT_DIR}/.config/dunst ${CONFIG}/dunst
    lnbk ${SCRIPT_DIR}/.tmux.conf ${HOME}/.tmux.conf
    lnbk ${SCRIPT_DIR}/.zshrc ${HOME}/.zshrc
    lnbk ${SCRIPT_DIR}/.gitconfig ${HOME}/.gitconfig
    lnbk ${SCRIPT_DIR}/.pam_environment ${HOME}/.pam_environment
    lnbk ${SCRIPT_DIR}/.asoundrc ${HOME}/.asoundrc
    lnbk ${SCRIPT_DIR}/.cargo/config.toml ${HOME}/.cargo/config.toml

    mkdir -p ${LOCAL_DIR}/bin
    cp -rf ${SCRIPT_DIR}/bin/* ${LOCAL_DIR}/bin
    sudo cp -f ${SCRIPT_DIR}/paru/paru.conf /etc
}

lnbk() {
    rm -rf ${2}_bk
    if [ -e $2 ]; then
        mv -f $2 ${2}_bk
    fi
    ln -sb $1 $2
}

doIt
