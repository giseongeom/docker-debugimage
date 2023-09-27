#!/usr/bin/env bash
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

DISTRO=$(lsb_release -is)
DISTRO_RELEASE=$(lsb_release -rs)

if [[ $DISTRO == "Ubuntu" ]]; then
    if [[ $DISTRO_RELEASE == "20.04" ]]; then
    DOWNLOAD_URL='https://github.com/giseongeom/oss-bin/raw/main/dog/dog-v0.1.0-x86_64-linux-ubuntu20.04.zip'
    fi

    if [[ $DISTRO_RELEASE == "22.04" ]]; then
    DOWNLOAD_URL='https://github.com/giseongeom/oss-bin/raw/main/dog/dog-v0.1.0-x86_64-linux-ubuntu22.04.zip'
    fi
fi

if [[ -n $DOWNLOAD_URL ]]; then
    curl -L -Ss $DOWNLOAD_URL -o /tmp/dog.zip \
        && cd /tmp \
        && unzip /tmp/dog.zip \
        && rm -f /tmp/dog.zip \
        && sudo install -o root -g root -m 0755 /tmp/dog /usr/local/bin/dog
fi

