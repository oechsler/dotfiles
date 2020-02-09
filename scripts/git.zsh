#!/bin/zsh

# Copyright 2020 - Samuel Oechsler
# Configures local git installation

install_git() {
    if [[ $debug == true ]]; then
        write_line ${YELLOW} "Skipping ${GREEN}git${RBOLD}."
        return 0
    fi

    write_line ${GREEN} "Installing ${GREEN}git${RBOLD}."

    # Create user specific .gitconfig
    gitconfig=./configs/${env:-default}.gitconfig
    if [[ -e $gitconfig ]]; then
        # Create user specific .gitconfig
        cat $gitconfig > $PWD/$USER.gitconfig
        git add --all && git commit -m "Add user specific .gitconfig"

        # Register symbolic link to ~/.gitconfig
        ln -s $PWD/$USER.gitconfig $HOME/.gitconfig
    else
        write_line ${RED} "Missing ${RED}$gitconfig${RBOLD} config."
        return 1
    fi

    # Create user specific .gitignore_global
    gitignore_global=./configs/${env:-default}.gitignore_global
    if [[ -e $gitignore_global ]]; then
        # Create user specific .gitignore_global
        cat $gitignore_global > $PWD/$USER.gitignore_global
        git add --all && git commit -m "Add user specific .gitignore_global"

        # Register symbolic link to ~/.gitignore_global
        ln -s $PWD/$USER.gitignore_global $HOME/.gitignore_global
    else
        write_line ${RED} "Missing ${RED}$gitignore_global${RBOLD} config."
        return 1
    fi

    write_line ${GREEN} "Installed ${GREEN}git${RBOLD}."
}

remove_git() {
    write_line ${RED} "Removing ${RED}git${RBOLD}."

    # Remove symbolic links in home folder
    rm $HOME/.gitconfig $HOME/.gitignore_global
    rm $PWD/$USER.gitconfig $PWD/$USER.gitignore_global

    write_line ${RED} "Removed ${RED}git${RBOLD}."
}
