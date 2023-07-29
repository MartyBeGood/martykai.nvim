# 🫖 MonoNight Tasty 🍶

***🏗️ WIP 🚧***

A theme for Neovim written in Lua, based on the projects tokyonight.nvim and
vim-monokai-tasty with numerous custom adjustments. It includes additional
configurations for tmux, lualine, zathura and others.

## ***⚠️ Disclaimer***
 
> This project is mainly for personal use.

## 🌙 Default

![image](https://user-images.githubusercontent.com/292349/190951628-10ba28a1-57ff-4479-8eab-47400a402242.png)

## ☀️ Light

![image](https://user-images.githubusercontent.com/292349/115996270-78c6c480-a593-11eb-8ed0-7d1400b058f5.png)

## ✨ Features

- Supports the latest [Neovim](https://github.com/neovim/neovim)
  [0.9.0](https://github.com/neovim/neovim/releases/tag/v0.9.0) features.
- Enhances terminal colors.
- Introduces a darker background option for sidebar-like windows.
- Supports all major plugins.
- Provides [mononight-tasty](https://github.com/folke/tokyonight.nvim)
  [extras](#-extras) for numerous other applications.

### 🐧 Extras

<!-- extras:start -->
- [GitUI](https://github.com/extrawurst/gitui) ([gitui](extras/gitui))
- [Tmux](https://github.com/tmux/tmux/wiki) ([tmux](extras/tmux))
- [Xresources](https://wiki.archlinux.org/title/X_resources) ([xresources](extras/xresources))
- [Zathura](https://pwmt.org/projects/zathura/) ([zathura](extras/zathura))
<!-- extras:end -->

## ⚡️ Requirements

- [Neovim](https://github.com/neovim/neovim) >=
  [0.9.0](https://github.com/neovim/neovim/releases/tag/v0.9.0)

## 📦 Installation

Install with your package manager:

```lua
-- Lazy
{
  "polirritmico/mononight-tasty.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
}
```

## 🕹️ Usage

### [Lua](https://www.lua.org)

```lua
vim.cmd[[colorscheme mononight-tasty]]
```

### External Plugins

#### [Lualine](https://github.com/nvim-lualine/lualine.nvim)

```lua
require('lualine').setup {
  options = {
    -- ...
    theme = 'mononight-tasty'
    -- ...
  }
}
```

## ⚙️ Configuration

> ❗️ Set the configuration **BEFORE** loading the color scheme with `colorscheme mononight-tasty`.

The [day](#day) style is used when `{ style = "day" }` is passed to
`setup(options)` or when `vim.o.background = "light"` is setted.

[Mononight](https://github.com/polirritmico/mononight-tasty.nvim) uses the
default options, unless `setup` is explicitly called.

```lua
require("mononight-tasty").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  light_style = "day", -- The theme is used when the background is set to light
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,
})
```

## 🍜 Overriding Colors & Highlight Groups

How the highlight groups are calculated:

1. `colors` are determined based on your configuration, with the ability to
   override them using `config.on_colors(colors)`.
1. These `colors` are utilized to generate the highlight groups.
1. `config.on_highlights(highlights, colors)` can be used to override highlight
   groups.

For default values of `colors` and `highlights`, please consult the
[default](extras/lua/mononight_tasty.lua), and
[day](extras/lua/mononight_tasty_day.lua) themes.

### Settings and color alteration demonstration

```lua
require("mononight-tasty").setup({
  -- use the day style
  style = "day",
  -- disable italic for functions
  styles = {
    functions = {}
  },
  sidebars = { "qf", "vista_kind", "terminal", "packer" },
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  on_colors = function(colors)
    colors.hint = colors.orange
    colors.error = "#ff0000"
  end
})
```

### [Borderless Telescope](https://github.com/nvim-telescope/telescope.nvim/wiki/Gallery#borderless) example

```lua
require("mononight-tasty").setup({
  on_highlights = function(hl, c)
    local prompt = "#2d3149"
    hl.TelescopeNormal = {
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    hl.TelescopeBorder = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopePromptNormal = {
      bg = prompt,
    }
    hl.TelescopePromptBorder = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopePromptTitle = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopePreviewTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopeResultsTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
  end,
})
```

### Fix `undercurls` in [Tmux](https://github.com/tmux/tmux)

To have undercurls show up and in color, add the following to your
[Tmux](https://github.com/tmux/tmux) configuration file:

```sh
# Undercurl
set -g default-terminal "${TERM}"
set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
```

## 🍭 Extras

Extra color configs for [Kitty](https://sw.kovidgoyal.net/kitty/conf.html),
[Alacritty](https://github.com/alacritty/alacritty),
[Fish](https://www.lua.org/), [WezTerm](https://wezfurlong.org/wezterm/config/),
[iTerm](https://iterm2.com/) and [foot](https://codeberg.org/dnkl/foot) can be
found in [extras](extras/). To use them, refer to their respective
documentation.

![image](https://user-images.githubusercontent.com/292349/115395546-d8d6f880-a198-11eb-98fb-a1194787701d.png)

You can easily use the color palette for other plugins inside your
[Neovim](https://github.com/neovim/neovim) configuration:

```lua
local colors = require("mononight-tasty.colors").setup() -- pass in any of the config options as explained above
local util = require("mononight-tasty.util")

aplugin.background = colors.bg_dark
aplugin.my_error = util.lighten(colors.red1, 0.3) -- number between 0 and 1. 0 results in white, 1 results in red1
```

