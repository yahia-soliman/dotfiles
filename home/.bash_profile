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

# For Flutter
if [ ! $ANDROID_HOME ]; then
  export ANDROID_HOME="$HOME/Android"
  export ANDROID_SDK_ROOT="$ANDROID_HOME/cmdline-tools/12.0"
  export JAVA_HOME="$ANDROID_HOME/openjdk"
  export PATH="$PATH:$JAVA_HOME/bin:$ANDROID_SDK_ROOT/bin:$ANDROID_HOME/flutter/bin:$HOME/.pub-cache/bin/"
fi

[[ ! $DISPLAY && $(tty) = "/dev/tty1" ]] && dbus-run-session startx

if [[ "$TERM" = "linux" && $(tty) = "/dev/tty2" ]]; then
    echo -en "\e]P0222222" #black
    echo -en "\e]P8222222" #darkgrey
    echo -en "\e]P1803232" #darkred
    echo -en "\e]P9982b2b" #red
    echo -en "\e]P25b762f" #darkgreen
    echo -en "\e]PA89b83f" #green
    echo -en "\e]P3aa9943" #brown
    echo -en "\e]PBefef60" #yellow
    echo -en "\e]P4324c80" #darkblue
    echo -en "\e]PC2b4f98" #blue
    echo -en "\e]P5706c9a" #darkmagenta
    echo -en "\e]PD826ab1" #magenta
    echo -en "\e]P692b19e" #darkcyan
    echo -en "\e]PEa1cdcd" #cyan
    echo -en "\e]P7ffffff" #lightgrey
    echo -en "\e]PFdedede" #white

    FBTERM=1 exec fbterm
fi
