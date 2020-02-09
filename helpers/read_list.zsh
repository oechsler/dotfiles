#!/bin/zsh

# Copyright 2020 - Samuel Oechsler
# Creates a space separated list from a file

read_list() {
    echo "$(cat $1 | tr '\n' ' ')"
}

read_list_num() {
    echo "$(cat $1 | egrep -o '\d{9,}' | tr '\n' ' ')"
}
