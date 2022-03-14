This document is extracted `Install` section from [README.md].

---

1. Launch the ISO env
2. In `ranger` interface, press `Shift s` key combi to enter the shell
3. If necessary, perform [partitioning] using `cfdisk` or similar
4. Run the below

```bash
tar -C /mnt -Ipixz -xf /rootfs.tpxz
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt hwclock --systohc
arch-chroot /mnt /bin/sh -c 'efi_dir=/boot && grub-install --efi-directory="$efi_dir" && grub-mkconfig -o "$efi_dir/grub/grub.cfg"'
```

- `/mnt` expects the partition is mounted
- The variable `efi_dir` value is changeable as needed

Finally, run `reboot`.
Installation complete!

[README.md]: https://raw.githubusercontent.com/sakkke/quilt/main/README.md
[partitioning]: https://wiki.archlinux.org/title/Partitioning
