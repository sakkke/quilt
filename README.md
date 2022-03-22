[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://vshymanskyy.github.io/StandWithUkraine)
![quilt](https://socialify.git.ci/sakkke/quilt/image?description=1&descriptionEditable=The%20Linux%20distro&font=Bitter&name=1&pattern=Charlie%20Brown&stargazers=1&theme=Dark)

<p align="center">
  <a href="https://discord.gg/pH9f6VyUbk">
    <img src="https://img.shields.io/discord/952831486980153344?color=000&logo=discord&labelColor=000&logoColor=fff&style=for-the-badge">
  </a>
</p>

## Features

- Automatically start [tmux] and [ranger] as of the virtual console
- Almost pure [Arch Linux]
- Easy installation, done in offline

## Screenshots

<p align="center">
  <img alt="First boot" src="https://i.imgur.com/QL9zgYu.png" width="200">
  <img alt="Installation process" src="https://i.imgur.com/4bRBL1d.png" width="200">
</p>

## Download

You can find downloadable files at [releases].

## Dev env setup

```bash
sudo pacman --needed -Sy - < dev.packages.x86_64
```

## Build the ISO

Run `./build.sh` or the below enable logging:

```bash
{ time sudo ./build.sh; } 2>&1 | tee build.log
```

## Create bootable device

```bash
echo label: gpt | sudo sfdisk --wipe always path/to/device
sudo dd bs=100M if=path/to/iso of=path/to/device status=progress
```

- `path/to/device` is a device file (e.g. `/dev/sda`)

## Manual Install

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

## Quick Installer

**Warning!**: Quick Installer will remove all your selected disk data!
Recommend you back up your files first.

To run Quick Installer:

```bash
/root/.quick-installer
```

### Quick Installer overview

1. Select the disk on which you want to install Quilt
2. Type `yes` to confirm
3. Auto: Create the GPT to your selected disk
4. Auto: Make it partition Linux filesystem and EFI system
5. Auto: Do [Manual install] section
6. Installation complete!

## Build the minirootfs

The minirootfs is a gzipped tar file that does not include `linux` and `linux-firmware` packages.

Run `./build-minirootfs.sh` or the below enable logging:

```bash
{ time ./build-minirootfs.sh; } 2>&1 | tee build-minirootfs.log
```

## Install to WSL 2

In Windows:

```
wsl.exe --import path\to\minirootfs.tar.gz path\to\dir Quilt
```

## License

MIT

[Arch Linux]: https://archlinux.org/
[Manual install]: #manual-install
[releases]: https://github.com/sakkke/quilt/releases
[partitioning]: https://wiki.archlinux.org/title/Partitioning
[ranger]: https://wiki.archlinux.org/title/Ranger
[tmux]: https://wiki.archlinux.org/title/Tmux
