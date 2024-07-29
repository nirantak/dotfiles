-- Reference: https://wezfurlong.org/wezterm/config/lua/config

local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

--[[ User Config :: Start ]]--

-- See logs by pressing the key binding for ShowDebugOverlay
-- or in ~/.local/share/wezterm/wezterm*

-- Afterglow, Andromeda, Apprentice (Gogh), One Dark (Gogh), OneHalfDark
config.color_scheme = 'Andromeda'
config.font = wezterm.font 'JetBrains Mono'
-- List fonts with: `wezterm ls-fonts --list-system`
config.font_size = 14
config.window_background_opacity = 0.95
config.inactive_pane_hsb = {saturation = 0.5, brightness = 0.5}

config.default_cursor_style = 'SteadyBar'
config.initial_cols = 80
config.initial_rows = 20
config.enable_scroll_bar = true
config.use_fancy_tab_bar = false

config.pane_focus_follows_mouse = true
config.window_close_confirmation = 'AlwaysPrompt'
config.scrollback_lines = 50000
config.status_update_interval = 1000

-- List all keys with: `wezterm show-keys --lua`
config.leader = { key = 'Space', mods = 'CMD|SHIFT' }
config.keys = {
  { key = 'P', mods = 'CMD|SHIFT', action = act.ActivateCommandPalette },
  { key = 'f', mods = 'CMD', action = act.Search 'CurrentSelectionOrEmptyString' },
  { key = 'k', mods = 'CMD', action = act.ClearScrollback 'ScrollbackAndViewport' },
  { key = 'K', mods = 'CMD|SHIFT', action = act.Multiple {
    act.ClearScrollback 'ScrollbackAndViewport',
    act.SendKey{ key = 'L', mods = 'CTRL' },
  }},
  { key = 'L', mods = 'CMD|SHIFT', action = act.ShowDebugOverlay },
  { key = 'Enter', mods = 'CMD|SHIFT', action = act.TogglePaneZoomState },
  { key = '%', mods = 'CTRL|SHIFT', action = act.SplitHorizontal{domain = 'CurrentPaneDomain'} },
  { key = 'd', mods = 'CMD', action = act.SplitHorizontal{domain = 'CurrentPaneDomain'} },
  { key = '\"', mods = 'CTRL|SHIFT', action = act.SplitVertical{domain = 'CurrentPaneDomain'} },
  { key = 'D', mods = 'CMD|SHIFT', action = act.SplitVertical{domain = 'CurrentPaneDomain'} },
  { key = 'LeftArrow', mods = 'OPT', action = act{SendString='\x1bb'} },
  { key = 'RightArrow', mods = 'OPT', action = act{SendString='\x1bf'} },
  { key = 'C', mods = 'CMD|SHIFT', action = act.ActivateCopyMode },
}

local copy_mode = nil
local custom_copy_mode = {
  { key = 'c', mods = 'NONE', action = act.CopyMode{SetSelectionMode = 'Cell'} },
  { key = 'w', mods = 'NONE', action = act.CopyMode{SetSelectionMode = 'Word'} },
  { key = 'l', mods = 'NONE', action = act.CopyMode{SetSelectionMode = 'Line'} },
  { key = 'b', mods = 'NONE', action = act.CopyMode{SetSelectionMode = 'Block'} },
}

if wezterm.gui then
  copy_mode = wezterm.gui.default_key_tables().copy_mode
  for _, v in ipairs(custom_copy_mode) do
    table.insert(copy_mode, v)
  end
end

config.key_tables = {
  copy_mode = copy_mode,
}

-- Events and statuses
local colors = wezterm.color.get_builtin_schemes()[config.color_scheme]

-- Notify on password prompt (does not work over SSH yet)
wezterm.on('update-status', function(window, pane)
  local meta = pane:get_metadata() or {}
  local overrides = window:get_config_overrides() or {}

  if meta.password_input then
    overrides.color_scheme = 'Red Alert'
    -- window:toast_notification('wezterm', 'Enter password!', nil, 5000)
  else
    overrides.color_scheme = nil
  end
  window:set_config_overrides(overrides)
end)

-- Set left status bar
--[[
For it to work over ssh, you need to emit the OSTYPE environment variable
as a OSC 1337 escape sequence in your remote shell
like: https://github.com/nirantak/dotfiles/blob/3fd6698d80628a9a24fad765b0dd8dc479c6abb8/shell/.bashrc#L144
]]--
wezterm.on('update-status', function(window, pane)
  local ostype = pane:get_user_vars().OSTYPE or ''
  ostype = ostype:lower()
  local elements = {
    { Foreground = { Color = colors.foreground } },
    { Background = { Color = colors.ansi[5] } },
  }

  if ostype == "" then
    table.insert(elements, { Text = ' ? ' })
  elseif ostype:find("^darwin") then
    table.insert(elements, { Text = '  ' })
  elseif ostype:find("^linux") then
    table.insert(elements, { Text = ' 🐧' })
  else
    table.insert(elements, { Text = ' ? ' })
  end

  window:set_left_status(wezterm.format(elements))
end)

-- Set right status bar
--[[
For it to work over ssh, you need to add the shell integration in your remote shell
- https://github.com/wez/wezterm/blob/main/assets/shell-integration/wezterm.sh
- https://wezfurlong.org/wezterm/shell-integration.html
requires powerline-fonts installed
]]--
wezterm.on('update-right-status', function(window, pane)
  local meta = pane:get_metadata() or {}

  local LEFT_ARROW = utf8.char(0xe0b3)
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  local cwd_uri = pane:get_current_working_dir()
  if not cwd_uri then
    return
  end

  local hostname = cwd_uri.host or wezterm.hostname()
  local hostname_color = colors.ansi[5]

  if hostname:find("corp.") then
    hostname_color = colors.ansi[3]
  elseif hostname:find("prod.") then
    hostname_color = colors.ansi[2]
  end
  hostname = hostname:gsub("%.%w*%.%w*$", "")

  -- wezterm.log_info('cwd_uri: ', cwd_uri, ' parsed hostname: ', hostname)
  -- wezterm.log_info(config.color_scheme, ' colors: ', colors.background, colors.foreground)

  local elements = {
    -- File path
    { Foreground = { Color = colors.background } },
    { Text = SOLID_LEFT_ARROW },
    { Foreground = { Color = colors.foreground } },
    { Background = { Color = colors.background } },
    { Text = ' ' .. cwd_uri.file_path .. ' ' },

    -- Hostname with top 2 levels of domain segments removed
    { Foreground = { Color = hostname_color } },
    { Text = SOLID_LEFT_ARROW },
    { Foreground = { Color = colors.foreground } },
    { Background = { Color = hostname_color } },
    { Text = ' ' .. hostname .. ' ' },
  }

  window:set_right_status(wezterm.format(elements))

  if meta.is_tardy then
    local seconds = meta.since_last_response_ms / 1000.0
    window:set_right_status(string.format('tardy: %5.1fs⏳', seconds))
  end
end)

--[[ User Config :: End ]]--

return config
