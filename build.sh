#!/usr/bin/env bash
# Build an image variant.  Expects at least DISTRO to be set, optionally also
# NAME and TEXLIVE_VERSION.

set -e

source hooks/util.sh

if [ -z "$DISTRO" ]; then
    echo "Must specify DISTRO"
    exit 1
fi

if [ -n "$TEXLIVE_VERSION" ]; then
    texlive_arg="--build-arg TEXLIVE_VERSION=$TEXLIVE_VERSION"
fi

if [ -n "$NAME" ]; then
    cache_from_arg="--cache-from $NAME-full"
fi

trace docker build "$cache_from_arg" "$texlive_arg" \
    --build-arg "BASE_IMAGE=ubuntu:$DISTRO" \
    "$@"

get_tag_from_arguments() {
# https://stackoverflow.com/a/34536611
    while :; do
        while getopts ":t:" opt; do
            case ${opt} in
                t)
                    echo "$OPTARG"
                    return
                    ;;
                *)
                    # Don't care
                    ;;
            esac
        done
        ((OPTIND++))
        [ $OPTIND -gt $# ] && break
    done
}

# Print versions, except when building the base image
tag="$(get_tag_from_arguments "$@")"
if [[ -n "$NAME" && "$tag" == "$NAME"* ]]; then
    print_versions "$NAME"
fi
