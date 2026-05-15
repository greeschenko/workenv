#!/bin/bash
set -e

echo "==> Installing packages for workenv..."

sudo pacman -S --needed \
    base-devel xorg-server-devel libx11 \
    dmenu xorg-xrandr xorg-setxkbmap xcompmgr feh \
    ffmpeg scrot gimp imagemagick i3lock mplayer \
    pulseaudio pulseaudio-utils pavucontrol \
    htop iftop nload lm_sensors \
    iwd bluez bluez-utils \
    dunst libnotify clipmenu \
    zsh zsh-autosuggestions zsh-syntax-highlighting \
    fzf ripgrep bat bash-completion \
    vim neovim git \
    chromium links

echo "==> Done. All packages installed."
