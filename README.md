[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://vshymanskyy.github.io/StandWithUkraine)
![quilt](https://socialify.git.ci/sakkke/quilt/image?description=1&descriptionEditable=The%20Linux%20distro&font=Bitter&name=1&pattern=Charlie%20Brown&stargazers=1&theme=Dark)

<p align="center">
  <a href="https://discord.gg/pH9f6VyUbk">
    <img src="https://img.shields.io/discord/952831486980153344?color=000&logo=discord&labelColor=000&logoColor=fff&style=for-the-badge">
  </a>
  <img src="https://img.shields.io/badge/Buy%20Me%20a%20Coffee-000?logo=buymeacoffee&logoColor=fff&style=for-the-badge">
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

## Platforms

Arch | Name | State
--- | --- | ---
x86_64 | EFI system | Alpha
x86_64 | Docker | Coming soon
x86_64 | Shells | Coming soon
x86_64 | WSL 2 | Alpha

## Download

You can find downloadable files at [releases].

## Build

1. Clone this repo with `--recursive` option
2. Enter cloned dir

```bash
git clone --recursive https://github.com/sakkke/quilt.git
cd quilt
```

### Build all

```bash
sort -u build*.packages.x86_64 | sudo pacman --needed -Sy -
sudo ./build-all.sh
```

### Build the ISO

```bash
sudo pacman --needed -Sy - < build.packages.x86_64
sudo ./build.sh
```

### Build the minirootfs

```bash
sudo pacman --needed -Sy - < build-minirootfs.packages.x86_64
sudo ./build-minirootfs.sh
```

### Build the Shells image

```bash
sudo pacman --needed -Sy - < build-shells.packages.x86_64
./build-shells.sh
```

## Install

### Manual Install to EFI system

First, prepare Quilt bootable device, referring to [Example to create bootable device].

1. Launch the ISO env
2. In `ranger` interface, press `Shift s` key combi to enter the shell
3. If necessary, perform [partitioning] using `cfdisk` or similar, referring to [Partitioning Example]
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
5. Auto: Do [Manual Install to EFI system] section
6. Installation complete!

### Install to WSL 2

In Windows:

```
wsl.exe --import path\to\minirootfs.tar.gz path\to\dir Quilt
```

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

- `path/to/device` is a device file (e.g. `/dev/sda`)

## License

MIT

[Arch Linux]: https://archlinux.org/
[Example to create bootable device]: #example-to-create-bootable-device
[Manual Install to EFI system]: #manual-install-to-efi-system
[Partitioning Example]: #partitioning-example
[releases]: https://github.com/sakkke/quilt/releases
[partitioning]: https://wiki.archlinux.org/title/Partitioning
[ranger]: https://wiki.archlinux.org/title/Ranger
[tmux]: https://wiki.archlinux.org/title/Tmux
