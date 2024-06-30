setxkbmap -layout us,ara -variant ,digits -option  grp:alt_shift_toggle grp-led:caps caps:escape
xmodmap $HOME/.config/xmodmap/.pke
# CM_LAUNCHER='rofi' clipmenud &
# xrdb $HOME/.Xresources
sxhkd & pipewire &
$HOME/.fehbg
picom -b --log-file ~/.local/state/picom.log
exec i3
