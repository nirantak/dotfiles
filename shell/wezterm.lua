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
}

-- Events and statuses

-- Notify on password prompt
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
wezterm.on('update-status', function(window, pane)
  local ostype = pane:get_user_vars().OSTYPE or ''
  if ostype == "" then
    window:set_left_status(' ? ')
    return
  end

  if ostype:lower():find("^darwin") then
    window:set_left_status('  ')
  elseif ostype:lower():find("^linux") then
    window:set_left_status(' 🐧 ')
  else
    window:set_left_status(' ? ')
  end
end)

-- Set right status bar
wezterm.on('update-right-status', function(window, pane)
  local meta = pane:get_metadata() or {}

  -- Hostname based on OSC 7 https://wezfurlong.org/wezterm/shell-integration.html
  local cwd_uri = pane:get_current_working_dir()

  local cells = {}
  if cwd_uri then
    local cwd = ''
    local hostname = ''

    cwd = cwd_uri.file_path
    hostname = cwd_uri.host or wezterm.hostname()
    local dot = hostname:find '[.]'
    if dot then
      hostname = hostname:sub(1, dot - 1)
    end

    if hostname == '' then
      hostname = wezterm.hostname()
    end

    table.insert(cells, cwd)
    table.insert(cells, hostname)
  end

  -- The powerline < symbol
  local LEFT_ARROW = utf8.char(0xe0b3)
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  -- Color palette for the backgrounds of each cell
  local text_fg = '#c0c0c0'
  local colors = {
    '#3c1361',
    '#52307c',
    '#663a82',
    '#7c5295',
    '#b491c8',
  }

  -- Translate a cell into elements
  local elements = {}
  local num_cells = 0
  function push(text, is_last)
    local cell_no = num_cells + 1
    table.insert(elements, { Foreground = { Color = text_fg } })
    table.insert(elements, { Background = { Color = colors[cell_no] } })
    table.insert(elements, { Text = ' ' .. text .. ' ' })
    if not is_last then
      table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
      table.insert(elements, { Text = SOLID_LEFT_ARROW })
    end
    num_cells = num_cells + 1
  end

  while #cells > 0 do
    local cell = table.remove(cells, 1)
    push(cell, #cells == 0)
  end

  window:set_right_status(wezterm.format(elements))

  if meta.is_tardy then
    local seconds = meta.since_last_response_ms / 1000.0
    window:set_right_status(string.format('tardy: %5.1fs⏳', seconds))
  end
end)

--[[ User Config :: End ]]--

return config
