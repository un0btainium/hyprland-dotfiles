-- Niri-artige Binds, komplett ohne F-Tasten/Pfeile/Print (HHKB-tauglich).
-- Jeder Bind hat eine Beschreibung -> SUPER+SHIFT+/ zeigt die Liste.
local mod = "SUPER"
local home = os.getenv("HOME") .. "/.config/hypr/scripts/"

local function bind(keys, dsp, desc, opts)
    opts = opts or {}
    opts.description = desc
    return hl.bind(keys, dsp, opts)
end
local function run(cmd) return hl.dsp.exec_cmd(cmd) end

-- Programme
bind(mod .. " + T",         run("kitty"),                 "Terminal")
bind(mod .. " + Return",    run("kitty"),                 "Terminal")
bind(mod .. " + C",         run("kitty"),                 "Terminal")
bind(mod .. " + D",         run("rofi -show drun"),       "App-Launcher")
bind(mod .. " + Space",     run("rofi -show drun"),       "App-Launcher")
bind(mod .. " + SHIFT + D", run("rofi -show run"),        "Befehl ausfuehren")
bind(mod .. " + SHIFT + Tab", run("rofi -show window"),   "Fensterliste")
bind(mod .. " + W",         run("firefox"),               "Browser")
bind(mod .. " + E",         run("thunar"),                "Dateimanager")
bind(mod .. " + SHIFT + V", run("cliphist list | rofi -dmenu -p clip | cliphist decode | wl-copy"), "Clipboard-Verlauf")
bind(mod .. " + SHIFT + C", run("hyprpicker -a"),         "Farbe waehlen")
bind(mod .. " + SHIFT + slash", run(home .. "keys.sh"),   "Diese Hilfe: alle Keybinds")

-- Session
bind(mod .. " + Q",         hl.dsp.window.close(),        "Fenster schliessen")
bind(mod .. " + ALT + L",   run("loginctl lock-session"), "Bildschirm sperren")
bind(mod .. " + SHIFT + E", run("wlogout"),               "Power-Menue")
bind(mod .. " + SHIFT + R", run("hyprctl reload"),        "Config neu laden")

-- Fokus (hjkl wie Vim; in der Scrolling-Ansicht: h/l = Spalte, j/k = Fenster in Spalte)
bind(mod .. " + H", hl.dsp.focus({ direction = "left" }),  "Fokus links")
bind(mod .. " + L", hl.dsp.focus({ direction = "right" }), "Fokus rechts")
bind(mod .. " + K", hl.dsp.focus({ direction = "up" }),    "Fokus oben")
bind(mod .. " + J", hl.dsp.focus({ direction = "down" }),  "Fokus unten")

-- Fenster verschieben
bind(mod .. " + CTRL + H", hl.dsp.window.move({ direction = "left" }),  "Fenster nach links")
bind(mod .. " + CTRL + L", hl.dsp.window.move({ direction = "right" }), "Fenster nach rechts")
bind(mod .. " + CTRL + K", hl.dsp.window.move({ direction = "up" }),    "Fenster nach oben")
bind(mod .. " + CTRL + J", hl.dsp.window.move({ direction = "down" }),  "Fenster nach unten")

-- Monitore
bind(mod .. " + SHIFT + H", hl.dsp.focus({ monitor = "l" }), "Monitor links")
bind(mod .. " + SHIFT + L", hl.dsp.focus({ monitor = "r" }), "Monitor rechts")
bind(mod .. " + SHIFT + CTRL + H", hl.dsp.window.move({ monitor = "l" }), "Fenster auf Monitor links")
bind(mod .. " + SHIFT + CTRL + L", hl.dsp.window.move({ monitor = "r" }), "Fenster auf Monitor rechts")

-- Spalten (Scrolling-Layout)
bind(mod .. " + bracketleft",  hl.dsp.layout("movewindowto l"), "In linke Spalte einsortieren")
bind(mod .. " + bracketright", hl.dsp.layout("movewindowto r"), "In rechte Spalte einsortieren")
bind(mod .. " + R",     hl.dsp.layout("colresize +conf"), "Spaltenbreite durchschalten")
bind(mod .. " + minus", hl.dsp.layout("colresize -0.1"),  "Spalte schmaler")
bind(mod .. " + equal", hl.dsp.layout("colresize +0.1"),  "Spalte breiter")
bind(mod .. " + Z",     hl.dsp.layout("fit active"),      "Spalte einpassen/zentrieren")

-- Fenster-Zustand
bind(mod .. " + F",         hl.dsp.window.fullscreen({ mode = "maximized" }),  "Maximieren")
bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }), "Vollbild")
bind(mod .. " + V",         hl.dsp.window.float({ action = "toggle" }),        "Floating an/aus")
bind(mod .. " + CTRL + G",  hl.dsp.group.toggle(),                              "Tab-Gruppe an/aus")
bind(mod .. " + period",    hl.dsp.group.next(),                                "Gruppe: naechster Tab")
bind(mod .. " + comma",     hl.dsp.group.prev(),                                "Gruppe: vorheriger Tab")

