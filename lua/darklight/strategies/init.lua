local M = {}
local BackgroundStrategy = require('darklight.strategies.background_strategy')
local ColorschemeStrategy = require('darklight.strategies.colorscheme_strategy')
local CustomStrategy = require('darklight.strategies.custom_strategy')

function M.strategy_for(config)
  if config.mode == "background" then
    return BackgroundStrategy
  elseif config.mode == "colorscheme" then
    return ColorschemeStrategy
  elseif config.mode == "custom" then
    return CustomStrategy
  end
end

return M
