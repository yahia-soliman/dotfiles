setxkbmap -layout us,ara -variant ,digits -option  grp:alt_shift_toggle grp-led:caps caps:escape
xmodmap $HOME/.config/xmodmap/.pke
# CM_LAUNCHER='rofi' clipmenud &
sxhkd & pipewire & picom -b # --log-file ~/.local/state/picom.log
xrdb -merge $HOME/.Xresources
$HOME/.fehbg
exec i3
