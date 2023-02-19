#!/usr/bin/env sh

package_name="symly"
version="$1"
package_version_dir="${package_name}-${version}"
upstream_tarball="${package_name}_${version}.orig.tar.gz"
upstream_tarball_url="https://github.com/loicrouchon/symly/archive/refs/tags/v${version}.tar.gz"

echo "Building debian source package ${package_version_dir}"

echo "Configure environment:"
echo "Configure environment: maintainer name and email"
export DEBEMAIL="loic@loicrouchon.com"
export DEBFULLNAME="Loic Rouchon"
echo "Configure environment: GPG fingerprint"
GPG_KEY_FINGERPRINT="C3BB9448B16C971103E876BF3A091A0DF2799262"
# GPG private key must be imported with:
# echo "${GPG_PRIVATE_KEY}" | gpg --import --batch
echo "Configure environment: PPA URL"
PPA_URL="ppa:loicrouchon/symly"

rm -rf "build"
mkdir -p "build/${package_name}"
cd "build/${package_name}" || exit 1

echo "Downloading upstream tarball from ${upstream_tarball_url}"
upstream_tarball_url="https://github.com/loicrouchon/symly/archive/refs/heads/features/debian-source-package.tar.gz" # TODO remove
curl -sL "${upstream_tarball_url}" -o "${upstream_tarball}"

echo "Unpacking upstream tarball ${upstream_tarball}"
tar xzf "${upstream_tarball}"

echo "Repacking upstream tarball ${upstream_tarball} (get rid off root level directory)"
rm -f "${upstream_tarball}"
mv symly* "${package_version_dir}" # re-normalize containing dir name
tar czf "${upstream_tarball}" "${package_version_dir}"

echo "Add debian dir"
cd "${package_version_dir}" || exit 1
cp -R "src/packaging/debian/debian" "debian"

echo "Build source package"
dpkg-buildpackage --sign-key="${GPG_KEY_FINGERPRINT}" --build=source

cd ..
ls -l
echo ".dsc content:"
cat *.dsc
echo ".buildinfo content:"
cat *.buildinfo
echo ".changes content:"
cat *.changes

dput "${PPA_URL}" *.changes
