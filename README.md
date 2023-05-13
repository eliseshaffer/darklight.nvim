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
> doesn't set the vim background, you'll have to use custom mode and
> change the colorscheme and manually set `vim.go.background` in each
> callback

```lua
require('darklight').setup({
  mode = 'colorscheme', -- Sets darklight to colorscheme mode
  light_mode_colorscheme = 'shine', -- Sets the colorscheme to use for light mode
  dark_mode_colorscheme = 'elflord', -- Sets the colorscheme to use for dark mode
})
```

### custom
Custom mode allows you to completely control what happens when you switch
modes by letting you supply callback functions to call when switching.
This mode is most useful if you use a theme that provides its own
switching functionality or if you need to set multiple themes(e.g. if you
use airline and need to set the airline theme as well. 

In this mode `light_mode_callback` and `dark_mode_callback` are required.

> :warning: Darklight uses the vim background to know which mode you're
> currently in. Because of this, your callbacks MUST set `vim.go.background`
> to `"dark"` or `"light"` appropriately. This is something I might
> improve in the future.
```lua
require('darklight').setup({
  mode = 'custom', -- Sets darklight to custom mode
  light_mode_callback = function() -- Function to call to set light mode
    ... -- your light mode switch code goes here
    vim.go.background = 'light'
  end,
  dark_mode_callback = function() -- Function to call to set dark mode
    ... -- your dark mode switch code goes here
    vim.go.background = 'dark'
  end,
})
```

Here's a more concrete example of custom mode from my own dotfiles: 

```lua
require('darklight').setup({
  mode = 'custom',
  light_mode_callback = function()
    require('material.functions').change_style("lighter") 
    vim.go.background = 'light'
  end,
  dark_mode_callback = function()
    require('material.functions').change_style("palenight")
    vim.go.background = 'dark'
  end
})
```

In this example, [material.nvim](https://github.com/marko-cerovac/material.nvim) provides it own style switching and
I call those functions from within my callbacks.

## Fallbacks

Darklight will fallback gracefully to "background" mode if the configuration is not correct for
the other modes.
