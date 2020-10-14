#!/bin/zsh

# Copyright 2020 - Samuel Oechsler
# Installs the sdkman packagemanger

install_sdkman() {
    write_line ${GREEN} "Installing ${GREEN}sdkman${RBOLD}."

    if [[ $debug != true ]]; then
        # Execute the sdkman installer
        curl -s "https://get.sdkman.io?rcupdate=false" | bash
        source "$HOME/.sdkman/bin/sdkman-init.sh"
    fi

    if [[ $(command_exists sdk version) -ne 0 ]]; then
        write_line ${RED} "Dependency ${RED}sdkman${RBOLD} not found."
        return 1
    fi

    sdk_list=./packages/${env:-default}_sdk.list
    if [[ $debug == true ]]; then
        write_line ${BLUE} "Found install packages:"

        echo "sdk:"
        cat $sdk_list | while read target; do
            echo $target
        done
    else
        # Install packages specified in sdk.list
        if [[ -e $sdk_list ]]; then
            cat $sdk_list | while read target; do
                sdk install $target
            done
        else
            write_line ${RED} "Missing ${RED}$sdk_list${RBOLD} package list."
            return 1
        fi
    fi

    sdk env init
}

update_sdkman() {
    write_line ${GREEN} "Updating ${GREEN}sdkman${RBOLD}."

    # Run sdkman update commands
    sdk selfupdate; sdk update

    write_line ${GREEN} "Updated ${GREEN}sdkman${RBOLD}.
}