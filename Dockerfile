FROM ubuntu:23.10

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    tzdata gpg curl build-essential devscripts debhelper openjdk-17-jdk-headless ant libpicocli-java