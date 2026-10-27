#!/usr/bin/env bash
# AMD-GPU: Auslastung + Temperatur als Waybar-JSON
d=$(ls -d /sys/class/drm/card*/device 2>/dev/null | while read -r p; do [ -r "$p/gpu_busy_percent" ] && echo "$p" && break; done)
[ -z "$d" ] && exit 0
use=$(cat "$d/gpu_busy_percent")
temp=$(( $(cat "$d"/hwmon/hwmon*/temp1_input 2>/dev/null | head -1) / 1000 ))
cls=normal; [ "$use" -ge 90 ] && cls=critical
printf '{"text":"󰢮 %s%%","tooltip":"GPU %s%% · %s°C","class":"%s"}\n' "$use" "$use" "$temp" "$cls"
