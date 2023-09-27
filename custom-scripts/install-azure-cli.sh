#!/usr/bin/env bash
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
distro_id=$(lsb_release -is)
if [[ $distro_id == 'Ubuntu' ]]; then
    sudo apt-get update -q
    sudo apt-get install --no-install-recommends -y -q ca-certificates curl apt-transport-https lsb-release gnupg
    sudo mkdir -p /etc/apt/keyrings
    curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
        gpg --dearmor |
        sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
    sudo chmod go+r /etc/apt/keyrings/microsoft.gpg
    AZ_REPO=$(lsb_release -cs)
    echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
        sudo tee /etc/apt/sources.list.d/azure-cli.list
    sudo apt-get update -q
    sudo apt-get install --no-install-recommends -y -q azure-cli
fi

if [[ $distro_id != 'Ubuntu' ]]; then
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    if [[ $? -eq 0 ]]; then
        az version && echo "Azure CLI Installation is Done!"
    fi
fi
