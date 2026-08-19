

-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
local act = wezterm.action

-- This is where you actually apply your config choices.

config.initial_cols = 100
config.initial_rows = 28

config.font_size = 16
-- config.font = wezterm.font 'Maple Mono NF'
config.color_scheme = 'Catppuccin Mocha'
config.default_cursor_style = 'BlinkingBar'
config.enable_scroll_bar = true

if wezterm.target_triple:find("windows") then
  config.default_prog = { 'C:/Users/kokic/packages/multiple/nu/nu.exe' }
end

if wezterm.target_triple:find("darwin") then
  config.default_prog = { '/opt/homebrew/bin/nu' }
end

config.window_frame = {
  -- font = wezterm.font 'Roboto',
  font_size = 15,
}

config.tab_max_width = 40
config.use_fancy_tab_bar = true

-- Smart copy, also see: https://github.com/wezterm/wezterm/discussions/2426
config.keys = {
    {
      key = 'c',
      mods = 'CTRL',
      action = wezterm.action_callback(function(window, pane)
        local sel = window:get_selection_text_for_pane(pane)
        if (not sel or sel == '') then
          window:perform_action(wezterm.action.SendKey{ key='c', mods='CTRL' }, pane)
        else
          window:perform_action(wezterm.action{ CopyTo = 'ClipboardAndPrimarySelection' }, pane)
        end
      end),
    },
    { key = 'v', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard' },
    { key = 'v', mods = 'SHIFT|CTRL', action = wezterm.action_callback(function(window, pane)
      window:perform_action(wezterm.action.SendKey{ key='v', mods='CTRL' }, pane) end),
    },
    { key = 'V', mods = 'SHIFT|CTRL', action = wezterm.action_callback(function(window, pane)
      window:perform_action(wezterm.action.SendKey{ key='v', mods='CTRL' }, pane) end),
    },
    { key = 'c', mods = 'ALT', action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection' },
    { key = 'v', mods = 'ALT', action = wezterm.action.PasteFrom 'Clipboard' },
}

-- Finally, return the configuration to wezterm:
return config


