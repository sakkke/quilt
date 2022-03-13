![quilt](https://socialify.git.ci/sakkke/quilt/image?description=1&descriptionEditable=The%20Linux%20distro&font=Bitter&name=1&pattern=Charlie%20Brown&stargazers=1&theme=Dark)

## Features

- Automatically start [tmux] and [ranger] as of the virtual console
- Almost pure [Arch Linux]
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
2. In `ranger` interface, press `Shift s` key combi to enter the shell
3. If necessary, perform [partitioning] using `cfdisk` or similar
4. Run the below

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

[Arch Linux]: https://archlinux.org/
[partitioning]: https://wiki.archlinux.org/title/Partitioning
[ranger]: https://wiki.archlinux.org/title/Ranger
[tmux]: https://wiki.archlinux.org/title/Tmux
