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

if [ -z $linux ] && [ $installed != "true" ]; then
  # Import Xcode color theme on Mac
  mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes
  cp ../misc/Default_Sam.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes/Default_Sam.xccolortheme

  # Restore Dock settings on Mac
  echo "${GREEN}==>${WHITE}${BOLD} Restoring personal dock settings."
  defaults import com.apple.Dock ../misc/dock.plist
  killall Dock; killall Dock
fi
