local wezterm = require 'wezterm'
local mux = wezterm.mux

local config = wezterm.config_builder()

config.font = wezterm.font('FiraCode Nerd Font')
-- config.color_scheme = 'Rouge 2'
-- config.color_scheme = 'Rosé Pine (Gogh)'
-- config.color_scheme = 'rose-pine-moon'
-- config.color_scheme = 'Rosé Pine Moon (base16)'

-- Define the Windows Terminal Rosé Pine Moon palette mapping
config.colors = {
    foreground    = '#e0def4',
    background    = '#232136',
    cursor_bg     = '#59546d',
    cursor_fg     = '#e0def4',
    cursor_border = '#59546d',

    -- Text selection colors
    selection_bg  = '#393552',
    selection_fg  = '#e0def4',

    -- ANSI Escape Colors (Matched to Windows Terminal spec)
    ansi          = {
        '#393552', -- black (Overlay)
        '#eb6f92', -- red (Love)
        '#3e8fb0', -- green (Pine)
        '#f6c177', -- yellow (Gold)
        '#9ccfd8', -- blue (Foam)
        '#c4a7e7', -- magenta (Iris)
        '#ea9a97', -- cyan (Rose)
        '#e0def4', -- white (Text)
    },

    brights       = {
        '#6e6a86', -- bright black (Muted)
        '#eb6f92', -- bright red
        '#3e8fb0', -- bright green
        '#f6c177', -- bright yellow
        '#9ccfd8', -- bright blue
        '#c4a7e7', -- bright magenta
        '#ea9a97', -- bright cyan
        '#e0def4', -- bright white
    },

    -- Native Tab Bar Styling to blend with Moon aesthetics
    tab_bar       = {
        background = '#232136',
        active_tab = {
            bg_color = '#2a273f', -- Surface
            fg_color = '#e0def4', -- Text
        },
        inactive_tab = {
            bg_color = '#232136', -- Base
            fg_color = '#6e6a86', -- Muted
        },
        inactive_tab_hover = {
            bg_color = '#393552', -- Overlay
            fg_color = '#e0def4',
        },
        new_tab = {
            bg_color = '#232136',
            fg_color = '#e0def4',
        },
        new_tab_hover = {
            bg_color = '#393552',
            fg_color = '#e0def4',
        },
    },
}
config.font_size = 14.0

config.default_domain = 'WSL:Ubuntu'

config.window_padding = {
    left = 10,
    right = 10,
    top = 8,
    bottom = 8,
}
config.ssh_domains = {
    {
        name = 'WSL-SSH',
        remote_address = '127.0.0.1:22',
        username = 'jather',
        multiplexing = 'None',
    },
}
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

config.window_background_opacity = 1.0

config.default_cursor_style = 'SteadyBar'

return config
