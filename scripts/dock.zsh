#!/bin/zsh

# Copyright 2020 - Samuel Oechsler
# Configures local git installation

install_dock() {
    if [[ "$(which_os)" != "darwin" ]] || [[ $debug == true ]]; then
        write_line ${YELLOW} "Skipping ${GREEN}dock${RBOLD}."
        return 0
    fi

    write_line ${GREEN} "Installing ${GREEN}dock${RBOLD}."

    # Import Dock settings and layout
    defaults import com.apple.Dock ./configs/${env:-default}.dock.plist
    killall Dock; killall Dock;

    write_line ${GREEN} "Installed ${GREEN}dock${RBOLD}."
}
