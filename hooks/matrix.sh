#!/bin/bash
# Based on https://github.com/vaidik/docker-etcd/

VARS=""
for distro in "bionic" "xenial"; do
	for texlive_version in "" "minimal" "full" "vanilla" "vanilla-2018"; do
		line="TAG=$distro"
		if [ -n "$texlive_version" ]; then
			line="$line-$texlive_version"
		fi
		line="$line BASE_IMAGE=ubuntu:$distro"
		line="$line TEXLIVE_VERSION=$texlive_version"
		VARS+="$line"$'\n'
	done
done
export VARS
