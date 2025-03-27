echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/"$USER"_nopass
# add this to Startup Applications
# /bin/bash -c 'sleep 10; setxkbmap -layout us,ara -option grp-led:caps caps:escape'
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update

sudo apt install git curl aptitude gcc neovim tmux fd-find ripgrep tealdeer bash-completion unzip wget mpv yt-dlp software-properties-common node npm python-venv

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"


# install Extension Manager App
# # disable the hotkeys super + 1/2/3/4 for running dock apps
# gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false
# # see what keybinders is using super+digit
# gsettings list-recursively org.gnome.desktop.wm.keybindings | rg '<Super>\d'
# for i in {1..12}; do echo $i; gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$i']"; done
#

## Docker
## from docs.docker.com/engine/install/ubuntu
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo groupadd docker
sudo usermod -aG docker $USER
