ARG IMAGE=ubuntu:bionic
FROM $IMAGE

# Make sure nothing prompts for input, which definitely happens otherwise for texlive-full
ENV DEBIAN_FRONTEND=noninteractive

# Install TeX Live
ARG TEXLIVE_VERSION
RUN apt-get update && \
    if [ -z "$TEXLIVE_VERSION" ]; then \
        echo "Installing system TeX Live"; \
        apt-get install -qy \
            texlive \
            texlive-*-doc-; \
    elif [ "$TEXLIVE_VERSION" = "minimal" ]; then \
        echo "Installing minimal system TeX Live"; \
        apt-get install -qy --no-install-recommends \
            latexmk \
            make \
            texlive; \
    elif [ "$TEXLIVE_VERSION" = "full" ]; then \
        echo "Installing system TeX Live"; \
        apt-get install -qy texlive-full; \
    elif [ "$TEXLIVE_VERSION" != "${TEXLIVE_VERSION#vanilla}" ]; then \
        # TEXLIVE_VERSION starts with "vanilla"
        apt-get install -qy --no-install-recommends \
            latexmk \
            make \
            # Needed for installer
            perl \
            wget && \
        if [ "$TEXLIVE_VERSION" = "vanilla" ]; then \
            echo "Installing latest vanilla TeX Live"; \
            export TEXLIVE_REPO="http://mirror.ctan.org/systems/texlive/tlnet"; \
            export TEXLIVE_PATH="/usr/local/texlive/2019/bin/x86_64-linux"; \
        else \
            # e.g. vanilla-2018
            export TEXLIVE_YEAR=${TEXLIVE_VERSION#vanilla-}; \
            echo "Installing TeX Live $TEXLIVE_YEAR"; \
            export TEXLIVE_REPO="http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/$TEXLIVE_YEAR/tlnet-final"; \
            export TEXLIVE_PATH="/usr/local/texlive/$TEXLIVE_YEAR/bin/x86_64-linux"; \
        fi && \
        wget -nv $TEXLIVE_REPO/install-tl-unx.tar.gz && \
        # Extract installer into generically-named folder
        mkdir /install-tl-unx && \
        tar -xf install-tl-unx.tar.gz -C /install-tl-unx --strip-components=1 && \
        # Install basic scheme
        echo "selected_scheme scheme-basic" >> /install-tl-unx/texlive.profile && \
        /install-tl-unx/install-tl \
            -profile /install-tl-unx/texlive.profile \
            -repository $TEXLIVE_REPO && \
        # Clean up
        rm -r /install-tl-unx && \
        rm install-tl-unx.tar.gz; \
    else \
        echo "Unknown TeX Live version $TEXLIVE_VERSION"; \
        exit 1; \
    fi \
 && rm -rf /var/lib/apt/lists/*

# Only matters for vanilla texlive
ENV PATH="${TEXLIVE_PATH}:${PATH}"

ENV HOME /workdir
WORKDIR /workdir 

# texlive without recommended is 243 MB, doesn't have latexmk
# texlive texlive-*-doc- is 775 MB

