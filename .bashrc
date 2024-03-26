# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#PS1='[\u@\h \W]\$ '
#PS1="\[\e[1;31m\] \[\e[0m\] "
eval "$(starship init bash)"
source /etc/profile.d/bash_completion.sh


set -o vi
export XDG_CONFIG_HOME=$HOME/.config
export PATH=$PATH:$HOME/bin:$HOME/sbin
export EDITOR="nvim"

alias pyx='source ~/.venv/pyx/bin/activate'
alias mariadbms='mariadb -hlocalhost -umortar -p'

alias vi='nvim'
alias c='clear'
alias mp='mplayer -zoom'
alias poweroff='doas systemctl poweroff'

alias ls='ls --color=auto'
alias la='ls -la'
alias ll='ls -l'

alias gcx='gcc -Wall -pedantic -Werror -Wextra -std=gnu89'
alias glg='git log --oneline --graph --decorate --all'

alias yt='yt-dlp --ignore-errors --continue --no-overwrites --download-archive "./done.txt" --output "./%(playlist_index)003d - %(title)s.%(ext)s" -S'
alias y3='yt-dlp -f "bestaudio[ext=m4a]" --ignore-errors --continue --no-overwrites --download-archive "./done.txt" --output "./%(playlist_index)003d - %(title)s.%(ext)s" -S'

alias q='doas nala search'
alias qi='q --installed'
alias i='doas nala install'
alias u='doas nala update; doas nala upgrade --exclude awesome'
alias r='doas nala purge'


alias w-clean='doas rm /run/wpa_supplicant/wlp2s0'
alias wpa='doas wpa_supplicant -B -i wlp2s0 -c /etc/wpa_supplicant/wpa_supplicant.conf; w-clean'
alias fcache='rm -rf ~/.cache/fontconfig && doas fc-cache -r -v'
alias list_enabled_services='systemctl list-unit-files --state=enabled --type=service'

colorscripts_dir="$HOME/bin/color-scripts"
colorscripts_tot=$(($(ls "$colorscripts_dir" | wc -l) - 1))
random_colorscript=$(ls "$colorscripts_dir" | tr "\n" " " | cut -d " " -f $(("$RANDOM"%"$colorscripts_tot" + 1)) )
"${colorscripts_dir}/${random_colorscript}"


# Load Angular CLI autocompletion.
source <(ng completion script)
