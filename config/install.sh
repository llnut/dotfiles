#!/usr/bin/env bash

# 获取当前脚本的绝对路径
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    SCRIPT_DIR="$(cd "$(dirname "$0")" >/dev/null 2>&1 && pwd)"
else
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
fi

set -x

CONFIG_DIR="${HOME}/.config"
LOCAL_DIR="${HOME}/.local"

lnbk() {
    rm -rf ${2}_bk
    if [ -e $2 ]; then
        mv -f $2 ${2}_bk
    fi
    ln -sb $1 $2
}

lnbk ${SCRIPT_DIR}/.config/nushell ${CONFIG_DIR}/nushell
lnbk ${SCRIPT_DIR}/.config/nvim ${CONFIG_DIR}/nvim
lnbk ${SCRIPT_DIR}/.config/gitui ${CONFIG_DIR}/gitui
lnbk ${SCRIPT_DIR}/.config/alacritty ${CONFIG_DIR}/alacritty
lnbk ${SCRIPT_DIR}/.config/himalaya ${CONFIG_DIR}/himalaya
lnbk ${SCRIPT_DIR}/.config/bottom ${CONFIG_DIR}/bottom
lnbk ${SCRIPT_DIR}/.config/leftwm ${CONFIG_DIR}/leftwm
lnbk ${SCRIPT_DIR}/.config/starship ${CONFIG_DIR}/starship
lnbk ${SCRIPT_DIR}/.config/zellij ${CONFIG_DIR}/zellij
lnbk ${SCRIPT_DIR}/.config/dunst ${CONFIG_DIR}/dunst
lnbk ${SCRIPT_DIR}/.config/gdb ${CONFIG_DIR}/gdb
lnbk ${SCRIPT_DIR}/.tmux.conf ${HOME}/.tmux.conf
lnbk ${SCRIPT_DIR}/.zshrc ${HOME}/.zshrc
lnbk ${SCRIPT_DIR}/.gitconfig ${HOME}/.gitconfig
lnbk ${SCRIPT_DIR}/.pam_environment ${HOME}/.pam_environment
lnbk ${SCRIPT_DIR}/.asoundrc ${HOME}/.asoundrc
lnbk ${SCRIPT_DIR}/.cargo/config.toml ${HOME}/.cargo/config.toml

mkdir -p ${LOCAL_DIR}/bin
cp -rf ${SCRIPT_DIR}/bin/* ${LOCAL_DIR}/bin
sudo cp -f ${SCRIPT_DIR}/paru/paru.conf /etc
