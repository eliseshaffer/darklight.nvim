M = {}

BackgroundStrategy = {}
ColorschemeStrategy = {}
CustomStrategy = {}

function BackgroundStrategy.switch(_)
  local current_background = vim.go.background

  if current_background == "dark" then
    vim.go.background = "light"
  else
    vim.go.background = "dark"
  end
end

function ColorschemeStrategy.switch(config)
  local current_background = vim.go.background

  if current_background == "dark" then
    vim.cmd({ cmd = 'colorscheme', args = { config.light_mode_colorscheme } })
    vim.go.background = "light"
  else
    vim.cmd({ cmd = 'colorscheme', args = { config.dark_mode_colorscheme } })
    vim.go.background = "dark"
  end
end

function CustomStrategy.switch(config)
  local current_background = vim.go.background

  if current_background == 'dark' then
    config.light_mode_callback()
    vim.go.background = "light"
  else
    config.dark_mode_callback()
    vim.go.background = "dark"
  end
end

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
