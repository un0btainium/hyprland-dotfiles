-- EurKEY auf dem HHKB. Ctrl liegt auf der Caps-Position.
-- lv3:ralt_switch macht Alt rechts zu AltGr: AltGr+a/o/u/s = ä/ö/ü/ß, AltGr+5 = €
hl.config({
    input = {
        kb_layout    = "eu",
        kb_variant   = "",
        kb_options   = "lv3:ralt_switch",
        repeat_rate  = 40,
        repeat_delay = 250,
        numlock_by_default = true,

        follow_mouse = 1,
        accel_profile = "flat",
        sensitivity   = 1.0,
    },

    binds = {
        workspace_back_and_forth = true,
        allow_workspace_cycles   = true,
        hide_special_on_workspace_change = true,
    },

    cursor = {
        hide_on_key_press = true,
        inactive_timeout  = 5,
    },
})

hl.device({
    name          = "logitech-pro-x-1",
    accel_profile = "flat",
    sensitivity   = 0.75,
})
