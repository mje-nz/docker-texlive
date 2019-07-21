ARG BASE_IMAGE=ubuntu:bionic
FROM $BASE_IMAGE

# Make sure nothing prompts for input, which definitely happens otherwise for texlive-full
ENV DEBIAN_FRONTEND=noninteractive

# Install common packages
RUN apt-get update && \
    apt-get install -qy --no-install-recommends \
        make \
    # For installing Python packages
        python3 \
        python3-pip \
        python3-setuptools \
        python3-wheel \
    # For pythontex
        python3-pygments \
    # For comparing documents
        ghostscript \
        imagemagick \
    # For matplotlib
        fontconfig \
        python3-tk && \
    rm -rf /var/lib/apt/lists/* && \
    # For generating Python figures (system versions are old)
    pip3 install --no-cache-dir \
        matplotlib \
        numpy \
        seaborn && \
    # Allow imagemagick to work with PDFs
    sed -i 's/rights="none" pattern="PDF"/rights="read|write" pattern="PDF"/g' /etc/ImageMagick-6/policy.xml

# Install TeX Live
ARG TEXLIVE_VERSION
RUN apt-get update && \
    if [ -z "$TEXLIVE_VERSION" ]; then \
        echo "Installing system TeX Live"; \
        apt-get install -qy \
            latexmk \
            texlive \
            texlive-*-doc-; \
    elif [ "$TEXLIVE_VERSION" = "minimal" ]; then \
        echo "Installing minimal system TeX Live"; \
        apt-get install -qy --no-install-recommends \
            latexmk \
            texlive; \
    elif [ "$TEXLIVE_VERSION" = "full" ]; then \
        echo "Installing system TeX Live"; \
        apt-get install -qy texlive-full; \
    elif [ "$TEXLIVE_VERSION" != "${TEXLIVE_VERSION#vanilla}" ]; then \
        # TEXLIVE_VERSION starts with "vanilla"
        apt-get install -qy --no-install-recommends \
            # Needed for tlmgr
            xzdec \
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
        rm install-tl-unx.tar.gz && \
        # Add TeX Live to path
        # TODO: Use ENV somehow
        echo 'export PATH="'$TEXLIVE_PATH':$PATH"' >> ~/.bashrc && \
        # Add some extras
        # TODO separate layer
        $TEXLIVE_PATH/tlmgr install \
            caption \
            currfile \
            ec \
            etoolbox \
            fancyvrb \
            filehook \
            fvextra \
            latexmk \
            lineno \
            pgf \
            pgfopts \
            pythontex \
            subfig \
            upquote \
            xcolor \
            xstring; \
    else \
        echo "Unknown TeX Live version $TEXLIVE_VERSION"; \
        exit 1; \
    fi && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workdir 
