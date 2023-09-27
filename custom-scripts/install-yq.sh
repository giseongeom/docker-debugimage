#!/usr/bin/env bash
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# yq
# https://blog.markvincze.com/download-artifacts-from-a-latest-github-release-in-sh-and-powershell/
#  https://github.com/mikefarah/yq#plain-binary
export LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/mikefarah/yq/releases/latest | jq -r .tag_name)
wget "https://github.com/mikefarah/yq/releases/download/${LATEST_RELEASE}/yq_linux_amd64" -O /usr/local/bin/yq \
    && chmod 755 /usr/local/bin/yq \
    && echo "yq Installation is Done!"
