#!/usr/bin/env sh
set -ex

apt-get update
apt install -y gpg curl build-essential devscripts debhelper openjdk-17-jdk-headless ant libpicocli-java
echo "${PPA_GPG_PRIVATE_KEY}" | gpg --import --batch
