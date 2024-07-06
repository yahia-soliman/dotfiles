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


# for pipewire
export XDG_RUNTIME_DIR=/tmp/$USER-runtime
mkdir -pm 0700 $XDG_RUNTIME_DIR

[[ ! $DISPLAY && $(tty) = "/dev/tty1" ]] && dbus-run-session startx
