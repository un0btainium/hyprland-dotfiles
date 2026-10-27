-- Drei Monitore, DP-2 ist die Mitte
hl.monitor({ output = "DP-1", mode = "2560x1440@240", position = "0x0",    scale = 1 })
hl.monitor({ output = "DP-2", mode = "2560x1440@240", position = "2560x0", scale = 1 })
hl.monitor({ output = "DP-3", mode = "2560x1440@240", position = "5120x0", scale = 1 })
hl.monitor({ output = "",     mode = "preferred",     position = "auto",   scale = 1 })

-- Keine festen Workspace-Regeln: Workspaces entstehen dynamisch, leere verschwinden wieder.
-- Neue bekommen die naechste freie Nummer (Super+N), siehe binds.lua.
