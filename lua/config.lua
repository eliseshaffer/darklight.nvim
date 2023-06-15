local M = {}

local Config = {
  mode = 'background',
  dark_mode_callback = function() end,
  light_mode_callback = function() end,
}

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

M.load = function(new_config)
  if pcall(function() validate_config(new_config) end) then
    merge(Config, new_config)
  end
end

M.current = function()
  return Config
end

return M
