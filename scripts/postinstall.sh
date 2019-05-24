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

if [ "$installed" != "true" ]; then
  # Checkout the first install local branch (10000)
  git checkout -b rev_installed
  echo "${BLUE}==>${WHITE}${BOLD} Switched branch to ${YELLOW}$(git rev-parse --abbrev-ref HEAD)${WHITE}${BOLD}."

  # Display post-install information
  echo "${BLUE}==>${WHITE}${BOLD} You may now want to install things from the ${YELLOW}misc${WHITE}${BOLD} directory."

  if [ -z $linux ]; then
    open /usr/local/Caskroom/setap

    echo "${BLUE}==>${WHITE}${BOLD} Install the following apps from ${BLUE}Setapp${WHITE}${BOLD}:"
    cat ../packages/setapp.txt
  fi
fi

# Cleanup
echo "${GREEN}==>${WHITE}${BOLD} Cleaning up."
echo true > ~/.installed
