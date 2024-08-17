#
# BAAAAAAAAAAAAAAASH
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi

export PS1="\[\e[36m\]\[\e[m\] \W \[\e[1;31m\]>\[\e[m\]\[\e[1;33m\]>\[\e[m\]\[\e[1;32m\]>\[\e[m\] "
PROMPT_COMMAND='((x = $? == 0 ? 6 : 1)); PS1=${PS1/3?m/3"$x"m};'


alias ls='ls --color=auto -1'
alias la='ls -la'
alias ll='ls -l'
alias grep='grep --color=auto'
alias reboot='doas reboot'
alias poweroff='doas poweroff'
# alias services='systemctl list-unit-files --state=enabled --type=service'

alias pipi='pip install --break-system-packages --user'

# alias blueconn='doas systemctl start bluetooth.service && sleep 1; bluetoothctl connect E2:FA:E8:4A:94:2F'

alias gcx='gcc -Wall -pedantic -Werror -Wextra -std=gnu89'
alias semicheck="semistandard *.js | awk -F/ '{print \$NF}'"

alias yt='yt-dlp --ignore-errors --continue --no-overwrites --download-archive "./done.txt" --output "./%(playlist_index)003d - %(title)s.%(ext)s" -S'
alias y3='yt-dlp -f "bestaudio[ext=m4a]" --ignore-errors --continue --no-overwrites --download-archive "./done.txt" --output "./%(playlist_index)003d - %(title)s.%(ext)s"'

alias i='doas xbps-install -S'
alias u='i; doas xbps-install -u xbps; doas xbps-install -u'
alias r='doas xbps-remove -R'
alias q='doas xbps-query -Rs'
alias qi='doas xbps-query -Rm'

xevshort () {
  xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }';
}

paintf() {
  local DIR="$HOME/.local/bin/color-scripts"
  local SCRIPT=${1:-$(ls $DIR | shuf -n 1)}
  "$DIR/$SCRIPT"
}
