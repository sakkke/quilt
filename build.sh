#!/usr/bin/env bash

set -eux

function get_packages {
  for profile in "$@"; do
    printf '%s\n' "configs/$profile/$profile.packages.x86_64"
  done
}

cd "$(dirname "$0")"
source build.config.sh
rm -frv build
cp -Rv archiso/configs/baseline build
mv -v build/{,baseline.}packages.x86_64

for profile in "${iso_profiles[@]}"; do
  cp -RTv "configs/$profile" build
done

sort -o build/packages.x86_64 build/*.packages.x86_64
mkdir -v build/rootfs
sort $(get_packages "${prod_profiles[@]}") | pacstrap -c build/rootfs --noprogressbar -
arch-chroot build/rootfs /bin/sh -c "sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen && locale-gen"
arch-chroot build/rootfs /bin/sh -c 'echo root:root | chpasswd'

for profile in "${prod_profiles[@]}"; do
  cp -RTv configs/$profile/airootfs build/rootfs || :
done

(
  cd build/rootfs \
    && find -maxdepth 1 -mindepth 1 -print0 \
    | tar --null -cT- \
    | pixz -9o ../airootfs/rootfs.tpxz
)

du -h build/airootfs/rootfs.tpxz
(cd build && mkarchiso -v .)
