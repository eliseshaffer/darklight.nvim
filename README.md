<div align="center">

##  darklight.nvim
A dark mode / light mode switcher for Neovim.

</div>

## Installation

Install using your favorite neovim package manager:

### Packer
```lua
use { 'eliseshaffer/darklight.nvim' }
```

## Setup

Darklight supports three modes:

### background
In background mode, darklight will only change the vim background. This is
useful if you use a colorscheme with different color palettes based on the
vim background.

This is the default mode and requires you to only call the setup function:

```lua
require('darklight').setup()
```


### colorscheme
In colorscheme mode, Darklight switches between the colorschemes provided
in the `light_mode_colorscheme` and `dark_mode_colorscheme` options. Both
options are required in this mode.

> :warning: This mode assumes that each colorscheme sets the vim background
> appropriately. It DOES NOT set the vim background itself. If your colorscheme
> doesn't set the vim background, you'll have to use custom mode.

```lua
require('darklight').setup({
  mode = 'colorscheme', -- Sets darklight to colorscheme mode
  light_mode_colorscheme = 'shine', -- Sets the colorscheme to use for light mode
  dark_mode_colorscheme = 'elflord', -- Sets the colorscheme to use for dark mode
})
```

### custom
Custom mode allows you to completely control what happens when you switch
modes by letting you supply callback functions to call when swithing. In
this mode `light_mode_callback` and `dark_mode_callback` are required.

```lua
require('darklight').setup({
  mode = 'custom', -- Sets darklight to custom mode
  light_mode_callback = function() -- Function to call to set light mode
    vim.go.background = 'light'
  end,
  dark_mode_callback = function() -- Function to call to set dark mode
    vim.go.background = 'dark'
  end,
})
```
## Fallbacks

Darklight will fallback gracefully to "background" mode if the configuration is not correct for
the other modes.
