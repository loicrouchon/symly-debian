#!/usr/bin/env sh
set -ex

package_name="symly"
version="$1"
package_version_dir="${package_name}-${version}"
upstream_tarball="${package_name}_${version}.orig.tar.gz"
upstream_tarball_url="https://github.com/loicrouchon/symly/archive/refs/tags/v${version}.tar.gz"
cur_dir="$(dirname "$(realpath "$0")")"

echo "Building debian source package ${package_version_dir}"

if ! (cat debian/changelog | grep -E "^${package_name} " | head -n 1 | grep -q "${package_name} (${version}-"); then
  echo "Package $package_name does not have a changelog entry for version $version"
  exit 1
fi

rm -rf "build"
mkdir -p "build/${package_name}"
cd "build/${package_name}" || exit 1

echo "Downloading upstream tarball from ${upstream_tarball_url}"
curl -sL "${upstream_tarball_url}" -o "${upstream_tarball}"

echo "Unpacking upstream tarball ${upstream_tarball}"
tar xzf "${upstream_tarball}"

echo "Repacking upstream tarball ${upstream_tarball} (get rid off root level directory)"
rm -f "${upstream_tarball}"
tar czf "${upstream_tarball}" "${package_version_dir}"

echo "Add debian dir"
cd "${package_version_dir}" || exit 1
cp -R "${cur_dir}/debian" "debian"

echo "Build source package"
dpkg-buildpackage --sign-key="${GPG_KEY_FINGERPRINT}" --build=source

cd ..
ls -l
echo ".dsc content:"
cat ./*.dsc
echo ".buildinfo content:"
cat ./*.buildinfo
echo ".changes content:"
cat ./*.changes

dput "${PPA_URL}" ./*.changes
