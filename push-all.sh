#!/bin/bash
# Push all mjenz/texlive images

set -e

source common.sh
source util.sh

# Add short tags if possible
trace docker tag "mjenz/texlive:$LATEST_UBUNTU" "mjenz/texlive:latest" || true
trace docker tag "mjenz/texlive:$DISTRO-vanilla-$TEXLIVE_VERSION" "mjenz/texlive:$DISTRO-vanilla" || true
trace docker tag "mjenz/texlive:$LATEST_UBUNTU-vanilla" "mjenz/texlive:vanilla" || true
trace docker images mjenz/texlive

# Push every image
for i in $(docker images mjenz/texlive --format "{{.Repository}}:{{.Tag}}"); do
    if [[ $i != *"<none>" ]]; then
        # Somehow Docker Hub ends up with mjenz/texlive:<none> and then explodes
        # if you touch it
        trace docker push "$i"
    fi
done
