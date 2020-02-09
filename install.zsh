#!/bin/zsh

# Copyright 2020 - Samuel Oechsler
# Installer for my personal work environment(s)

# Helper methods
source ./helpers/resolve_args.zsh
source ./helpers/register_colors.zsh
source ./helpers/which_os.zsh
source ./helpers/write_line.zsh
source ./helpers/is_installed.zsh
source ./helpers/command_exists.zsh
source ./helpers/read_list.zsh
source ./helpers/version_control.zsh

# Install sub-scripts
source ./scripts/git.zsh
source ./scripts/homebrew.zsh
source ./scripts/mas.zsh
source ./scripts/pip.zsh
source ./scripts/yarn.zsh
source ./scripts/zsh.zsh
source ./scripts/vim.zsh
source ./scripts/dock.zsh

write_line $BLUE "Running on ${BLUE}$(which_os)${RBOLD}."

# Pre hook for versionized interactions
version_control_pre

# Check for already present installation
if [[ $update != true ]] && [[ $remove != true ]] && is_installed; then
    write_line ${RED} "Dotfiles are already installed."
    write_line ${BLUE} "Use ${BLUE}dotupdate${RBOLD} to update from upstream."
    return 1
fi

# Execute respective installer sub-scripts
if [[ $update == true ]]; then
    update_homebrew || return 1
    update_mas || return 1
    update_yarn || return 1
elif [[ $remove == true ]]; then
    remove_git || return 1
    remove_zsh || return 1
    remove_vim || return 1
else
    install_git || return 1
    install_homebrew || return 1
    install_mas || return 1
    install_pip || return 1
    install_yarn || return 1
    install_zsh || return 1
    install_vim || return 1
    install_dock || return 1
fi

# Post hook for versionized interactions
version_control_post

write_line ${GREEN} "Installed ${GREEN}dotfiles${RBOLD}."

printf "${YELLOW}==>${RBOLD} Press ${YELLOW}any key${RBOLD} to restart the shell: ${RBOLD}"; read
clear; zsh
