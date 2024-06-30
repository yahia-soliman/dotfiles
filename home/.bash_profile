# .bash_profile

# Get the aliases and functions
# [ -f $HOME/.bashrc ] && . $HOME/.bashrc

# for pipewire
export XDG_RUNTIME_DIR=/tmp/$USER-runtime
mkdir -pm 0700 $XDG_RUNTIME_DIR

[[ ! $DISPLAY && $(tty) = "/dev/tty1" ]] && startx
