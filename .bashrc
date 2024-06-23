#
# BAAAAAAAAAAAAAAASH
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
set -o vi

# PS1='[\u@\h \W]\$ '

export PS100="\W \[\e[1;31m\]>\[\e[m\]\[\e[1;33m\]>\[\e[m\]\[\e[1;32m\]>\[\e[m\] "
__bash_prompt() {
	local EXIT="$?"
	if [ $EXIT != 0 ]; then
		PS1="\[\e[31m\]\[\e[m\] ${PS100}"
	else
		PS1="\[\e[36m\]\[\e[m\] ${PS100}"
	fi
}
PROMPT_COMMAND=__bash_prompt

# env variables
PATH="$PATH:$HOME/.local/bin"
MANPATH="$(manpath):$HOME/.local/share/man"
NODE_PATH="$HOME/.local/lib/node_modules"
# this will be useful if only this line is in the .npmrc
# prefix = "${HOME}/.local"


alias vi='nvim'
alias ls='ls --color=auto -1'
alias la='ls -la'
alias ll='ls -l'
alias grep='grep --color=auto'
alias reboot='doas systemctl reboot'
alias poweroff='doas systemctl poweroff'
alias services='systemctl list-unit-files --state=enabled --type=service'

alias pipi='pip install --break-system-packages --user'

alias blueconn='doas systemctl start bluetooth.service && sleep 1; bluetoothctl connect E2:FA:E8:4A:94:2F'

alias gcx='gcc -Wall -pedantic -Werror -Wextra -std=gnu89'
alias glg='git log --oneline --graph --decorate --all'
alias semicheck="semistandard *.js | awk -F/ '{print \$NF}'"

alias yt='yt-dlp --ignore-errors --continue --no-overwrites --download-archive "./done.txt" --output "./%(playlist_index)003d - %(title)s.%(ext)s" -S'
alias y3='yt-dlp -f "bestaudio[ext=m4a]" --ignore-errors --continue --no-overwrites --download-archive "./done.txt" --output "./%(playlist_index)003d - %(title)s.%(ext)s"'

alias i='doas pacman -S'
alias r='doas pacman -Runs'

xevshort () {
	xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }';
}

paintf() {
	clear
	local N="$1"
	[[ "$N" ]] || local N=$RANDOM

	local DIR="$HOME/.local/bin/color-scripts"
	local TOTAL=$(ls "$DIR" | wc -w)
	local SCRIPT=$(ls "$DIR" | tr "\n" " " | cut -d " " -f $(("$N" % "$TOTAL" + 1)) )
	"$DIR/$SCRIPT"
}
