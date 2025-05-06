# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
	PATH="$PATH:$HOME/.local/bin"
fi

## For Flutter
#if [ ! $ANDROID_HOME ]; then
#  export ANDROID_HOME="$HOME/Android"
#  export ANDROID_SDK_ROOT="$ANDROID_HOME/cmdline-tools/12.0"
#  export JAVA_HOME="$ANDROID_HOME/openjdk"
#  export PATH="$PATH:$JAVA_HOME/bin:$ANDROID_SDK_ROOT/bin:$ANDROID_HOME/flutter/bin:$HOME/.pub-cache/bin/"
#fi

# Nodejs
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
	export FNM_MULTISHELL_PATH="$HOME/.local/share/fnm/aliases/default"
	export PATH="$PATH:$FNM_MULTISHELL_PATH/bin:$FNM_PATH"
	export FNM_VERSION_FILE_STRATEGY="local"
	export FNM_DIR="$HOME/.local/share/fnm"
	export FNM_LOGLEVEL="info"
	export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
	export FNM_COREPACK_ENABLED="false"
	export FNM_RESOLVE_ENGINES="true"
	export FNM_ARCH="x64"
fi

## Laravel
export PHP_INI_SCAN_DIR="$HOME/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

## Bad but I'm lazy
export PGUSER=postgres
export PGPASSWORD=postgres

xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keycode 66 = Escape NoSymbol Escape"
