#!/usr/bin/env bash

dir="$HOME/.config/rofi/powermenu"
uptime="$(uptime -p | sed -e 's/up //g')"

# Options
lock=''
suspend=''
logout=''
reboot=''
shutdown=''
yes=''
no=''

# Rofi CMD
rofi_cmd() {
	#-kb-accept-entry ''\
	rofi -dmenu \
		-p "Uptime: $uptime" \
		-mesg "Uptime: $uptime" \
		-click-to-exit \
		-theme ${dir}/config.rasi
}

# Confirmation CMD
confirm_cmd() {
	rofi -dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme ${dir}/confirm.rasi
}

# Ask for confirmation
confirm() {
	selected=$(echo -e "$yes\n$no" | confirm_cmd)
	[ "$selected" == "$yes" ]
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
$shutdown)
	confirm && systemctl poweroff
	;;
$reboot)
	confirm && systemctl reboot
	;;
$lock)
	loginctl lock-session
	;;
$suspend)
	systemctl suspend
	;;
$logout)
	confirm && uwsm stop
	;;
esac
