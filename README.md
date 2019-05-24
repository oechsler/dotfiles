# Dotfiles

> **Noun** - Plural of dotfile
>
> 1. (computing) A file or directory whose name begins with a dot (period or full stop), typically hidden from view.

In Unix systems the term dotfiles is referred to the files that are hidden from view in your home directory and are used to personalize your system. **In this repo you can find my dotfiles!**

## Disclaimer

Before just installing the dotfiles I created blindfolded, please have a look at the code and ask yourself the question:

_Don't I have other needs that my work environment has to fullfil in order to really aid me whilst using it?_

What I'm trying to say is that you should rather use my dotfiles as a template to create your own ones, instead of just installing them. Also my dotfiles are created in oder to function perfectly on a Mac and Arch based Linux distributions. So if you are using a different Linux distribution my dotfiles may contain some functionality that will not work for you _(I'm sorry)_.

## Installation

To setup the dotfiles simply clone the repo and navigate to the folder in the terminal. The just run the `install.sh` installation script. - Thats it! :sparkles:

So grab your self a cup of :coffee: or a :beer: if thats more your thing and enjoy the journey. Time and time again the script will call out for your attention, because you have to enter a password or specify a version.

When using vim with my `.vimrc` make sure to run the `vundle` command, to install the plugins with [Vundle](https://github.com/VundleVim/Vundle.vim).

_If you might wonder what the `misc` directory does: I do store stuff here that needs to be installed after the setup of the environment in some graphical applications or is only touched by the install script but doesn't need to be moved into the home directory._

## Updating

Simply pull down the new version of the repo and re-run the `install.sh` installation script and your are up do date in just a few seconds, since the script doesn't install packages that it installed initially. - Unless you want to! If you want to do a fresh install or "upgrade" (including added packages), you first have to delete the hidden `.installed` file in your home directory.

There is now also a much simpler updater, which performs all the necessary steps for you. You can try it out using the `dotupdate` command in either the bash or zsh shell. - Its a great bit easier than the previous, yet still supported, process!

## License

_Copyright &copy; 2019 - Samuel Oechsler_

**Mit License.** _Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE._
