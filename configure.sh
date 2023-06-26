#!/usr/bin/env sh
set -e

apt-get update
apt-get install -y gpg curl build-essential devscripts debhelper openjdk-17-jdk-headless ant libpicocli-java
