local M = {}
local Config = require('config')

local function switch_colorscheme_if_needed(current_background)
  local current_config = Config.current()
  if current_config.mode ~= 'colorscheme' then
    return false
  end

  if current_background == 'dark' then
    vim.cmd({ cmd = 'colorscheme', args = { current_config.light_mode_colorscheme } })
  else
    vim.cmd({ cmd = 'colorscheme', args = { current_config.dark_mode_colorscheme } })
  end
end

local function toggle_background(current_background)
  if current_background == 'dark' then
    vim.go.background = 'light'
  else
    vim.go.background = 'dark'
  end
end

local function run_callbacks_if_needed(current_background)
  local current_config = Config.current()

  if current_config.mode ~= 'custom' then
    return false
  end

  if current_background == 'dark' then
    current_config.light_mode_callback()
  else
    current_config.dark_mode_callback()
  end
end

M.color_switch = function()
  local current_background = vim.go.background

  switch_colorscheme_if_needed(current_background)
  run_callbacks_if_needed(current_background)
  toggle_background(current_background)
end

M.setup = function(config)
  Config.load(config)

  local user_create_cmd = vim.api.nvim_create_user_command

  user_create_cmd("DarkLightSwitch", function() M.color_switch() end,
    { desc = "Switch between dark mode and light mode" })
end

return M
