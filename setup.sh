#!/bin/bash
set -e
clear

############
# PROGRAMS #
############
SYSTEM_UTILS=(
	nvidia
	egl-wayland
	polkit

	1password
	nerdfetch
	fzf
	zip
	unzip
	wget
	curl
	fd
	ripgrep
	tealdeer
	bash-completion
)

DEV_TOOLS=(
	gcc
	python
	node
	yazi
	bat
	neovim
	tmux
	ghostty
	git
	lazygit
	delta
	icdiff
	httpie
	cloc
	postgresql
)

DESKTOP=(
	uwsm
	hyprland
	wofi
	waybar
	hyprlock
)

MEDIA=(
	yt-dlp
)

FONTS=(
	noto-fonts
	noto-fonts-emoji
	ttf-font-awesome
	otf-geist-mono-nerd
)

FLATPAKS=(
	mpv
	zen
	chrome
	anydesk
	telegram
	flameshot
	onlyoffice
)

SERVICES=(
)


#####################
# UTILITY FUNCTIONS #
#####################
is_installed() {
	pacman -Qi "$1" &>/dev/null
}
is_group_installed() {
	pacman -Qg "$1" &>/dev/null
}
install_packages() {
	local packages=("$@")
	local to_install=()

	for pkg in "${packages[@]}"; do
		if ! is_installed "$pkg" && ! is_group_installed "$pkg"; then
			to_install+=("$pkg")
		fi
	done

	if [ ${#to_install[@]} -ne 0 ]; then
		echo "Installing: ${to_install[*]}"
		paru -S --noconfirm "${to_install[@]}"
	fi
}


#########################
# PACKAGE MANAGER SETUP #
#########################
if ! command -v paru &>/dev/null; then
	echo "Installing paru AUR helper"

	sudo pacman -S --noconfirm --needed git base-devel
	PARU_DIR=$(mktemp)
	cd $PARU_DIR
	git clone https://aur.archlinux.org/paru.git .
	makepkg -si --noconfirm
	cd -
	rm -rf $PARU_DIR
fi


##################
# INSTALL THINGS #
##################
echo "Installing system utilities..."
install_packages "${SYSTEM_UTILS[@]}"

echo "Installing development tools..."
install_packages "${DEV_TOOLS[@]}"

echo "Installing media packages..."
install_packages "${MEDIA[@]}"

echo "Installing fonts..."
install_packages "${FONTS[@]}"

echo "Installing desktop environment..."
install_packages "${DESKTOP[@]}"

echo "Installing desktop applications..."
for pak in "${FLATPAKS[@]}"; do
  if ! flatpak list | grep -i "$pak" &> /dev/null; then
    echo "Installing Flatpak: $pak"
    flatpak install --noninteractive "$pak"
  else
    echo "Flatpak already installed: $pak"
  fi
done


############
# SERVICES #
############
echo "Configuring services..."
for service in "${SERVICES[@]}"; do
	if ! systemctl is-enabled "$service" &>/dev/null; then
		echo "Enabling $service..."
		sudo systemctl enable "$service"
	else
		echo "$service is already enabled"
	fi
done

############################
# ENABLE BLUETOOTH SUPPORT #
############################
if ! rfkill --output TYPE | grep bluetooth &>/dev/null; then
	echo "Enabling bluetooth support..."
	install_packages bluez libspa-bluetooth
	sudo systemctl enable bluetoothd
	sudo usermod $USER -aG bluetooth
fi

############
# DOTFILES #
############
echo "Linking dotfiles"
mkdir -p ~/.config ~/.local/bin
ln -s ~/dotfiles/.config/* ~/.config/
ln -sf ~/dotfiles/home/.* ~/
ln -sf ~/dotfiles/bin/* ~/.local/bin/

echo "Downloading a wallpaper to ~/.config/bg/"
curl -sL https://w.wallhaven.cc/full/rr/wallhaven-rrv85q.png -o ~/.config/bg/keyboard.png

#############
# VI = NVIM #
#############
sudo rm -rf /usr/bin/nvi
sudo ln -sf /usr/bin/{nvim,vi}

echo "Setup complete! You may want to reboot your system."
