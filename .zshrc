#!/bin/zsh
# Copyright 2021 - Samuel Oechsler
# Personal default settings for ZShell

# Detect sytem architecture
if uname -a | grep -q 'arm64'; then
    export IS_ARM64=true
fi
if uname -a | grep -q 'amd64'; then
    export IS_AMD64=true
fi

# Detect operating system
if uname -a | grep -q 'Darwin'; then
    export IS_MACOS=true
fi
if uname -a | grep -q 'Linux'; then
    export IS_LINUX=true
fi

# Set Homebrew installation path
if [[ $IS_MACOS == true ]]; then
    if [[ $IS_ARM64 == true ]]; then
        export BREW_INSTALL_PATH=/opt/homebrew
    else
        export BREW_INSTALL_PATH=/usr/local
    fi
fi

# Initialize antigen
if [[ $IS_MACOS == true ]]; then
    source $BREW_INSTALL_PATH/share/antigen/antigen.zsh
    eval "$($BREW_INSTALL_PATH/bin/brew shellenv)"
else
    source $HOME/.antigen.zsh
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
antigen bundle spaceship-prompt/spaceship-vi-mode@main
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that we are done
antigen apply

# Register askpass script for sudo
if [[ $IS_MACOS == true ]]; then
    export SUDO_ASKPASS=$HOME/.askpass.applescript
fi

# Initialize Spaceship prompt
eval spaceship_vi_mode_enable
SPACESHIP_VI_MODE_INSERT=i
SPACESHIP_VI_MODE_NORMAL=n
SPACESHIP_VI_MODE_COLOR=green
spaceship add --after line_sep vi_mode

# Initialize thefuck
eval $(thefuck --alias)

# Register colorful directory listing
alias grep="grep --color=auto"
alias ls="ls --color=auto"
alias lt="tree -L 1 -C --dirsfirst"

# Set default editor to vim
export EDITOR="vim"

# Set default pager to less
export PAGER="less"

# General alias commands
alias vi="vim" # Vim as vi
alias cat="ccat" # Pygments with cat
alias dwget="wget -P $HOME/Downloads/" # Wget to downloads
alias screenfetch="neofetch" # Screenfetch with neofetch

# SteamVR Lighthouse command
alias lh="$HOME/Games/steamvr_utils/scripts/steamvr_utils.py"

# Custom extension functions

# Run tree after cd
cd() { builtin cd "$@" && tree -L 1 -C --dirsfirst; }

# Clear the screen on startup
if [ -z "$MOTD" ]; then
  clear
  export MOTD=1
fi
