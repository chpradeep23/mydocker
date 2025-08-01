FROM ubuntu:25.04

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=America/New_York

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    cdpr \
    curl \
    dnsutils \
    dsniff \
    ipcalc \
    iperf \
    iperf3 \
    fping \
    git-all \
    gnupg \
    gsutil \
    ifenslave \
    inetutils-traceroute \
    iputils-* \
    libkrb5-dev \
    lldpd \
    locales \
    mtr \
    nano \
    net-tools \
    netplan.io \
    openssh-server \
    python3 \
    python3-pip \
    snapd \
    sudo \
    tzdata \
    ufw \
    vim \
    zsh	\
    wget

RUN sudo apt update
RUN sudo apt install python3-venv -y
RUN python3 -m venv .venv

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
COPY requirements.txt requirements.txt
COPY requirements.yml requirements.yml
RUN pip install -r requirements.txt
RUN ansible-galaxy collection install -r requirements.yml --force
# Install Oh My Zsh
RUN sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
# Optionally, if you want to set the Robby Russell theme explicitly
# RUN sed -i 's/ZSH_THEME=".*"/ZSH_THEME="robbyrussell"/g' ~/.zshrc

# Set the default shell to zsh
SHELL ["/bin/zsh", "-c"]

# Set the entrypoint to zsh
ENTRYPOINT ["/bin/zsh"]

LABEL maintainer="Pradeep Challagulla <ch.pradeep23@gmail.com>" \
      version="1.1.0"
