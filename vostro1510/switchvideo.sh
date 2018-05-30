#!/usr/bin/sh

intern='LVDS-1'
extern='VGA-1'

export DISPLAY=:0.0
export XAUTHORITY=/home/ash/.cache/xauthority

if xrandr | grep "${extern} disconnected"; then
    xrandr --output "${extern}" --off --output "${intern}" --auto
else
    xrandr --output "${intern}" --off --output "${extern}" --auto
fi
