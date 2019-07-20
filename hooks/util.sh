#!/bin/bash
# Utility functions for build hooks

GREEN=$'\033[0;32m'
CLEAR=$'\033[0m'

info () {
	echo "$GREEN$@$CLEAR"
}

trace (){
    info "> $@"
    eval "$@"
}
