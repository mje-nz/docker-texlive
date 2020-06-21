#!/bin/bash
# Utility functions for build hooks

GREEN=$'\033[0;32m'
RED=$'\033[0;31m'
CLEAR=$'\033[0m'

info () {
    echo "$GREEN$*$CLEAR"
}

trace () {
    info "> $*"
    eval "$@"
}

# Print versions of packages in a docker image
print_versions() {
    docker run --rm -i "$1" bash -s << EOF || true
    set -e
    info () { echo "$GREEN\$*$CLEAR" ; }
    error () { echo "$RED\$*$CLEAR" ; }
    ver () { eval "\$@" 2>/dev/null || error "none" ; }

    info "For \"$1\":"

    info "tex version"
    tex --version | head -n 2
    echo

    info "make version:"
    make --version | head -n 1
    info "latexmk version:"
    latexmk --version | awk NF
    echo

    info "python version:"
    ver python --version
    info "python2 version:"
    ver python2 --version
    info "python3 version:"
    ver python3 --version
    echo

    info "pip version:"
    ver pip --version
    info "pip2 version:"
    ver pip2 --version
    info "pip3 version:"
    ver pip3 --version
    echo

    info "python3 numpy version:"
    python3 -c "import numpy; print(numpy.__version__)"
    info "python3 matplotlib version:"
    python3 -c "import matplotlib; print(matplotlib.__version__)"

    info "pythontex version:"
    ver pythontex --version
    info "pythontex3 version:"
    ver python3 $(command -v pythontex) --version
    echo
    echo
EOF
true
}
