#!/usr/bin/env bash

set -eux

function get_packages {
  for profile in "$@"; do
    printf '%s\n' "configs/$profile/$profile.packages.x86_64"
  done
}

cd "$(dirname "$0")"
source build.config.sh
rm -frv build/minirootfs
mkdir -pv build/minirootfs
sort $(get_packages "${miniprod_profiles[@]}") | pacstrap -c build/minirootfs --noprogressbar -
arch-chroot build/minirootfs /bin/sh -c "sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen && locale-gen"

for profile in "${miniprod_profiles[@]}"; do
  cp -RTv configs/$profile/airootfs build/minirootfs || :
done

(
  cd build/minirootfs \
    && find -maxdepth 1 -mindepth 1 -print0 \
    | tar --null -cT- \
    | pigz -9 > ../minirootfs.tar.gz
)

du -h build/minirootfs.tar.gz
