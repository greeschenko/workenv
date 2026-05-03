#!/usr/bin/bash

feh --bg-tile /home/olex/Images/wp_1.jpg

synclient TapButton3=2 &
xcompmgr -n &
setxkbmap -option "ctrl:nocaps" &
xset r rate 160 60 &
xset b off &
clipmenud &
wmname L3D &
dwmblocks &
dunst &

exec dbus-run-session dwm
