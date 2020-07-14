# Base image for all texlive variants
ARG BASE_IMAGE=ubuntu:focal
FROM $BASE_IMAGE as base

# Make sure nothing prompts for input, which definitely happens otherwise for texlive-full
ENV DEBIAN_FRONTEND=noninteractive

# Install common packages
RUN apt-get update && \
    apt-get install -qy --no-install-recommends \
        make \
    # For installing Python packages
        pkg-config \
        python3 \
        python3-pip \
    # For pythontex
        python3-pygments \
    # For matplotlib
        fontconfig \
        python3-tk && \
    # Install newer python and pip
    # (installing python3.8 without python3 is too much of a pain)
    ( \
        # Bionic
        apt-get install -qy --no-install-recommends python3.8 && \
        update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1 || \
        true \
    ) && \
    pip3 install --no-cache-dir --upgrade pip setuptools wheel && \
    # Clean up
    rm -rf /var/lib/apt/lists/*

WORKDIR /workdir



# System TeX Live (without recommended packages or documentation)
FROM base AS basic
RUN apt-get update && \
    echo "Installing basic system TeX Live" && \
    apt-get install -qy --no-install-recommends \
        latexmk \
        texlive && \
    rm -rf /var/lib/apt/lists/*



# System TeX Live
FROM base AS default
RUN apt-get update && \
    echo "Installing system TeX Live" && \
    apt-get install -qy \
        latexmk \
        texlive && \
    rm -rf /var/lib/apt/lists/*



# System TeX Live (full)
FROM base AS full
RUN apt-get update && \
    echo "Installing full system TeX Live" && \
    apt-get install -qy texlive-full && \
    rm -rf /var/lib/apt/lists/*
