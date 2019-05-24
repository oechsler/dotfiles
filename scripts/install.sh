#!/bin/bash

# Install script for all supported platforms
# for Samuel Oechslers dotfiles

# Add some fancy color variables to shell scripts
if which tput > /dev/null 2>&1; then
  ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  BOLD="$(tput bold)"
  WHITE="$(tput sgr0)"
fi

# Check system type (Linux/Windows/Mac)
if [ "$(uname -s)" = "Linux" ]; then
    export linux=true
    if [ "$(uname --kernel-version | grep -o Microsoft)" = "Microsoft" ]; then
      # Ok, this is running on WSL
      export windows=true
      echo "${BLUE}==>${WHITE}${BOLD} Running on ${YELLOW}Windows${WHITE}${BOLD}."
    else
      if [ "$(uname --a | grep -o arch)" = "arch" ]; then
        export arch=true
      fi

      # Great, this is running Linux
      echo "${BLUE}==>${WHITE}${BOLD} Running on ${YELLOW}Linux${WHITE}${BOLD}."
    fi
else
    # Should be a Mac then
    echo "${BLUE}==>${WHITE}${BOLD} Running on ${YELLOW}Mac${WHITE}${BOLD}."
fi

# Check for previous installs
installed=$(cat ~/.installed 2>&1)
if [ "$installed" == "true" ]; then
  echo "${BLUE}==>${WHITE}${BOLD} Already installed, updating now."
fi

# Dotfiles directory variable
export DOTDIR=$HOME/dotfiles
cd $DOTDIR/scripts

# Link dotfiles to home directory
echo "${GREEN}==>${WHITE}${BOLD} Linking dotfiles to ${YELLOW}$HOME${WHITE}${BOLD}.${WHITE}"
cd $DOTDIR/configs
for entry in *; do
    ln -sf $DOTDIR/configs/$entry ~/.$entry
    echo "${YELLOW}$entry${WHITE} is linkted to ${YELLOW}~/.$entry${WHITE}."
done
cd $DOTDIR/scripts

if [ $linux ]; then
    # Rename bash profile to bashrc on Linux
    rm ~/.bashrc
    mv ~/.profile ~/.bashrc
fi

# Install all packages
./packages.sh

# Install "Oh-my-zsh" and setup zsh
./zsh.sh

# Setup vim editor
./vim.sh

# Setup mac specific things
if [ -z $linux ]; then
    ./mac.sh
fi

# Run post-install script
./postinstall.sh

# Done
echo "${GREEN}==>${WHITE}${BOLD} Done."
