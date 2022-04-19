#!/usr/bin/env bash

set -x

CONFIG=${HOME}/.config
LOCAL=$HOME/.local
CURDIR=$(cd $(dirname $0);pwd)

function doIt() {
    lnbk $CURDIR/.config/nushell $CONFIG/nushell
    lnbk $CURDIR/.config/nvim $CONFIG/nvim
    lnbk $CURDIR/.config/gitui $CONFIG/gitui
    lnbk $CURDIR/.config/alacritty $CONFIG/alacritty
    lnbk $CURDIR/.config/rofi $CONFIG/rofi
    lnbk $CURDIR/.config/ranger $CONFIG/ranger
    lnbk $CURDIR/.config/himalaya $CONFIG/himalaya
    lnbk $CURDIR/.config/bottom $CONFIG/bottom
    lnbk $CURDIR/.tmux.conf $HOME/.tmux.conf
    lnbk $CURDIR/.zshrc $HOME/.zshrc
    lnbk $CURDIR/.gitconfig $HOME/.gitconfig
    lnbk $CURDIR/.pam_environment $HOME/.pam_environment
    lnbk $CURDIR/.cargo/config.toml $HOME/.cargo/config.toml

    mkdir -p $LOCAL/bin
    cp -rf $CURDIR/bin/* $LOCAL/bin
    cp -rf $CURDIR/oh-my-zsh-plugins/plugins/* $HOME/.oh-my-zsh/plugins
    sudo cp -f $CURDIR/paru/paru.conf /etc
}

function lnbk() {
    rm -rf ${2}_bk
    if [ -e $2 ]; then
        mv -f $2 ${2}_bk
    fi
    ln -sb $1 $2
}

doIt
