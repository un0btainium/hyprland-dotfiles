#!/usr/bin/env bash
# Zeigt alle Keybinds mit Beschreibung (aus der laufenden Hyprland-Config)
hyprctl binds -j | jq -r '
  def mods: [
    (if (.modmask / 64 | floor) % 2 == 1 then "Super" else empty end),
    (if (.modmask / 4  | floor) % 2 == 1 then "Ctrl"  else empty end),
    (if (.modmask / 8  | floor) % 2 == 1 then "Alt"   else empty end),
    (if .modmask % 2 == 1 then "Shift" else empty end)
  ] | join("+");
  .[] | select((.description // "") | length > 0)
  | (mods) as $m
  | (if $m == "" then .key else $m + "+" + .key end) + "\t" + .description' \
  | column -t -s $'\t' | rofi -dmenu -i -p "keys" -theme-str 'window {width: 760px;} listview {lines: 16;}'
