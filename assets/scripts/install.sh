#!/bin/bash

# exit script if return code != 0
set -e

# Install Plex
apt-get -q update
apt-get install -qy git-core supervisor
cd /opt
git clone https://github.com/drzoidberg33/plexpy.git
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
