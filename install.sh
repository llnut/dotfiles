#!/bin/bash

#set -x

title="sora's dotfiles setup script"

CONFIG=$HOME/.config
LOCAL=$HOME/.local
DOTFILES=$(cd $(dirname $0);pwd)
COMMON=$DOTFILES/common
WM=$DOTFILES/wm
INSTALLWM=0
SETUP_SCRIPT=$HOME/.setup-script
AUR_HELPER=paru

lnbk() {
    rm -rf $2.bak
    if [ -e $2 ]; then
        mv -f $2 $2.bak
    fi
    ln -sb $1 $2
}

installNeeded() {
    if grep "Arch\|Artix\|EndeavourOS\|Manjaro" /etc/*-release ; then
        if (whiptail --title "Dependencies confirm" --yesno "Install wm?" 7 30); then
            echo "[*] You chose Yes. Will install wm dependencies."
            INSTALLWM=1
        fi
        usePacman

        mkdir -p $SETUP_SCRIPT

        echo "[*] Installing Rust..."
        if [[ ! -x $HOME/.cargo/bin/cargo ]] || [[ ! -x $HOME/.cargo/bin/rustc ]];then
            rust_init="/home/sora/.setup-script/rustup-init"
            curl -o $rust_init --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs
            chmod +x $rust_init && $rust_init -y
        fi
        echo -e "[*] cargo detected. Installing dependencies..."
        useCargo

        if [[ -e /usr/bin/paru ]] || [[ -e $HOME/.cargo/bin/paru ]]; then
            $AUR_HELPER=paru
        elif [[ -e /usr/bin/yay ]]; then
            $AUR_HELPER=yay
        else
            installAurHelper
        fi
        installNeeded
    else
        echo "[x] Not on a Arch based system. Failed to download dependencies. Please manually install it."
        exit
    fi

    installOptional
}

installNeeded() {
    if [[ $AUR_HELPER -eq paru ]]; then
        echo -e "[*] paru detected. Installing dependencies..."
        useParu
    elif [[ $AUR_HELPER -eq yay ]]; then
        echo -e "[*] yay detected. Installing dependencies..."
        useYay
    else
        echo "[x] An error occured."
        exit
    fi
}

usePacman() {
    echo "[*] Running an system update..."
    sudo pacman --noconfirm -Syyu

    # install base-devel if haven't already installed
    yes | sudo pacman -Sy --needed --overwrite "*" --nodeps `cat ./common/package/pacman` || exit 1
}

useParu() {
    #paru -Syu
    yes "y" | paru -S --noconfirm --useask --norebuild --needed --batchinstall --mflags --skipinteg --overwrite "*" --nodeps `cat ./common/package/aur` || exit 1
    if [[ $INSTALLWM -eq 1 ]]; then
        yes "y" | paru -S --noconfirm --useask --norebuild --needed --batchinstall --mflags --skipinteg --overwrite "*" --nodeps `cat ./wm/package/aur` || exit 1
    fi
}

useYay() {
    #yay -Syu
    yes "y" | yay -S --noconfirm --useask --norebuild --needed --batchinstall --mflags --skipinteg --overwrite "*" --nodeps `cat ./common/package/aur` || exit 1
    if [[ $INSTALLWM -eq 1 ]]; then
        yes "y" | yay -S --noconfirm --useask --norebuild --needed --batchinstall --mflags --skipinteg --overwrite "*" --nodeps `cat ./wm/package/aur` || exit 1
    fi
}

useCargo() {
    cargo install `cat ./common/package/cargo`
    if [[ $INSTALLWM -eq 1 ]]; then
        cargo install `cat ./wm/package/cargo`
    fi
}

installAurHelper() {
    optionals=$(whiptail --title "Install aur helper" --radiolist \
        "Choose your favourite aur helper" 10 102 2 \
        "paru" "Feature packed AUR helper writen in Rust." ON \
        "yay" "An AUR Helper Written in Go." OFF \
        3>&1 1>&2 2>&3
    )

    exitstatus=$?
    if [[ $exitstatus -eq 0 ]]; then
        case $optional in
            $optionals | "paru")
                cargo install paru
                echo "[*] paru installed. Installing dependencies..."
                useParu
                ;;
            "yay")
                git clone https://aur.archlinux.org/yay.git $HOME/.setup-scripto
                (cd $SETUP_SCRIPT && makepkg -si)
                echo "[*] yay installed. Installing dependencies..."
                useYay
                ;;
            *)
                echo "[x] An error occured. skip install $optional"
                ;;
        esac
    else
        echo "[x] You chose Cancel. Will not install any package manager."
        exit
    fi
}

installOptional() {
    optionals=$(whiptail --title "Checklist optional apps" --checklist \
        "Choose optionals" 10 102 2 \
        "du-dust" "A more intuitive version of du" OFF \
        "termusic" "Terminal Music Player written in Rust" OFF \
        "exa" "A modern replacement for ‘ls’"
        "RustScan" "The Modern Port Scanner"
        "hyperfine" "A command-line benchmarking tool"
        "himalaya" "CLI email client" OFF \
        "v2raya & xray" "A web GUI client to bypass network restrictions" OFF \
        "double borders" "From \"https://github.com/wmutils/opt.git\"" OFF \
        3>&1 1>&2 2>&3
    )

    exitstatus=$?
    if [[ $exitstatus -eq 0 ]]; then
        echo "[*] Will install $optionals"
        for optional in $optionals
        do
            echo "[*] Installing $optional..."
            case $optional in
                $optionals | "du-dust")
                    cargo install du-dust
                    ;;
                "termusic")
                    cargo install termusic
                    ;;
                "exa")
                    cargo install exa
                    ;;
                "RustScan")
                    cargo install rustscan
                    ;;
                "hyperfine")
                    cargo install hyperfine
                    ;;
                "fd")
                    paru -S --noconfirm fd
                    ;;
                "himalaya")
                    paru -S --noconfirm himalaya
                    ;;
                "v2raya & xray")
                    paru -S --noconfirm v2raya-bin xray-bin
                    ;;
                "double borders")
                    git clone https://github.com/wmutils/opt.git $SETUP_SCRIPT
                    (cd $SETUP_SCRIPT && make && sudo make install)
                    ;;
                *)
                    echo "[x] An error occured. skip install $optional"
                    ;;
            esac
        done
    else
        echo "[x] You chose Cancel. Will not install any apps."
    fi
}

commonFiles() {
    echo "[*] Apply common files..."
    sed -i "s|^DOTFILES=.*$|DOTFILES=$DOTFILES|g" ./common/config/.zshrc

    lnbk $COMMON/config/.config/nvim $CONFIG/nvim
    lnbk $COMMON/config/.config/gitui $CONFIG/gitui
    lnbk $COMMON/config/.config/alacritty $CONFIG/alacritty
    lnbk $COMMON/config/.config/rofi $CONFIG/rofi
    lnbk $COMMON/config/.config/ranger $CONFIG/ranger
    lnbk $COMMON/config/.config/himalaya $CONFIG/himalaya
    lnbk $COMMON/config/.config/bottom $CONFIG/bottom
    lnbk $COMMON/config/.tmux.conf $HOME/.tmux.conf
    lnbk $COMMON/config/.zshrc $HOME/.zshrc
    lnbk $COMMON/config/.gitconfig $HOME/.gitconfig
    lnbk $COMMON/config/.pam_environment $HOME/.pam_environment
    lnbk $COMMON/config/.cargo/config.toml $HOME/.cargo/config.toml

    mkdir -p $LOCAL/bin
    cp -rf $COMMON/config/bin/* $LOCAL/bin
    cp -rf $COMMON/config/oh-my-zsh-plugins/plugins/* $HOME/.oh-my-zsh/plugins
    mkdir -p $LOCAL/share/fonts
    cp -rf $COMMON/etc/fonts/* $LOCAL/share/fonts
    sudo cp -f $COMMON/config/paru/paru.conf /etc

    echo "[*] Apply common files successfully."
}


wmFiles() {
    if (whiptail --title "Apply wm config" \
        --no-button "Exit" --yes-button "Continue" \
        --yesno "Would you like to apply wm config?" 7 38); then
        echo "[*] Apply wm files..."
        lnbk $WM/config/.config/bspwm $CONFIG/bspwm
        lnbk $WM/config/.config/dunst $CONFIG/dunst
        lnbk $WM/config/.config/eww $CONFIG/eww
        lnbk $WM/config/.config/mpd $CONFIG/mpd
        lnbk $WM/config/.config/ncmpcpp $CONFIG/ncmpcpp
        lnbk $WM/config/.config/picom $CONFIG/picom
        lnbk $WM/config/.config/polybar $CONFIG/polybar
        lnbk $WM/config/.config/sxhkd $CONFIG/sxhkd

        mkdir -p $LOCAL/bin
        cp -rf $WM/config/bin/* $LOCAL/bin
        mkdir -p $LOCAL/share/fonts
        cp -rf $WM/etc/fonts/* $LOCAL/share/fonts
        mkdir -p $HOMW/Pictures/Wallpapers
        cp -rf $WM/etc/walls/* $HOME/Pictures/Wallpapers
        echo "[*] Apply wm files successfully."
    else
        echo "[!] Okay. Will not apply wm config."
    fi
}

finalizeChanges() {
    echo "[*] Refreshing font cache..."
    fc-cache -v

    echo "[*] Finalizing changes..."
}

welcome() {
    if (whiptail --title "$title" \
        --no-button "Exit" --yes-button "Continue" \
        --yesno "This process will download the needed dependencies and copy the config files to $HOME/.config. Would you like to continue?" 8 68); then
        echo "[*] Starting setup script..."
    else
        exit
    fi
}

checkNeeded() {
    if (whiptail --title "Dependencies install" \
        --no-button "Skip" --yes-button "Continue" \
        --yesno "Will install dependencies. Would you like to continue?" 7 60); then
        installNeeded
        checkDeprecated
    else
        echo "[!] Skip dependencies install."
    fi
}

checkDeprecated() {
    if (whiptail --title "Uninstall deprecated dependencies" \
        --no-button "Skip" --yes-button "Continue" \
        --yesno "Will uninstall deprecated dependencies. Would you like to continue?" 7 70); then
        #uninstallDeprecated
        echo
    else
        echo "[!] Skip uninstall deprecated dependencies."
    fi
}

success() {
    # Remove the custom directory made by the script
    rm -rf $SETUP_SCRIPT

    whiptail --title "$title" \
        --msgbox "Setup success. Please restart BSPWM if you are on an active session." 8 50
}

# Prompt user the welcome dialog
welcome

# Download dependencies
checkNeeded

# Apply config files
commonFiles
wmFiles

# Restart everything lol
finalizeChanges

# Show the success dialog when everything is fine
success
