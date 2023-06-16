local ColorschemeStrategy = {}

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

return ColorschemeStrategy
