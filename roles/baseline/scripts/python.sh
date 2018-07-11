#!/bin/bash
#
# [PG Script]
#
# GitHub:     https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
# Maintainer: Admin9705
# URL:        https://plexguide.com
#
# PlexGuide Copyright (C) 2018 PlexGuide.com
# Licensed under GNU General Public License v3.0 GPL-3 (in short)
#
#   You may copy, distribute and modify the software as long as you track
#   changes/dates in source files. Any modifications to our software
#   including (via compiler) GPL-licensed code must also be made available
#   under the GPL along with build & install instructions.
#
#################################################################################
# Original Authors: l3uddz & desimaniac - cloudbox.rocks                        #
#################################################################################

## Disable IPv6
grep -q -F 'net.ipv6.conf.all.disable_ipv6 = 1' /etc/sysctl.d/99-sysctl.conf || echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.d/99-sysctl.conf
grep -q -F 'net.ipv6.conf.default.disable_ipv6 = 1' /etc/sysctl.d/99-sysctl.conf || echo 'net.ipv6.conf.default.disable_ipv6 = 1' >> /etc/sysctl.d/99-sysctl.conf
grep -q -F 'net.ipv6.conf.lo.disable_ipv6 = 1' /etc/sysctl.d/99-sysctl.conf || echo 'net.ipv6.conf.lo.disable_ipv6 = 1' >> /etc/sysctl.d/99-sysctl.conf
sysctl -p

## Install Dependencies
apt-get install -y --reinstall \
    git \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    python3-pip \
    python-dev \
    python-pip
pip3 install --upgrade --force-reinstall pip==9.0.3
pip3 install --upgrade --force-reinstall setuptools
pip3 install --upgrade --force-reinstall \
    pyOpenSSL \
    requests \
    netaddr
pip install --upgrade --force-reinstall pip==9.0.3
pip install --upgrade --force-reinstall setuptools
pip install --upgrade --force-reinstall \
    pyOpenSSL \
    requests \
    netaddr \
    #ansible==${1-2.5.4}
## Copy pip to /usr/bin
cp /usr/local/bin/pip /usr/bin/pip
cp /usr/local/bin/pip3 /usr/bin/pip3
