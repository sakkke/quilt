This document is extracted `Manual Install to EFI system` section from [README.md].

---

## Install

### Manual Install to EFI system

First, prepare Quilt bootable device, referring to [Example to create bootable device].

1. Launch the ISO env
2. In `ranger` interface, press `Shift s` key combi to enter the shell
3. If necessary, perform [partitioning] using `cfdisk` or similar, referring to [Example to partitioning]
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

### Quick Installer for EFI system

**Warning!**: Quick Installer will remove all your selected disk data!
Recommend you back up your files first.

To run Quick Installer:

```bash
/root/.quick-installer
```

#### Quick Installer for EFI system overview

1. Select the disk on which you want to install Quilt
2. Type `yes` to confirm
3. Auto: Create the GPT to your selected disk
4. Auto: Make it partition Linux filesystem and EFI system
5. Auto: Do [Manual install] section
6. Installation complete!

## Misc

### Example to create bootable device

```bash
echo label: gpt | sudo sfdisk --wipe always path/to/device
sudo dd bs=100M if=path/to/iso of=path/to/device status=progress
```

- `path/to/device` is a device file (e.g. `/dev/sda`)

### Partitioning Example

```bash
sfdisk path/to/device << /sfdisk
label: gpt

size=300MiB, type=U
type=L
/sfdisk
```

[Example to create bootable device]: #example-to-create-bootable-device
[Partitioning Example]: #partitioning-example
[README.md]: https://raw.githubusercontent.com/sakkke/quilt/main/README.md
[partitioning]: https://wiki.archlinux.org/title/Partitioning
