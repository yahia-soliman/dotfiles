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

if [[ -d "$HOME/Android" && ! $ANDROID_HOME ]]; then
  export ANDROID_HOME="$HOME/Android"
  export ANDROID_SDK_ROOT="$ANDROID_HOME/cmdline-tools/latest"
  export JAVA_HOME="$ANDROID_HOME/openjdk"
  export PATH="$PATH:$JAVA_HOME/bin:$ANDROID_SDK_ROOT/bin:$ANDROID_HOME/flutter/bin:$ANDROID_HOME/platform-tools:$HOME/.pub-cache/bin"
fi

if [[ -d "$HOME/.cargo/" ]]; then
  export PATH="$PATH:$HOME/.cargo/bin/"
fi

export HISTSIZE=100000
export HISTFILESIZE=-1
export PGUSER=postgres
export EDITOR=/usr/bin/nvim

source /usr/share/bash-completion/bash_completion 2> /dev/null || true

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$PATH:$FNM_PATH"
  eval "`fnm env`"
fi
