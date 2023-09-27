#!/usr/bin/env bash
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# See https://kubernetes.io/releases/
#DOWNLOAD_URL="https://dl.k8s.io/release/v1.28.1/bin/linux/amd64/kubectl"
#DOWNLOAD_URL="https://dl.k8s.io/release/v1.27.5/bin/linux/amd64/kubectl"
#DOWNLOAD_URL="https://dl.k8s.io/release/v1.26.8/bin/linux/amd64/kubectl"
# kubectl (1.26)
DOWNLOAD_URL="https://dl.k8s.io/release/v1.26.8/bin/linux/amd64/kubectl"
curl -L -Ss $DOWNLOAD_URL -o "/tmp/kubectl" \
    && install -o root -g root -m 0755 /tmp/kubectl /usr/local/bin/kubectl

# helm
DOWNLOAD_URL="https://get.helm.sh/helm-v3.12.3-linux-amd64.tar.gz"
curl -L -Ss $DOWNLOAD_URL -o "/tmp/helm.tgz" \
    && tar zxf /tmp/helm.tgz -C /tmp \
    && install -o root -g root -m 0755 /tmp/linux-amd64/helm /usr/local/bin/helm

# kubectx / kubens
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -sf /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -sf /opt/kubectx/kubens /usr/local/bin/kubens

# kube-ps1
# Included in oh-my-zsh
# https://github.com/jonmosco/kube-ps1

# eksctl
# for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH
curl -L -Ss "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz" -o /tmp/eksctl.tgz \
    && tar -zxf /tmp/eksctl.tgz -C /tmp \
    && rm  -f /tmp/eksctl.tgz \
    && sudo install -o root -g root -m 0755 /tmp/eksctl /usr/local/bin/eksctl

