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
    rm -rf /var/lib/apt/lists/* && \
    # For generating Python figures (system versions are old)
    pip3 install --no-cache-dir --upgrade pip setuptools wheel && \
    pip3 install --no-cache-dir \
        matplotlib \
        numpy \
        seaborn

WORKDIR /workdir



# System TeX Live (without recommended packages or documentation)
FROM base AS minimal
RUN apt-get update && \
    echo "Installing minimal system TeX Live" && \
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
    echo "Installing system TeX Live" && \
    apt-get install -qy texlive-full && \
    rm -rf /var/lib/apt/lists/*
