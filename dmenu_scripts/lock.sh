#!/bin/bash

TMP="/tmp/lock.png"

scrot "$TMP"
convert "$TMP" -blur 0x5 "$TMP"
i3lock -i "$TMP"
rm "$TMP"
