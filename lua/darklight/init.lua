local M = {}
local Config = require('darklight.config')
local strategies = require('darklight.strategies')

M.color_switch = function()
  local current_config = Config.current()

  local strategy = strategies.strategy_for(current_config)
  strategy.switch(current_config)
end

M.setup = function(config)
  Config.load(config)

  local user_create_cmd = vim.api.nvim_create_user_command

  user_create_cmd("DarkLightSwitch", function() M.color_switch() end,
    { desc = "Switch between dark mode and light mode" })
end

M.update = function(config)
  Config.load(config)
end

return M
