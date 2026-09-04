export DOTFILES="$HOME/.dotfiles"
DOTFILES_BIN="$HOME/.dotfiles-bin"

export PATH="$DOTFILES/config/bin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/go/bin:$HOME/.cargo/bin:$HOME/.local/go/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export XDG_RUNTIME_DIR="$HOME/.cache/xdgr"

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

plugins=(
  zsh-autosuggestions vi-mode rust docker docker-compose
)

# Skip the completion security audit on startup. It rescans every fpath
# directory each time and adds no value for a single-user setup.
ZSH_DISABLE_COMPFIX=true

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Source all .zsh files inside the zsh/ directory
for config ($DOTFILES/config/zsh/*.zsh) source $config

proxy_on() {
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
    local proxy

    if (( $# > 0 )); then
        proxy=$1
        if [[ $proxy != *:* || ${proxy##*:} != <-> ]]; then
            >&2 echo "Invalid address, expected host:port"
            return 1
        fi
    else
        local username password server port pre
        echo -n "username: "; read username
        if [[ -n $username ]]; then
            echo -n "password: "; read -es password; echo
            pre="$username:$password@"
        fi
        echo -n "server: "; read server
        echo -n "port: "; read port
        proxy="$pre$server:$port"
    fi

    export http_proxy="$proxy" https_proxy="$proxy" \
           ftp_proxy="$proxy" rsync_proxy="$proxy" \
           HTTP_PROXY="$proxy" HTTPS_PROXY="$proxy" \
           FTP_PROXY="$proxy" RSYNC_PROXY="$proxy"
    echo "Proxy environment variable set."
}

proxy_off() {
    unset http_proxy https_proxy ftp_proxy rsync_proxy \
          HTTP_PROXY HTTPS_PROXY FTP_PROXY RSYNC_PROXY no_proxy
    echo "Proxy environment variable removed."
}

generate_random() {
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
}

source /usr/share/fzf/key-bindings.zsh

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

cargo-muslbuild() {
  docker run \
    -e http_proxy="${http_proxy}" \
    -e https_proxy="${https_proxy}" \
    -e no_proxy="${no_proxy}" \
    -v ~/.cargo/registry:/root/.cargo/registry \
    -v "$PWD:/volume" \
    --rm -i clux/muslrust:stable cargo build "$@"
}
