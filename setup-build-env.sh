#!/usr/bin/env sh
set -ex

image="ubuntu:latest"
podman run -ti \
    -v "$(pwd)":/workspace \
    -w /workspace \
    "$image" \
    bash -c """
./configure.sh

echo 'Configure environment: maintainer name and email'
export DEBEMAIL='loic@loicrouchon.com'
export DEBFULLNAME='Loic Rouchon'
echo 'Configure environment: GPG fingerprint'
export GPG_KEY_FINGERPRINT='C3BB9448B16C971103E876BF3A091A0DF2799262'
echo 'Configure environment: PPA URL'
export PPA_URL='ppa:loicrouchon/symly'

cat gpg/*.key  | gpg --import

bash
"""

