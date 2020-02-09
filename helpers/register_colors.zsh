#!/bin/zash

# Copyright 2020 - Samuel Oechsler
# Exposes some fancy colors / text modes to variables

# Commands from: https://linux.101hacks.com/ps1-examples/prompt-color-using-tput/

register_colors() {
    if which tput > /dev/null 2>&1; then
        ncolors=$(tput colors)
    fi

    if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
        RED="$(tput setaf 1)"
        GREEN="$(tput setaf 2)"
        YELLOW="$(tput setaf 3)"
        BLUE="$(tput setaf 4)"

        BOLD="$(tput bold)"
        LINE="$(tput smul)"
        RESET="$(tput sgr0)"

        RBOLD="${RESET}${BOLD}"
    fi
}

register_colors
