#!/bin/zsh

# Copyright 2020 - Samuel Oechsler
# Configures basic settings of the VIM editor

install_vim() {
    if [[ $debug == true ]] then
        write_line ${YELLOW} "Skipping ${GREEN}vim${RBOLD}."
        return 0
    fi

    write_line ${GREEN} "Installing ${GREEN}vim${RBOLD}."

    if [[ "$(which_os)" == "darwin" ]]; then
        if [[ $(command_exists brew --version) -ne 0 ]]; then
            write_line ${RED} "Dependency ${RED}homebrew${RBOLD} not found."
            return 1
        fi

        # Install / upgrade VIM editor
        brew install vim
    fi

    # Install Molokai (Monokai for VIM) theme
    zsh -c "$(git clone https://github.com/tomasr/molokai.git $HOME/.vim)"

    # Install Pathogene
    mkdir -p $HOME/.vim/autoload
    zsh -c "$(curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim)"

    # Install Vundle
    mkdir -p $HOME/.vim/bundle
    zsh -c "$(git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim)"
    write_line ${BLUE} "Run the ${BLUE}vundle${RBOLD} command manually post install."

    # Install powerline status
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
    $pip_command install powerline-status

    vimrc=./configs/${env:-default}.vimrc
    if [[ -e $vimrc ]]; then
        user_vimrc$PWD/$USER.vimrc
        if [[ ! -e $user_vimrc ]]; then
            # Create user specific .vimrc
            cat $vimrc > $user_vimrc

            if [[ "$(which_os)" == "darwin" ]]; then
                if [[ $(command_exists python3 -V) -ne 0 ]]; then
                    write_line ${RED} "Dependency ${RED}python3${RBOLD} not found."
                    return 1
                fi

                python_version=$(python3 -V 2>&1 | egrep -o "\d\.\d")
            else
                if [[ $(command_exists python -V) -ne 0 ]]; then
                    write_line ${RED} "Dependency ${RED}python${RBOLD} not found."
                    return 1
                fi

                python_version=$(python2 -V 2>&1 | egrep -o "\d\.\d")
            fi
            pip_packages=/usr/local/lib/python$python_version/site-packages

            # Inject update command and env vars
            echo "$(cat $user_vimrc)\n\"Machine specific configuration" > $user_vimrc
            echo "$(cat $user_vimrc)\nset rtp+=$pip_packages/powerline/bindings/vim/" > $user_vimrc
            git add --all && git commit -m "Add user specific .vimrc"
        fi

        # Register symbolic link to ~/.vimrc
        ln -sf $user_vimrc $HOME/.vimrc
    else
        write_line ${RED} "Missing ${RED}$vimrc${RBOLD} config."
        return 1
    fi

    write_line ${GREEN} "Installed ${GREEN}vim${RBOLD}."
}

update_vim() {
    write_line ${GREEN} "Updateing ${GREEN}vim${RBOLD}."

    # Run vundle update command
    vundle

    write_line ${GREEN} "Removed ${GREEN}vim${RBOLD}."
}

remove_vim() {
    write_line ${RED} "Removing ${RED}vim${RBOLD}."

    sudo rm -r $HOME/.vim/
    rm $HOME/.vimrc $PWD/$USER.vimrc

    write_line ${RED} "Removed ${RED}vim${RBOLD}."
}
