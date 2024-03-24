setxkbmap -layout us,ara -variant ,digits -option  grp:alt_shift_toggle grp-led:caps caps:escape
xmodmap .config/xmodmap/.pke
sxhkd &
systemctl --user import-environment DISPLAY
picom &
CM_LAUNCHER='rofi' clipmenud &
$HOME/.fehbg
awesome
#600
