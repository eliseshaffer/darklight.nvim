<div align="center">


##  darklight.nvim
A dark mode / light mode switcher for Neovim.

</div>

## Installation


## Setup

```lua
require('darklight').setup({
  mode = 'background', -- Sets the mode for switching. Must be one of background(default) | colorscheme | custom
  light_mode_colorscheme = nil, -- Sets the colorscheme to switch to for light mode when in "colorscheme" mode
  dark_mode_colorscheme = nil, -- Sets the colorscheme to switch to for dark mode when in "colorscheme" mode
  light_mode_callback = function() -- Function to call to set light mode in "custom" mode
    vim.go.background = 'light'
  end,
  dark_mode_callback = function() -- Function to call to set dark mode in "custom" mode
    vim.go.background = 'dark'
  end,
})
```

## Fallbacks

This plugin will fallback gracefully to "background" mode if the configuration is not correct for
the other modes.
