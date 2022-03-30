#!/usr/bin/env bash

set -eux

cd "$(dirname "$0")"
rm -frv build/minirootfs.{qcow2,raw,shells}
qemu-img create -f qcow2 build/minirootfs.qcow2 8G
modprobe nbd
qemu-nbd -c /dev/nbd0 build/minirootfs.qcow2
sfdisk /dev/nbd0 << /sfdisk
label: gpt

type=L
/sfdisk
mkfs.ext4 /dev/nbd0p1
mount /dev/nbd0p1 /mnt
tar -C /mnt -Ipigz -xf build/minirootfs.tar.gz
arch-chroot /mnt /bin/sh -c 'echo root:root | chpasswd'
umount /mnt
qemu-nbd -d /dev/nbd0
qemu-img convert -f qcow2 -O raw build/minirootfs.qcow2 build/minirootfs.raw
php rbdconv/raw-to-rbd.php build/minirootfs.raw | pixz -9to build/minirootfs.shells
