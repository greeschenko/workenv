#!/bin/bash

# Screen recording with audio
outdir=/home/$USER/Videos/

if ! [ -d "$outdir" ]; then
    mkdir -p "$outdir"
fi

# Auto-detect resolution
resolution=$(xrandr --current 2>/dev/null | grep '*' | awk '{print $1}' | head -1)
if [ -z "$resolution" ]; then
    resolution="1920x1200"
fi

# Generate filename
outfile="${outdir}$(date +%Y%m%d-%H%M%S).mp4"

# Notify and record
notify-send "Recording started" "Saving to $outfile"
ffmpeg -video_size "$resolution" -framerate 25 -f x11grab -i :0.0+0,0 \
  -c:v libx264 -preset veryfast -pix_fmt yuv420p -crf 23 \
  -c:a aac -b:a 128k \
  "$outfile"
notify-send "Recording saved" "$outfile"
