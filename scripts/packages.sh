#!/bin/bash

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
    linux=true
    if [ "$(uname --kernel-version | grep -o Microsoft)" = "Microsoft" ]; then
      # Ok, this is running on Windows Subsystem
      windows=true
    else
      if [ "$(uname --a | grep -o arch)" = "arch" ]; then
        arch=true
        # Ok, we are running on arch
      fi
      # Great, this is running Linux
    fi
fi
# Should be a Mac then

# Check for previous installs
installed=$(cat ~/.installed 2>&1)

if [ -z $linux ] && [ "$installed" != "true" ]; then
    # Install homebrew with cask and mas on Mac
    echo "${GREEN}==>${WHITE}${BOLD} Installing package managers."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap caskroom/cask
    brew tap homebrew/cask-fonts
    brew tap homebrew/cask-drivers
    brew install mas

    # Ask the user to login at the AppStore
    open "/Applications/App Store.app"
    echo "${BLUE}==>${WHITE}${BOLD} Please login to the ${BLUE}App Store${WHITE}${BOLD} and press enter to continue."; read
fi

if [ $linux ]; then
    echo "${GREEN}==>${WHITE}${BOLD} Updating managed packages."

    if [ $arch ]; then
        sudo pacman -Syu; sudo yay -Syu
    else
        sudo apt-get update; sudo apt-get upgrade
    fi

    if [ "$installed" != "true" ]; then
        echo "${GREEN}==>${WHITE}${BOLD} Installing packages."
        if [ $arch ]; then
            sudo pacman -S $(cat ../packages/pacman.txt | tr '\n' ' ')
            sudo yay -S $(cat ../packages/yay.txt | tr '\n' ' ')
        else
            ./ubuntu.sh
            sudo apt-get $(cat ../packages/apt.txt | tr '\n' ' ')
        fi

        # Python packages downloaded via pip
        pip install $(cat ../packages/pip.txt | tr '\n' ' ')
    fi
else
    echo "${GREEN}==>${WHITE}${BOLD} Updating managed packages."
    brew upgrade
    brew cask upgrade

    if [ "$installed" != "true" ]; then
        echo "${GREEN}==>${WHITE}${BOLD} Installing packages."
        brew install $(cat ../packages/brew.txt | tr '\n' ' ')
        brew cask install $(cat ../packages/cask.txt | tr '\n' ' ')
        mas install $(cat ../packages/mas.txt | grep -o -E '\d{9,}' | tr '\n' ' ')

        # Python packages downloaded via pip3
        pip3 install $(cat ../packages/pip.txt | tr '\n' ' ')
    fi
    
    brew cleanup
fi

yarn global upgrade
if [ "$installed" != "true" ]; then
    echo "${GREEN}==>${WHITE}${BOLD} Installing yarn packages."
    yarn global add $(cat ../packages/yarn.txt | tr '\n' ' ')
fi
