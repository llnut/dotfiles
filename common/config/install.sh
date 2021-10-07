#!/usr/bin/env bash

set -x

CONFIG=${HOME}/.config
CURDIR=$(cd $(dirname $0);pwd)

function doIt() {
    lnbk ${CURDIR}/.config/nvim ${CONFIG}/nvim
    lnbk ${CURDIR}/.config/gitui ${CONFIG}/gitui
    lnbk ${CURDIR}/.config/alacritty ${CONFIG}/alacritty
    lnbk ${CURDIR}/.tmux.conf ${HOME}/.tmux.conf
    lnbk ${CURDIR}/.zshrc ${HOME}/.zshrc
    lnbk ${CURDIR}/.gitconfig ${HOME}/.gitconfig

    cp -rf ${CURDIR}/oh-my-zsh-plugins/plugins/* ${HOME}/.oh-my-zsh/plugins/
}

function lnbk() {
    rm -rf ${2}_bk
    if [ -e $2 ]; then
        mv -f $2 ${2}_bk
    fi
    ln -sb $1 $2
}

doIt
