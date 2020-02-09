#!/bin/zash

# Copyright 2020 - Samuel oechsler
# Checks whether a command exists

command_exists() {
    $@ > /dev/null 2>&1
    echo $?
}
