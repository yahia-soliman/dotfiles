install niri as they recommend in https://yalter.github.io/niri/Getting-Started.html

```
sudo dnf copr enable avengemedia/dms
sudo dnf install niri dms
systemctl --user add-wants niri.service dms
```


## NVIDIA DRIVERS:
first configure rpmfusion (https://rpmfusion.org/Configuration)
```
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
```

Then follow this how to (https://rpmfusion.org/Howto/NVIDIA)
```
sudo dnf update -y # and reboot if you are not on the latest kernel
sudo dnf install akmod-nvidia # rhel/centos users can use kmod-nvidia instead
sudo dnf install xorg-x11-drv-nvidia-cuda #optional for cuda/nvdec/nvenc support
```

I should have to configured secureboot before installing the drivers
but anyways here is how to enable secure boot: https://rpmfusion.org/Howto/Secure%20Boot
3
and for the kernel module usability in the kernel module do the following again
because we installed the driver before enabling secure boot
```
sudo dnf remove kmod-nvidia-\*
sudo akmods --force
```

enabled nvidia suspend according to (https://rpmfusion.org/Howto/NVIDIA)
```
sudo dnf install xorg-x11-drv-nvidia-power
sudo systemctl enable nvidia-{suspend,resume,hibernate,powerd}
```


### Asus Linux
following this guide (https://asus-linux.org/guides/fedora-guide/)
```
sudo dnf copr enable lukenukem/asus-linux
sudo dnf update
sudo dnf install asusctl supergfxctl
sudo dnf update --refresh
sudo dnf install asusctl-rog-gui
```


## MY Dotfiles
enabled copr
```
sudo dnf copr enable atim/lazygit
sudo dnf copr enable avengemedia/dms
sudo dnf update --refresh
```
installd packages
```
niri dms
neovim nodejs nodejs-npm python3-pip
papirus-icon-theme
yt-dlp flameshot feh mpv
lazygit git-delta bat cloc
ripgrep luarocks tree-sitter fd-find
```


sync bat theme and font configs
```
bat cache --build
fc-cache -fv
```


## Battery Care
I followed this toturial on tlp to set battery charge thresholds
https://linuxblog.io/boost-battery-life-on-linux-laptop-tlp/
```conf /etc/tlp.conf
START_CHARGE_THRESH_BAT0=50 
STOP_CHARGE_THRESH_BAT0=80
```


## (WIP) Switch between GPU moods
```
sudo systemctl enable supergfxd.service
sudo systemctl start supergfxd.service
```
can be controlled with a dms plugin

for full vedio codec support:
```
sudo dnf group upgrade  multimedia --exclude=PackageKit-gstreamer-plugin
```

# TODO
- fix sleep timer
- neovim, tmux, and dev setup
- write a script to automate the process
- test on another machine
- install and configure all flatpaks
- setup AI agents
