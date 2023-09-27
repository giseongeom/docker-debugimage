#!/usr/bin/env bash
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# https://github.com/cloverstd/tcping/
#curl -L -Ss "https://github.com/cloverstd/tcping/releases/download/v0.1.1/tcping-linux-amd64-v0.1.1.tar.gz" -o "/tmp/tcping-linux.tgz"
#tar zxf /tmp/tcping-linux.tgz -C /usr/local/bin && cd /usr/local/bin/ && chown root.root tcping && chmod 755 tcping

distro_id=$(lsb_release -is)

# https://github.com/pouriyajamshidi/tcping
if [[ $distro_id == 'Ubuntu' ]]; then
    curl -L -Ss "https://github.com/pouriyajamshidi/tcping/releases/download/v2.4.0/tcping_amd64.deb" -o "/tmp/tcping.deb" \
        && sudo apt install -y /tmp/tcping.deb \
        && sudo rm -f /tmp/tcping.deb \
        && tcping -v
fi

if [[ $distro_id != 'Ubuntu' ]]; then
    curl -L -Ss "https://github.com/pouriyajamshidi/tcping/releases/download/v2.4.0/tcping_Linux.tar.gz" -o "/tmp/tcping.tgz" \
        && sudo tar zxf /tmp/tcping.tgz -C /tmp \
        && sudo rm -f /tmp/tcping.tgz \
        && sudo install -o root -g root -m 0755 /tmp/tcping /usr/local/bin/tcping \
        && tcping -v
fi
