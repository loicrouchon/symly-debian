# Debian Symly

This repository holds the debian source packaging instructions for the [Symly](https://github.com/loicrouchon/symly/)
command line tool and publishes it to [Launchpad](https://launchpad.net/~loicrouchon/+archive/ubuntu/symly/+packages)

## Builds

Builds are triggered from the `v<x.y.z>` tags and the tag version must match the debian/changelog last version.

### Manual builds

Run `./setup-build-env.sh` to create the build environment.
Once in it, run `./build.sh <VERSION>`.

The gpg public and private keys required to sign the package must be present in the [gpg](gpg) folder.
