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

This is the default mode and requires no arguments to the setup function:

```lua
require('darklight').setup()
```


### colorscheme
In colorscheme mode, Darklight switches between the colorschemes provided
in the `light_mode_colorscheme` and `dark_mode_colorscheme` options. 

In this mode, `light_mode_colorscheme` and `dark_mode_colorscheme` are
REQUIRED.

```lua
require('darklight').setup({
  mode = 'colorscheme', -- Sets darklight to colorscheme mode
  light_mode_colorscheme = 'shine', -- Sets the colorscheme to use for light mode
  dark_mode_colorscheme = 'elflord', -- Sets the colorscheme to use for dark mode
})
```

> :warning: Darklight uses `vim.go.background` to know what mode you are
> currently in. Because of this, it sets the background to `"light"` and
> `"dark"` after each callback. This may cause issues if you use two dark
> or two light colorschemes with Darklight.

### custom
Custom mode allows you to completely control what happens when you switch
modes by letting you supply callback functions to call when switching.
This mode is most useful if you use a theme that provides its own
switching functionality or if you need to set multiple themes(e.g. if you
use a statusline plugin that manages its own themes and need to set 
that as well.)

In this mode `light_mode_callback` and `dark_mode_callback` are REQUIRED.

```lua
require('darklight').setup({
  mode = 'custom', -- Sets darklight to custom mode
  light_mode_callback = function() -- Function to call to set light mode
    ... -- your light mode switch code goes here
  end,
  dark_mode_callback = function() -- Function to call to set dark mode
    ... -- your dark mode switch code goes here
  end,
})
```

Here's a more concrete example of custom mode from my own dotfiles: 

```lua
require('darklight').setup({
  mode = 'custom',
  light_mode_callback = function()
    require('material.functions').change_style("lighter") 
  end,
  dark_mode_callback = function()
    require('material.functions').change_style("palenight")
  end
})
```

In this example, [material.nvim](https://github.com/marko-cerovac/material.nvim) provides it own style switching and
I call those functions from within my callbacks.

## Usage

### Switching between modes

Use the `DarkLightSwitch` command to switch between dark and light mode: 

```
:DarkLightSwitch
```

You can also map to a keymap for quick access. Here's an example of how to do that:

```lua
local key = vim.api.nvim_set_keymap
key('n', '<leader>dl', ":DarkLightSwitch<CR>", { noremap = true })
```

### Updating configuration

You can update the configuration by calling the `update()` function and
passing a new configuration. 

```lua
require('darklight').update({
  mode = 'colorscheme', -- Sets darklight to colorscheme mode
  light_mode_colorscheme = 'shine', -- Sets the colorscheme to use for light mode
  dark_mode_colorscheme = 'elflord', -- Sets the colorscheme to use for dark mode
})
```

If there are any validation errors, Darklight will fall back to the
previous configuration.

> :warning: This will only work if you have called setup. Calling this function by
> itself will not create the commands and Darklight will be unable to switch
> between modes. 

## Notes

Darklight will fallback gracefully to "background" mode if the configuration is not correct for
the other modes.

