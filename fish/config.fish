#!/usr/bin/env fish

set fish_greeting

# ---

set -gx EDITOR nvim
set -gx PAGER less

alias vim="nvim"
alias vi="nvim"

alias ls="exa"
alias ll="exa --long"
alias lt="exa --tree --level 1 --group-directories-first"

zoxide init fish --no-cmd | source

function cd
    __zoxide_z $argv
    and lt
end
alias cf="__zoxide_zi $argv"

thefuck --alias | source

starship init fish | source

# ---

set -gx PATH /usr/local/bin $PATH
set -gx PATH $HOME/.linkerd2/bin $PATH
set -gx PATH $HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin $PATH
set -gx PATH $HOME/go/bin $PATH

alias gtui="gitui -t mocha.ron"

