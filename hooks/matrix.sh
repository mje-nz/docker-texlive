#!/bin/bash
# Build matrix for Docker Hub automated builds (see `build`)

set -e

for distro in "bionic" "xenial"; do
    for texlive_version in "" "minimal" "full" "vanilla" "vanilla-2018"; do
        echo -n "TAG=$distro"
        if [ -n "$texlive_version" ]; then
            echo -n "-$texlive_version"
        fi
        echo -n " BASE_IMAGE=ubuntu:$distro"
        echo " TEXLIVE_VERSION=$texlive_version"
    done
done
