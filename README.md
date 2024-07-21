# Comfy home inside the Void

# System Specs

| OS     | Void Linux |
| ------ | ---------- |
| WM     | i3         |
| Editor | Neovim     |
| Term   | Alacritty  |
| Audio  | pipewire   |

# Configuration Steps
## Prerequisites
- Fresh Void Linux installation, [help](https://docs.voidlinux.org/installation/live-images/prep.html)
- Connection to the internet `ping voidlinux.org`
- Suitable CPU and GPU drivers Installed, [help](https://docs.voidlinux.org/config/graphical-session/graphics-drivers/index.html)

### Update the system
After a fresh Void install the first thing is to update the system
```sh
sudo xbps-install -S; sudo xbps-install -u xbps; sudo xbps-install -u;
```

### configure `doas`
this is the last time we use `sudo`
```sh
sudo xbps-install -S opendoas
echo permit nopass $USER as root | sudo tee /etc/doas.conf
```
### Set Aliases
this aliases to help shortening commands in the script and here is the document.
```sh
# install packages
alias i='doas xbps-install -S'
# update the system, or packages
alias u='i; doas xbps-install -u xbps; doas xbps-install -u'
# remove packages
alias r='doas xbps-remove -R'
alias q='doas xbps-query -Rs' 
alias qi='doas xbps-query -Rm'
```

### Install needed packages
```sh
i mesa-dri # for amd & intel GPU
i xorg-minimal xinit setxkbmap sxhkd xmodmap xclip xrdb maim feh
i picom i3 i3status alacritty rofi breeze-obsidian-cursor-theme
i noto-fonts-ttf noto-fonts-emoji nerd-fonts-symbols-ttf font-sourcecodepro
i dbus pipewire wireplumber
i git tmux neovim

# the following are optional if you will not use my nvim config
i fd ripgrep tealdeer bash-completion unzip wget curl
i zig python3 nodejs
i mpv yt-dlp
```

### use `neovim`
```sh
doas rm -rf /usr/bin/nvi
doas ln -sf /usr/bin/{nvim,vi}
```

### Audio with `pipewire`
```sh
doas mkdir -p /etc/pipewire/pipewire.conf.d
doas ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
doas ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/
doas ln -s /etc/sv/dbus/ /var/service/
```

## Enable Bluetooth
```sh
# check if the user has bluetooth and it is unblocked
rfkill | grep bluetooth

# if you have bluetooth in the output
rfkill unblock bluetooth
i bluez libspa-bluetooth
doas ln -s /etc/sv/{dbus,bluetoothd}/ /var/service/
doas usermod $USER -aG bluetooth
```

### clone the `dotfiles`
```sh
git clone https://github.com/yahia-soliman/dotfiles
```

### Link configurations
```sh
mkdir -p ~/.config ~/.local/bin

ln -s ~/dotfiles/.config/* ~/.config/
ln -sf ~/dotfiles/home/.* ~/
ln -sf ~/dotfiles/bin/* ~/.local/bin/
```

## Reboot and Enjoy The Void
If there is any issue contact me or submit an issue on this repo
