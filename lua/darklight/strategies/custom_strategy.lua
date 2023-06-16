local CustomStrategy = {}

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

return CustomStrategy

