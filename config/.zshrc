DOTFILES="$HOME/.dotfiles"
DOTFILES_BIN="$HOME/.dotfiles-bin"
export DOTFILES=$DOTFILES
# If you come from bash you might have to change your $PATH.
export PATH=$DOTFILES/config/bin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/go/bin:$HOME/.cargo/bin:$HOME/.local/go/bin:$PATH
export MANPATH=/usr/local/man:$HOME/.man:`manpath` >/dev/null 2>&1
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
# fnm - fast node manager
export XDG_RUNTIME_DIR="$HOME/.cache/xdgr"

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e #normal input mode
#bindkey -v #vim input mode

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="random"

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename $HOME/.zshrc

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$DOTFILES/config/oh-my-zsh-plugins

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  zsh-autosuggestions vi-mode rust docker docker-compose
)

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
export LANG=en_US.UTF-8
#export LANGUAGE=en_US.UTF-8
#export LC_ALL=en_US.UTF-8
#export LC_LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Source all .zsh files inside the zsh/ directory
for config ($DOTFILES/config/zsh/*.zsh) source $config

proxy_on() {
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"

    if (( $# > 0 )); then
        valid=$(echo $@ | sed -n 's/\([0-9]\{1,3\}.\?\)\{4\}:\([0-9]\+\)/&/p')
        if [[ $valid != $@ ]]; then
            >&2 echo "Invalid address"
            return 1
        fi
        local proxy=$1
        export http_proxy="$proxy" \
               https_proxy=$proxy \
               ftp_proxy=$proxy \
               rsync_proxy=$proxy
        echo "Proxy environment variable set."
        return 0
    fi

    echo -n "username: "; read username
    if [[ $username != "" ]]; then
        echo -n "password: "
        read -es password
        local pre="$username:$password@"
    fi

    echo -n "server: "; read server
    echo -n "port: "; read port
    local proxy=$pre$server:$port
    export http_proxy="$proxy" \
           https_proxy=$proxy \
           ftp_proxy=$proxy \
           rsync_proxy=$proxy \
           HTTP_PROXY=$proxy \
           HTTPS_PROXY=$proxy \
           FTP_PROXY=$proxy \
           RSYNC_PROXY=$proxy
}

proxy_off() {
    unset http_proxy https_proxy ftp_proxy rsync_proxy \
          HTTP_PROXY HTTPS_PROXY FTP_PROXY RSYNC_PROXY
    echo -e "Proxy environment variable removed."
}

generate_random() {
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
}

fpath=($DOTFILES/config/oh-my-zsh-plugins/functions/ $fpath)

#if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#    #tmux attach -t default || tmux new -s default
#    tmux
#fi

autoload -Uz compinit
compinit

eval "$(fnm env --use-on-cd)"

source /usr/share/fzf/key-bindings.zsh

# rg bash_completion
[ -f "$DOTFILES_BIN/ripgrep/complete/rg.bash" ] && \. "$DOTFILES_BIN/ripgrep/complete/rg.bash"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
