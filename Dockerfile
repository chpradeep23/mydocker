FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York

RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    dnsutils \
    dsniff \
    ipcalc \
    iperf \
    iperf3 \
    fping \
    git \
    gnupg \
    inetutils-traceroute \
    iputils-ping \
    libkrb5-dev \
    lldpd \
    locales \
    mtr \
    nano \
    net-tools \
    netplan.io \
    python3 \
    python3-pip \
    python3-venv \
    tzdata \
    vim \
    zsh \
    wget \
 && rm -rf /var/lib/apt/lists/*

# Python virtual environment
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Copy dependency files first (better caching)
COPY requirements.txt .
COPY requirements.yml .

RUN pip install --upgrade pip \
 && pip install -r requirements.txt \
 && ansible-galaxy collection install -r requirements.yml --force

# Install Oh My Zsh (non-interactive)
RUN RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

SHELL ["/bin/zsh", "-c"]
ENTRYPOINT ["/bin/zsh"]

LABEL maintainer="Pradeep Challagulla <ch.pradeep23@gmail.com>" \
      version="1.1.0"