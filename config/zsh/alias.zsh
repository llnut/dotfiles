if hash nvim 2>/dev/null; then
    alias vi="nvim"
    alias vim="nvim"
fi

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi

# Filesystem aliases
alias ll="ls -alFh ${colorflag}"

# Helpers
alias grep="grep --color=auto --ignore-case"
