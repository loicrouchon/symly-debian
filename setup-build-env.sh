#!/usr/bin/env sh

sudo apt-get update
sudo apt install -y devscripts debhelper openjdk-17-jdk-headless ant libpicocli-java
echo "${PPA_GPG_PRIVATE_KEY}" | gpg --import --batch
