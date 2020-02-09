#!/bin/zsh

# Copyright 2020 - Samuel Oechsler
# Configures basic settings of the ZShell

install_zsh() {
    if [[ $debug == true ]]; then
        write_line ${YELLOW} "Skipping ${GREEN}zsh${RBOLD}."
        return 0
    fi

    write_line ${GREEN} "Installing ${GREEN}zsh${RBOLD}."

    if [[ "$(which_os)" == "darwin" ]]; then
        if [[ $(command_exists brew --version) -ne 0 ]]; then
            write_line ${RED} "Dependency ${RED}homebrew${RBOLD} not found."
            return 1
        fi

        # Install / upgrade current zsh
        brew install zsh
    fi

    # Install oh-my-zsh and set postinstall env
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
    ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

    # Install spaceship prompt
    zsh -c "$(git clone https://github.com/denysdovhan/spaceship-prompt.git $ZSH_CUSTOM/themes/spaceship-prompt)"
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

    # Install zsh autosuggestions
    zsh -c "$(git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions)"

    # Install zsh wakatime
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
    $pip_command install wakatime
    zsh -c "$(git clone https://github.com/sobolevn/wakatime-zsh-plugin.git $ZSH_CUSTOM/plugins/wakatime)"

    # Backup current .zshrc
    mv $HOME/.zshrc $HOME/.zshrc.pre-dotfiles

    zshrc=./configs/${env:-default}.zshrc
    if [[ -e $zshrc ]]; then
        # Create user specific .zshrc
        cat $zshrc > $PWD/$USER.zshrc

        # Inject update command and env vars
        if [[ -n $env ]]; then
            echo "alias dotupdate='zsh -c \$DOTDIR/install.zsh --update --env=$env'\n\n$(cat $PWD/$USER.zshrc)" > $PWD/$USER.zshrc
        else
            echo "alias dotupdate='zsh -c \$DOTDIR/install.zsh --update'\n\n$(cat $PWD/$USER.zshrc)" > $PWD/$USER.zshrc
        fi
        echo "export DOTDIR=$PWD\n$(cat $PWD/$USER.zshrc)" > $PWD/$USER.zshrc
        git add --all && git commit -m "Add user specific .zshrc"

        # Register symbolic link to ~/.zshrc
        ln -s $PWD/$USER.zshrc $HOME/.zshrc
    else
        write_line ${RED} "Missing ${RED}$zshrc${RBOLD} config."
        return 1
    fi

    # Change the default shell to zsh
    write_line ${YELLOW} "Shell change requires elevated permissions."
    chsh -s $(which zsh)

    write_line ${GREEN} "Installed ${GREEN}zsh${RBOLD}."
}

remove_zsh() {
    write_line ${RED} "Removing ${RED}zsh${RBOLD}."

    sudo rm -r $HOME/.oh-my-zsh/
    rm $HOME/.zshrc
    mv $HOME/.zshrc.pre-dotfiles $HOME/.zshrc
    rm $PWD/$USER.zshrc

    write_line ${RED} "Removed ${RED}zsh${RBOLD}."
}
