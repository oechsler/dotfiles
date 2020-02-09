#!/bin/zsh

# Copyright 2020 - Samuel Oechsler
# Resolves given args to local variables

for arg in $@; do
    if [[ "$arg" =~ -+ ]] && [[ ! "$arg" =~ = ]]; then
        eval "${arg/#--/}=true"
    elif [[ "$arg" =~ -+ ]]; then
        eval "${arg/#--/}"
    else
        args+=($arg)
    fi
done
