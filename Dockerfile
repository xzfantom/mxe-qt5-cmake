FROM ubuntu:bionic
ENV PATH="/opt/mxe/usr/bin/:$PATH"
RUN apt update && \
    apt install --no-install-recommends -y \
        autoconf \
        automake \
        autopoint \
        bash \
        bison \
        bzip2 \
        flex \
        g++ \
        g++-multilib \
        gcc \
        gettext \
        git \
        gperf \
        intltool \
        libc6-dev-i386 \
        libgdk-pixbuf2.0-dev \
        libltdl-dev \
        libssl-dev \
        libtool-bin \
        libxml-parser-perl \
        lzip \
        make \
        openssl \
        p7zip-full \
        patch \
        perl \
        pkg-config \
        python \
        ruby \
        sed \
        unzip \
        wget \
        xz-utils \
        libqt5svg5* \
        zlib1g-dev && \
    ###################################################
    # Cross compile Qt5 using MXE 32/64 bits (shared) #
    ###################################################
    cd /opt && \
    git clone https://github.com/mxe/mxe.git && \
    cd mxe && \
    make MXE_TARGETS='x86_64-w64-mingw32.shared, i686-w64-mingw32.shared' qt5 qtsvg nsis && \
    ################
    # Fix symlinks #
    ################
    ln -sf /opt/mxe/usr/bin/x86_64-w64-mingw32.shared-gcc /opt/mxe/usr/x86_64-pc-linux-gnu/bin/x86_64-w64-mingw32.shared-gcc && \
    ln -sf /opt/mxe/usr/bin/x86_64-w64-mingw32.shared-g++ /opt/mxe/usr/x86_64-pc-linux-gnu/bin/x86_64-w64-mingw32.shared-g++ && \
    ###########
    # Cleanup #
    ###########
    rm -rf /opt/mxe/pkg/* && \
    rm -rf /opt/mxe/log/* && \
    rm -rf /opt/mxe/.ccache/* && \
    apt-get autoremove -y && \
    apt-get -y remove wget unzip && \
    rm -rf /var/lib/apt/lists/*
