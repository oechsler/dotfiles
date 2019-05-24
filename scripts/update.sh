#!/bin/zsh

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

if [ $installed = "true" ]; then
  # Set working directory
  cd $DOTDIR

  # Stash local changes the user made
  git stash

  # Checkount and pull current master
  git checkout master
  git pull --no-edit

  # Run the installer to update packages
  ./scripts/install.sh

  # Read in a userdefined branch name
  echo "Labels that are already in use:"
  git branch | cat
  echo "${BLUE}==>${WHITE}${BOLD} Provide a unique label for this update: ${GREEN}"; read name
  echo "${WHITE}"
  if [ name == "" ]; then
      # If no name is provided use a random number
      git checkout -b rev_$((($RANDOM % 89999)+10000))
  else
      git checkout -b rev_$name
  fi
  git merge master --no-edit

  # Pop the local changes from stash
  git stash pop

  echo "${BLUE}==>${WHITE}${BOLD} Switched branch to ${YELLOW}$(git rev-parse --abbrev-ref HEAD)${WHITE}${BOLD}."

  # Done
  echo "${GREEN}==> ${BOLD}${WHITE}Done."
else
  # Not installed error message
  echo "${RED}==> ${BOLD}${WHITE}Dotfiles are not installed."
  echo "${RED}==> ${BOLD}${WHITE}Please run $DOTDIR/install.sh instead."
fi
