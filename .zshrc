# Copyright 2022 - Samuel Oechsler
# Minimal, personal configuration for ZShell

# Detect operating system and architecture
if uname -a | grep -q 'Darwin'; then
    export IS_MACOS=true
fi

if uname -a | grep -q 'Linux'; then
    export IS_LINUX=true
fi

if uname -a | grep -q 'arm64'; then
    export IS_ARM64=true
fi

# Load package manager specifc paths and initialize antigen
if [[ -v $IS_MACOS ]]; then
    if [[ -v IS_ARM64]]; then
        export BREW_INSTALL_PATH=/opt/homebrew
    else
        export BREW_INSTALL_PATH=/usr/local
    fi

    source $BREW_INSTALL_PATH/share/antigen/antigen.zsh
    eval "$($BREW_INSTALL_PATH/bin/brew shellenv)"
fi

if [[ -v $IS_LINUX ]]; then
    source /usr/share/zsh/share/antigen.zsh
fi

# Load the Oh-My-Zsh library
antigen use oh-my-zsh

# Install the following bundles
antigen bundle gitfast
antigen bundle gitignore

antigen bundle brew
antigen bundle macos
antigen bundle sudo
antigen bundle man
antigen bundle colorize
antigen bundle colored-man-pages
antigen bundle command-not-found

antigen theme spaceship-prompt/spaceship-prompt
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that we are done
antigen apply

# Register 1Password as ssh auth socket
if [[ -v $IS_MACOS ]]; then
    export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
fi

# Register askpass script for sudo
if [[ -v $IS_MACOS ]]; then
    export SUDO_ASKPASS=$HOME/.askpass.applescript
fi

# Register colorful directory listing
alias grep="grep --color=auto"
alias ls="ls --color=auto"
alias lt="tree -L 1 -C --dirsfirst"

# Set default editor to vim
export EDITOR="vim"

# General alias commands
alias vi="vim" # VIM as vi
alias cat="ccat" # Pygments with cat
alias dwget="wget -P $HOME/Downloads/" # Wget to downloads
alias screenfetch="neofetch" # Screenfetch with neofetch

# Custom extension functions

# Run tree after cd
cd() { builtin cd "$@" && tree -L 1 -C --dirsfirst; }

