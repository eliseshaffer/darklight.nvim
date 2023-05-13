local M = {}

-- utilities
local function merge(t1, t2)
    for k, v in pairs(t2) do
        if (type(v) == "table") and (type(t1[k] or false) == "table") then
            merge(t1[k], t2[k])
        else
            t1[k] = v
        end
    end
    return t1
end

local function toggle_background()
  local currentColor = vim.go.background
  if currentColor == 'dark' then 
    vim.go.background = 'light'
  else
    vim.go.background = 'dark'
  end
end

local Config = {
  mode = 'background',
  light_mode_callback = toggle_background,
  dark_mode_callback = toggle_background,
}

local function set_colorscheme_callbacks()
  if Config.mode == 'colorscheme' then
    Config.light_mode_callback = function() 
      vim.api.nvim_exec("colorscheme " .. Config.light_mode_colorscheme, false)
    end
    Config.dark_mode_callback = function() 
      vim.api.nvim_exec("colorscheme " .. Config.dark_mode_colorscheme, false)
    end
  end
end

local function validate_config(config)
  if config.mode == 'background' then
    return true
  elseif config.mode == 'colorscheme' then
    if config.light_mode_colorscheme == nil then
      error("DarkLight: option light_mode_colorscheme is required for colorscheme mode\nFalling back to background mode")
    end
    if config.dark_mode_colorscheme == nil then
      error("DarkLight: option dark_mode_colorscheme is required for colorscheme mode\nFalling back to background mode")
    end
  elseif config.mode == 'custom' then
    if config.light_mode_callback == nil then
      error("DarkLight: option light_mode_callback is required for custom mode\nFalling back to background mode")
    end
    if config.dark_mode_callback == nil then
      error("DarkLight: option dark_mode_callback is required for custom mode\nFalling back to background mode")
    end
  else
    error("DarkLight: invalid option `mode`; Falling back to background mode")
  end
end

-- Public API

M.color_switch = function()
  local currentColor = vim.go.background
  if currentColor == 'dark' then
    Config.light_mode_callback()
  else
    Config.dark_mode_callback()
  end
end

M.setup = function(config)
  if pcall(function() validate_config(config) end)then 
    merge(Config, config)
    set_colorscheme_callbacks()
  else
    return
  end
end

return M
