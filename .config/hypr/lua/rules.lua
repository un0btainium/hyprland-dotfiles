hl.window_rule({
    name  = "no-maximize-requests",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Gaming: Tearing fuer Steam/Proton, Wine (World of Tanks = *.exe), gamescope
hl.window_rule({
    name  = "games-immediate",
    match = { class = "^(steam_app_\\d+|gamescope|.*\\.exe)$" },
    immediate = true,
})

hl.window_rule({
    name  = "fullscreen-inhibits-idle",
    match = { class = ".*" },
    idle_inhibit = "fullscreen",
})

-- Floating-Dialoge
hl.window_rule({
    name  = "float-utils",
    match = { class = "^(pavucontrol|org\\.pulseaudio\\.pavucontrol|blueman-manager|nm-connection-editor|hyprpolkitagent|org\\.kde\\.polkit-kde-authentication-agent-1)$" },
    float = true,
})

hl.window_rule({
    name  = "float-steam-dialogs",
    match = { class = "^steam$", title = "^(Friends List|Steam Settings|Steam - News)$" },
    float = true,
})

hl.window_rule({
    name  = "pip",
    match = { title = "^Picture-in-Picture$" },
    float = true,
    pin   = true,
})

-- Blur hinter Bar, Launcher, Notifications
hl.layer_rule({
    name  = "blur-shell",
    match = { namespace = "^(waybar|rofi|notifications|logout_dialog)$" },
    blur = true,
    ignore_alpha = 0.3,
})
