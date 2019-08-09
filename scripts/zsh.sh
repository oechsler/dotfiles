#!/bin/sh

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

if [ "$installed" != "true" ]; then
    # Install Oh my zsh
    echo "${GREEN}==>${WHITE}${BOLD} Installing Oh my zsh."

    # Run the custom installer
    sh -c "../misc/oh-my-zsh-install.sh"

    # Weird linking needed since the installer moved
    # the inital .zshrc to .zshrc.pre-oh-my-zsh
    rm ~/.zshrc
    ln -sf ~/.zshrc.pre-oh-my-zsh ~/.zshrc

    # Zsh autocompletion plugin
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    if [ $linux ]; then
        compaudit | xargs chmod g-w,o-w
    fi
    
    # Zgen plugin manager
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi
