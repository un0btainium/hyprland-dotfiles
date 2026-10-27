-- Look: cleanes dunkles Tiling, duenner Verlaufsrand, weicher schwarzer Schatten, kein Glow.
-- Farben: Catppuccin Mocha (pink f5c2e7, mauve cba6f7, blue 89b4fa)
hl.config({
    general = {
        gaps_in  = 3,
        gaps_out = 0,
        border_size = 2,
        col = {
            active_border   = { colors = { "rgba(f5c2e7ff)", "rgba(cba6f7ff)" }, angle = 45 },
            inactive_border = "rgba(313244ff)",
        },
        resize_on_border        = true,
        extend_border_grab_area = 15,
        allow_tearing = true,
        layout = "scrolling",
    },

    decoration = {
        rounding       = 0,
        active_opacity   = 1.0,
        inactive_opacity = 0.95,

        shadow = {
            enabled        = true,
            range          = 18,
            render_power   = 4,
            offset         = "0 6",
            color          = "rgba(00000070)",
            color_inactive = "rgba(00000030)",
        },
        glow = { enabled = false },

        blur = {
            enabled  = true,
            size     = 6,
            passes   = 3,
            noise    = 0.01,
            vibrancy = 0.17,
            popups   = true,
        },
    },

    group = {
        col = {
            border_active   = { colors = { "rgba(f5c2e7ff)", "rgba(cba6f7ff)" }, angle = 45 },
            border_inactive = "rgba(313244ff)",
        },
    },

    dwindle   = { preserve_split = true },
    scrolling = {
        column_width             = 0.5,
        explicit_column_widths   = "0.333, 0.5, 0.667, 1.0",
        fullscreen_on_one_column = true,
        follow_focus             = true,
    },

    misc = {
        vrr = 2,   -- nur im Vollbild
        force_default_wallpaper  = 0,
        disable_hyprland_logo    = true,
    },

    render = { direct_scanout = 2 },
    xwayland = { force_zero_scaling = true },
})

-- Animationen: federnde Fenster, weiches Ausblenden, Workspaces rutschen
hl.curve("easeOutQuint", { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
hl.curve("linear",       { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("quick",        { type = "bezier", points = { {0.15, 0}, {0.1, 1} } })
hl.curve("pop",          { type = "spring", mass = 1, stiffness = 260, dampening = 22 })

hl.animation({ leaf = "global",           enabled = true, speed = 10,  bezier = "default" })
hl.animation({ leaf = "windows",          enabled = true, speed = 4.8, spring = "pop" })
hl.animation({ leaf = "windowsIn",        enabled = true, speed = 4.1, spring = "pop", style = "popin 85%" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 2,   bezier = "quick", style = "popin 85%" })
hl.animation({ leaf = "fade",             enabled = true, speed = 3,   bezier = "quick" })
hl.animation({ leaf = "border",           enabled = true, speed = 5,   bezier = "easeOutQuint" })
hl.animation({ leaf = "layers",           enabled = true, speed = 4,   bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",         enabled = true, speed = 4,   bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",        enabled = true, speed = 2,   bezier = "linear",       style = "fade" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 4,   bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4,   bezier = "easeOutQuint", style = "slidefadevert" })
