#
# BAAAAAAAAAAAAAAASH
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi

export PS1="\[\e[36m\]\[\e[m\] \W \[\e[1;31m\]>\[\e[m\]\[\e[1;32m\]>\[\e[m\] "
PROMPT_COMMAND='((x = $? == 0 ? 6 : 1)); PS1=${PS1/3?m/3"$x"m};'

alias ls='ls --color=auto'
alias la='ls -la'
alias ll='ls -l'
alias grep='grep --color=auto'
alias reboot='doas reboot; exit'
alias poweroff='doas poweroff; exit'

alias pipi='pip install --break-system-packages --user'
alias gcx='gcc -Wall -pedantic -Werror -Wextra -std=gnu89'
alias checkforces='gcc main.c && diff output <(./a.out < input)'
alias semicheck="semistandard *.js | awk -F/ '{print \$NF}'"
alias diffdir='icdiff -r --show-no-spaces -x "*.po"'
alias yt='yt-dlp --ignore-errors --continue --no-overwrites --download-archive "./done.txt" --output "./%(playlist_index)003d - %(title)s.%(ext)s" -S' # res:720
alias y3='yt-dlp -f "bestaudio[ext=m4a]" --ignore-errors --continue --no-overwrites --download-archive "./done.txt" --output "./%(playlist_index)003d - %(title)s.%(ext)s"'

alias i='doas xbps-install -S'
alias u='i; doas xbps-install -u xbps; doas xbps-install -u'
alias r='doas xbps-remove -R'
alias q='doas xbps-query -Rs'
alias qi='doas xbps-query -Rm'

xevshort() {
	xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

__PAINTF_SCRIPTS=("$HOME/.local/bin/color-scripts/"*)
_PAINTF_SCRIPTS=${__PAINTF_SCRIPTS[@]##*/}
paintf() {
	"$HOME/.local/bin/color-scripts/${1:-$(shuf -n 1 -e ${_PAINTF_SCRIPTS[@]})}"
}
complete -W "${_PAINTF_SCRIPTS[@]}" paintf

odoodev() {
	local DB=${1}
	./odoo-bin -c ./odoo.conf --dev=xml \
		--addons-path=./addons/,./enterprise/,./${DB} -d ${DB/\//} ${@:2}
	# find *addons* -regex '.*\.\(py\|xml\|html\|css\|js\|csv\)$' |\
	# entr -s "./odoo-bin -c ./odoo.conf -d ${1} -u ${2:-all} ${@:3}";
}
alias emulaunch="~/Android/emulator/emulator -avd nexus -dns-server"

# [[ "$TERM" = "linux" && -n "FBTERM" ]] && export TERM=fbterm
