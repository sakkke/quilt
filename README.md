# Quilt

Quilt is the Linux distro.

## Features

- Automatically start [`tmux`](https://wiki.archlinux.org/title/Tmux) and [`ranger`](https://wiki.archlinux.org/title/Ranger) as of the virtual console
- Almost pure [Arch Linux](https://archlinux.org/)
- Easy installation, done in offline

## Dev env setup

```bash
pacman --needed -S - < dev.packages.x86_64
```

## Build the ISO

Run `./build.sh` or the below enable logging:

```bash
{ time ./build.sh; } 2>&1 | tee build.log
```

## Install

1. Launch the ISO env
1. In `ranger` interface, press `Shift s` key combi to enter the shell
1. If necessary, perform [partitioning](https://wiki.archlinux.org/title/Partitioning) using `cfdisk` or similar
1. Run the below

```bash
tar -C /mnt -Ipixz -xf /rootfs.tpxz
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt hwclock --systohc
arch-chroot /mnt 'efi_dir=/boot && grub-install --efi-directory="$efi_dir" && grub-mkconfig -o "$efi_dir/grub/grub.cfg"'
```

- `/mnt` expects the partition is mounted
- The variable `efi_dir` value is changeable as needed

Finally, run `reboot`.
Installation complete!

## License

MIT
