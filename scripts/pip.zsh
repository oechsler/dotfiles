#!/bin/zsh

# Copyright 2020 - Samuel Oechsler
# Installs packes from python pip(3)

install_pip() {
    if [[ $update == true ]]; then
        write_line ${YELLOW} "Skipping ${GREEN}pip${RBOLD}."
        return 0
    fi

    write_line ${GREEN} "Installing ${GREEN}pip${RBOLD}."

    # Evealuate which version of pip is used
    if [[ "$(which_os)" == "darwin" ]]; then
        if [[ $(command_exists pip3 -V) -ne 0 ]]; then
            write_line ${RED} "Dependency ${RED}pip3${RBOLD} not found."
            return 1
        fi

        pip_command=pip3
    else
        if [[ $(command_exists pip -V) -ne 0 ]]; then
            write_line ${RED} "Dependency ${RED}pip${RBOLD} not found."
            return 1
        fi

        pip_command=pip
    fi

    pip_list=./packages/${env:-default}_pip.list
    if [[ $debug == true ]]; then
        write_line ${BLUE} "Found install packages:"

        echo "$pip_command: $(read_list $pip_list)"
    else
        # Install packages specefied in pip.list
        if [[ -e $pip_list ]]; then
            $pip_command install $(read_list $pip_list)
        else
            write_line ${RED} "Missing ${RED}$pip_list${RBOLD} package list."
            return 1
        fi
    fi

    write_line ${GREEN} "Installed ${GREEN}pip${RBOLD}."
}
