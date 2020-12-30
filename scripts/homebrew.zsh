#!/bin/zsh

# Copyright 2020 - Samuel Oechsler
# Installs the homebrew packagemanger on macOS

install_homebrew() {
    if [[ "$(which_os)" != "darwin" ]]; then
        write_line ${YELLOW} "Skipping ${GREEN}homebrew${RBOLD}."
        return 0
    fi

    write_line ${GREEN} "Installing ${GREEN}homebrew${RBOLD}."

    if [[ $(command_exists ruby --version) -ne 0 ]]; then
        write_line ${RED} "Dependency ${RED}ruby${RBOLD} not found."
        return 1
    fi

    if [[ $debug != true ]]; then
        # Execute the homebrew installer
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi

    if [[ $(command_exists brew --version) -ne 0 ]]; then
        write_line ${RED} "Dependency ${RED}homebrew${RBOLD} not found."
        return 1
    fi

    brew_list=./packages/${env:-default}_brew.list
    cask_list=./packages/${env:-default}_cask.list
    if [[ $debug == true ]]; then
        write_line ${BLUE} "Found install packages:"

        echo "brew: $(read_list $brew_list)"
        echo "cask: $(read_list $cask_list)"
    else
        # Tap common hombrew taps
        brew tap homebrew/cask-versions
        brew tap homebrew/cask-drivers
        brew tap homebrew/cask-fonts
        brew tap homebrew/services
        brew tap beeftornado/rmtree

        # Install AppStore support
        brew install mas

        # Install packages specefied in brew.list and cask.list
        if [[ -e $brew_list ]]; then
            brew install $(read_list $brew_list)
        else
            write_line ${RED} "Missing ${RED}$brew_list${RBOLD} package list."
            return 1
        fi

        if [[ -e $cask_list ]]; then
            brew install --cask $(read_list $cask_list)
        else
            write_line ${RED} "Missing ${RED}$cask_list${RBOLD} package list."
            return 1
        fi
    fi

    write_line ${GREEN} "Installed ${GREEN}homebrew${RBOLD}."
}

update_homebrew() {
    if [[ "$(which_os)" != "darwin" ]]; then
        write_line ${YELLOW} "Skipping ${GREEN}homebrew${RBOLD}."
        return 0
    fi

    write_line ${GREEN} "Updating ${GREEN}homebrew${RBOLD}."

    # Run hombrew update commands
    brew update; brew upgrade

    write_line ${GREEN} "Updated ${GREEN}homebrew${RBOLD}."
}
