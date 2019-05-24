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
  # Install VIM themes and plugins
  echo "${GREEN}==>${WHITE}${BOLD} Setting up vim."

  # Remeber the username
  user=$(whoami)

  if [ -z $linux ]; then
    # Some user access was last whilst installing
    # on Mac, so we need to regain it for VIM to install
    sudo chown -R $user /Users/$user > /dev/null 2>&1
  fi

  # Install Molokai (Monokai for VIM) theme
  git clone https://github.com/tomasr/molokai.git ~/.vim

  # Make a personal copy of the production .vimrc
  cp ../configs/vimrc ../vimrc.$user

  # Commit the personal .vimrc copy exclusion
  echo "vimrc.$user" > ../.gitignore
  git add ../.gitignore; git commit -m "Update .gitignore"

  # Setup powerline for VIM
  if [ $linux ]; then
    # On Linux and WSL we use Python 2
    version=$(python -V 2>&1 | grep -o "\d\.\d")
  else
    # On Mac Python 3 is uesd instead
    version=$(python3 -V | grep -o "\d\.\d")
  fi
  echo "${BLUE}==> ${WHITE}${BOLD}Python version ${YELLOW}$version${WHITE} is used."
  if [ $linux ]; then
      echo "$(cat ~/.vimrc) rtp+=~/.local/lib/python$(echo $version)/site-packages/powerline/bindings/vim/" > ../vimrc.$user
  else
      echo "$(cat ~/.vimrc) rtp+=/usr/local/lib/python$(echo $version)/site-packages/powerline/bindings/vim/" > ../vimrc.$user
  fi
  unset version

  # Install VIM plugin manager (Vundle) and auto executor (Pathogene)
  mkdir -p ~/.vim/autoload; mkdir -p ~/.vim/bundle
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim # Pathogene
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim # Vundle

  # Link personal copy of production vimrc
  rm ~/.vimrc; ln -sf $DOTDIR/vimrc.$user ~/.vimrc

  unset user

  echo "${BLUE}==> ${WHITE}${BOLD}Run ${GREEN}vundle${WHITE}${BOLD} after install finished.${WHITE}"
fi
