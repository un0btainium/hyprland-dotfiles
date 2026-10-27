-- Sakura Night - Hyprland 0.56 (Lua)
-- Teilmodule: ~/.config/hypr/lua/*.lua
local base = os.getenv("HOME") .. "/.config/hypr/lua/"
package.path = base .. "?.lua;" .. package.path

require("env")
require("monitors")
require("look")
require("input")
require("rules")
require("binds")
require("autostart")
