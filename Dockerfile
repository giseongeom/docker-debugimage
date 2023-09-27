FROM ubuntu:22.04
LABEL maintainer="GiSeong Eom perfmon99@gmail.com"

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        ca-certificates \
        curl \
        dos2unix \
        iproute2 \
        git \
        jq \
        lsb-core \
        net-tools \
        ssh-tools \
        sudo \
        unzip \
        vim-tiny \
        wget

COPY custom-scripts/*.sh /tmp/custom-scripts/
RUN bash /tmp/custom-scripts/install-awscli.sh
RUN bash /tmp/custom-scripts/install-azure-cli.sh
RUN bash /tmp/custom-scripts/install-curl.sh
RUN bash /tmp/custom-scripts/install-dog.sh
RUN bash /tmp/custom-scripts/install-kubernetes-cli.sh
RUN bash /tmp/custom-scripts/install-tcping.sh
RUN bash /tmp/custom-scripts/install-yq.sh
RUN rm -rf /tmp/custom-scripts
