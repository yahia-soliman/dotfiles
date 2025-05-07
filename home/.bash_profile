# .bash_profile

# Get the aliases and functions
# [ -f $HOME/.bashrc ] && . $HOME/.bashrc
export PATH="$PATH:$HOME/.local/bin"
# export MANPATH="$(manpath):$HOME/.local/share/man"
# MANPATH is useless since it can be accessed
# from $PATH/../share/man due to the line above

export NODE_PATH="$HOME/.local/lib/node_modules"
# this will be useful if only this line is in the .npmrc
# prefix = "${HOME}/.local"

if uwsm check may-start; then
  exec uwsm start hyprland.desktop
fi
