#!/bin/zsh

# Copyright 2020 - Samuel Oechsler
# Enables versioning with git

version_control_pre() {
    if is_installed; then
        # Remove persistent installation state for upgrade
        set_installed false

        # Stash local changes the user did to files
        git stash

        # Checkout and pull the master branch for updates
        git checkout master
        git pull --no-edit
    fi
}

version_control_post() {
    if [[ $debug != true ]] && [[ $remove != true ]]; then
        if ! is_installed; then
            # Enable version control
            git checkout -b rev_installed
        else
            # Save current changes to a version specific change with user provided label
            write_line ${BLUE} "Labels currently in use:"
            git branch | cat

            # Prompt user for a personal version specific branch name
            echo "${YELLOW}==>${RBOLD} Provide a unique label for this update:${GREEN} "
            read label; echo "${RESET}"

            git branch -D rev_${label:-current}
            git checkout -b rev_${label:-current}
            git merge master --no-edit

            # Pop the local changes from git stash
            git stash pop
        fi
    elif [[ $remove == true ]]; then
        # Disable version control
        git branch -D rev_installed
    fi

    branch_name=$(git rev-parse --abbrev-ref HEAD)
    write_line ${BLUE} "Switched to branch ${BLUE}$branch_name${RBOLD}."

    # Persist the installation state
    set_installed true
}
