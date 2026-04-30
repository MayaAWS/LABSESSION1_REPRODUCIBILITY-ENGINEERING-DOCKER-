# Docker container for a simple Python setup

# Copyright 2021, Wolfgang Mauerer <wolfgang.mauerer@othr.de>
# Copyright 2021-2026, Stefanie Scherzinger <stefanie.scherzinger@uni-passau.de>
# Copyright 2021-2026, Stefan Klessinger <stefan.klessinger@uni-passau.de>
# Copyright 2023-2026, Christoph Köhnen <christoph.koehnen@uni-passau.de>
# SPDX-License-Identifier: MIT-0

# Start off of a long-term maintained base distribution
FROM ubuntu:22.04

LABEL org.opencontainers.image.authors="Stefan Klessinger <stefan.klessinger@uni-passau.de>, Christoph Köhnen <christoph.koehnen@uni-passau.de>"

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG="C.UTF-8"
ENV LC_ALL="C.UTF-8"

# Install required packages
# Best practice: sort packages alphabetically
RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		git \
		nano \
		python3 \
		python3-pip \
		sudo

# Add user
RUN useradd -m -G sudo -s /bin/bash repro && echo "repro:repro" | chpasswd
RUN usermod -a -G staff repro
USER repro
WORKDIR /home/repro

# Add content of directory 'res' to container
COPY res /home/repro
