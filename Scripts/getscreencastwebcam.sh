#!/bin/bash

outdir=/home/$USER/Videos/

if ! [ -d "$outdir" ]; then
    mkdir -p "$outdir"
fi

resolution=$(xrandr --current 2>/dev/null | grep '*' | awk '{print $1}' | head -1)
if [ -z "$resolution" ]; then
    resolution="1920x1200"
fi

outfile="${outdir}$(date +%Y%m%d-%H%M%S).mp4"

monitor_source=$(pactl get-default-sink).monitor
mic_source=$(pactl get-default-source)

killall mplayer 2>/dev/null

mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0:fps=15 \
  -noborder -really-quiet &

mplayer_pid=$!

cleanup() {
    kill "$mplayer_pid" 2>/dev/null
}
trap cleanup EXIT

notify-send "Recording started" "Webcam + screen + audio -> $outfile"
ffmpeg -video_size "$resolution" -framerate 25 -f x11grab -i :0.0+0,0 \
  -f pulse -i "$monitor_source" \
  -f pulse -i "$mic_source" \
  -filter_complex "[1:a][2:a]amix=inputs=2:duration=first:dropout_transition=3[aout]" \
  -map 0:v -map "[aout]" \
  -c:v libx264 -preset veryfast -pix_fmt yuv420p -crf 23 \
  -c:a aac -b:a 128k \
  "$outfile"
notify-send "Recording saved" "$outfile"