-- Layout wechseln: scrolling <-> dwindle
bind(mod .. " + SHIFT + T", function()
    local cur = hl.get_config("general.layout")
    local new = (cur == "scrolling") and "dwindle" or "scrolling"
    hl.config({ general = { layout = new } })
    hl.exec_cmd("notify-send -t 1500 Layout " .. new)
end, "Layout: scrolling/dwindle")

-- Resize-Modus: SUPER+ALT+R, dann hjkl, Esc/Enter beendet
bind(mod .. " + ALT + R", hl.dsp.submap("resize"), "Resize-Modus")
hl.define_submap("resize", "escape", function()
    hl.bind("H", hl.dsp.window.resize({ x = -40, y = 0,  relative = true }), { repeating = true })
    hl.bind("L", hl.dsp.window.resize({ x = 40,  y = 0,  relative = true }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0,   y = -40, relative = true }), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 0,   y = 40,  relative = true }), { repeating = true })
    hl.bind("Return", hl.dsp.submap("reset"))
end)

-- Workspaces
for i = 1, 10 do
    local key = i % 10
    bind(mod .. " + " .. key,                hl.dsp.focus({ workspace = i }),         "Workspace " .. i)
    bind(mod .. " + CTRL + " .. key,         hl.dsp.window.move({ workspace = i }),   "Fenster auf Workspace " .. i)
    hl.bind(mod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end
bind(mod .. " + N",        hl.dsp.focus({ workspace = "empty" }),       "Neuer leerer Workspace")
bind(mod .. " + CTRL + N", hl.dsp.window.move({ workspace = "empty" }), "Fenster auf neuen Workspace")
bind(mod .. " + U", hl.dsp.focus({ workspace = "e+1" }), "Workspace runter")
bind(mod .. " + I", hl.dsp.focus({ workspace = "e-1" }), "Workspace hoch")
bind(mod .. " + CTRL + U", hl.dsp.window.move({ workspace = "e+1" }), "Fenster einen Workspace runter")
bind(mod .. " + CTRL + I", hl.dsp.window.move({ workspace = "e-1" }), "Fenster einen Workspace hoch")
bind(mod .. " + Tab", hl.dsp.focus({ workspace = "previous" }), "Letzter Workspace")

-- Scratchpad
bind(mod .. " + Y",       hl.dsp.workspace.toggle_special("scratch"),            "Scratchpad zeigen/verstecken")
bind(mod .. " + ALT + Y", hl.dsp.window.move({ workspace = "special:scratch" }), "Fenster ins Scratchpad")

-- Screenshots
bind(mod .. " + S",         run("hyprshot -m region --clipboard-only"),          "Screenshot Bereich -> Clipboard")
bind(mod .. " + SHIFT + S", run("hyprshot -m region -o ~/Pictures/Screenshots"), "Screenshot Bereich -> Datei")
bind(mod .. " + CTRL + S",  run("hyprshot -m output -o ~/Pictures/Screenshots"), "Screenshot Monitor -> Datei")

-- Game Mode: Animationen/Blur/Schatten/Gaps aus
local gamemode = false
bind(mod .. " + G", function()
    gamemode = not gamemode
    if gamemode then
        hl.config({
            animations = { enabled = false },
            decoration = { rounding = 0, blur = { enabled = false }, shadow = { enabled = false } },
            general    = { gaps_in = 0, gaps_out = 0 },
        })
    else
        hl.exec_cmd("hyprctl reload")
    end
    hl.exec_cmd("notify-send -t 1500 'Game Mode' " .. (gamemode and "an" or "aus"))
end, "Game Mode an/aus")

-- Audio/Medien (Buchstaben-Varianten + echte Medientasten)
local vol_up   = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
local vol_down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
local mute     = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
bind(mod .. " + ALT + K", run(vol_up),   "Lauter",     { locked = true, repeating = true })
bind(mod .. " + ALT + J", run(vol_down), "Leiser",     { locked = true, repeating = true })
bind(mod .. " + ALT + M", run(mute),     "Stumm",      { locked = true })
bind(mod .. " + ALT + P", run("playerctl play-pause"), "Play/Pause",  { locked = true })
bind(mod .. " + ALT + N", run("playerctl next"),       "Naechster Titel", { locked = true })
bind(mod .. " + ALT + B", run("playerctl previous"),   "Vorheriger Titel", { locked = true })
hl.bind("XF86AudioRaiseVolume", run(vol_up),   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", run(vol_down), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        run(mute),     { locked = true })
hl.bind("XF86AudioPlay",        run("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext",        run("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev",        run("playerctl previous"),   { locked = true })

-- Maus
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
