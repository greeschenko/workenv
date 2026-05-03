#!/bin/bash

screendir=/home/$USER/screenshots/

if ! [ -d "$screendir" ]; then
    mkdir -p "$screendir"
fi

scrot -s "${screendir}%Y%m%d-%H%M%S_%wx%h.png" -e 'gimp $f && notify-send $n "...saved"'

