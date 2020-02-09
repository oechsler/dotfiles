#!/bin/zsh

# Copyright 2020 - Samuel Oechsler
# Determines the machines operating system

which_os() {
    if uname -a | grep -q 'Darwin'; then
        echo "darwin"
    elif uname -a | grep -q 'Linux'; then
        echo "linux"
    elif uname -a | grep -q 'Microsoft'; then
        echo "wsl"
    fi
}
