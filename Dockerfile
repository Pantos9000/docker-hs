FROM ubuntu:18.04

# setup install dir
COPY ./install_files /install_files
WORKDIR /install_files

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install \
        software-properties-common \
        curl && \
    dpkg --add-architecture i386 && \
    curl -o - "https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/Release.key" | apt-key add - && \
    apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/ ./' && \
    curl -o - "https://dl.winehq.org/wine-builds/winehq.key" | apt-key add - && \
    apt-add-repository 'deb http://dl.winehq.org/wine-builds/ubuntu/ bionic main' && \
    apt-get update && \
    apt-get -y install --install-recommends \
        winehq-staging \
        winbind \
        winetricks

CMD ./run_app.sh
