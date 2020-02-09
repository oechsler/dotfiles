#!/bin/zsh

# Copyright 2020 - Samuel Oechsler
# Installs packages from the App Store

install_mas() {
    if [[ "$(which_os)" != "darwin" ]]; then
        write_line ${YELLOW} "Skipping ${GREEN}mas${RBOLD}0"""
        return 1
    fi

    write_line ${GREEN} "Installing ${GREEN}mas${RBOLD}."

    if [[ $(command_exists mas version) -ne 0 ]]; then
        write_line ${RED} "Dependency ${RED}mas${RBOLD} not found."
        return 1
    fi

    # Prompt user to login to the App Store manually
    # Mas is no longer able to autoammte this task (since macOS 10.14)
    open "/System/Applications/App Store.app"
    write_line ${BLUE} "Please logint to the ${BLUE}App Store${RBOLD}."
    printf "${YELLOW}==>${RBOLD} Press enter to continue${RESET} "; read

    if [[ -z "$(mas account | egrep -o '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b')" ]]; then
        write_line ${RED} "There is no Apple-ID connectd to the App Store."
        return 1
    fi

    mas_list=./packages/${env:-default}_mas.list
    if [[ $debug == true ]]; then
        write_line ${BLUE} "Found install packages:"

        echo "mas: $(read_list_num $mas_list)"
    else
        if [[ -e $cask_list ]]; then
            mas install $(read_list_num $mas_list)
        else
            write_line ${RED} "Missing ${RED}$mas_list${RBOLD} package list."
            return 1
        fi
    fi

    write_line ${GREEN} "Installed ${GREEN}mas${RBOLD}."
}

update_mas() {
    if [[ "$(which_os)" != "darwin" ]]; then
        write_line ${YELLOW} "Skipping ${GREEN}homebrew${RBOLD}."
        return 0
    fi

    write_line ${GREEN} "Updating ${RED}mas${RBOLD}."

    # Run mas update commands
    mas upgrade

    write_line ${GREEN} "Updated ${RED}mas${RBOLD}."
}
