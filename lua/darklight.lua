local M = {}
local Config = require('config')

M.color_switch = function()
  local currentColor = vim.go.background
  if currentColor == 'dark' then
    Config.current().light_mode_callback()
    vim.go.background = 'light'
  else
    Config.current().dark_mode_callback()
    vim.go.background = 'dark'
  end
end

M.setup = function(config)
  Config.load(config)

  local user_create_cmd = vim.api.nvim_create_user_command

  user_create_cmd("DarkLightSwitch", function() M.color_switch() end, { desc = "Switch between dark mode and light mode" })
end

return M
