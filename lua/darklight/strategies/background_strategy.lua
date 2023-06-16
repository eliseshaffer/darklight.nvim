local BackgroundStrategy = {}

function BackgroundStrategy.switch(_)
  local current_background = vim.go.background

  if current_background == "dark" then
    vim.go.background = "light"
  else
    vim.go.background = "dark"
  end
end

return BackgroundStrategy
