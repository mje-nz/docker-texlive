#!/usr/bin/env bash
# Build an image variant.  Expects at least DISTRO to be set, optionally also
# NAME and TEXLIVE_VERSION.

set -e

source util.sh

if [ -z "$DISTRO" ]; then
    echo "Must specify DISTRO"
    exit 1
fi

get_tag_from_arguments() {
# https://stackoverflow.com/a/34536611
# only works if -t argument is before --target
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
tag="$(get_tag_from_arguments "$@")"
[ "$tag" == "base" ] && is_building_base=true

if [ ! $is_building_base ]; then
    if [ -n "$TEXLIVE_VERSION" ] && [ "$TEXLIVE_VERSION" != "system" ]; then
        dockerfile_arg="--file Dockerfile.vanilla"
        texlive_arg="--build-arg TEXLIVE_VERSION=$TEXLIVE_VERSION"
    fi

    if [ -n "$NAME" ]; then
        cache_from_arg="--cache-from $NAME-full"
    fi
fi

trace docker build "$dockerfile_arg" "$texlive_arg" "$cache_from_arg" \
    --build-arg "BASE_IMAGE=ubuntu:$DISTRO" \
    "$@"

if [ ! $is_building_base ]; then
    print_versions "$tag"
fi
