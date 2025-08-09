local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Font Settings
config.font_size = 12
config.font = wezterm.font("JetBrains Mono Nerd Font")

-- Colors
config.color_scheme = "Catppuccin Frappe"

-- Other Configurations
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

config.keys = {
    {
        key = 'e',
        mods = 'CTRL',
        action = wezterm.action.SpawnCommandInNewTab {
            args = { "nvim" },
        }
    },
    {
        key = 'q',
        mods = 'CTRL',
        action = wezterm.action.SpawnCommandInNewTab {
            args = { "zellij" },
        }
    }
}

return config
