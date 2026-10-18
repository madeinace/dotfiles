local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

config.color_scheme = "rose-pine-moon"
config.font = wezterm.font_with_fallback({
  "Hack Nerd Font",
  "Noto Sans CJK SC",
})
config.font_size = 15.0
config.window_background_opacity = 0.8
config.macos_window_background_blur = 50
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

-- shell 只认 ALT+b/f 为按词移动，所以把 OPT+方向键映射过去
config.keys = {
  { key = "LeftArrow", mods = "OPT", action = act.SendKey({ key = "b", mods = "ALT" }) },
  { key = "RightArrow", mods = "OPT", action = act.SendKey({ key = "f", mods = "ALT" }) },
}

return config
