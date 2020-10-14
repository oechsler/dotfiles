#!/bin/zsh

# Copyright 2020 - Samuel Oechsler
# Checks / creates a file that identefies
# an existing installation of the dotfiles

is_installed() {
    if [[ $update == true ]]; then
        return 0
    fi

    if [[ $debug == true ]] ||
        [[ ! -e $HOME/.installed ]]; then
        return 1
    fi
}

set_installed() {
    if [[ $debug == true ]]; then
        return 0
    fi

    if [[ $remove != true ]] && [[ $1 == true ]]; then
        touch $HOME/.installed
    else
        rm -f $HOME/.installed
    fi
}
