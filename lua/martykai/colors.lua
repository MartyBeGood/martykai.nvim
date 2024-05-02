local util = require("martykai.util")

local M = {}

---@class Palette
M.default = {
  none = "NONE",

  -- Base colors
  blue = "#62d8f1",
  blue_alt = "#0087ff",
  green = "#a4e400",
  green_alt = "#83dc78",
  green_unchanged = "#a4e400",
  magenta = "#e34481",
  orange = "#ff9700",
  purple = "#af87ff",
  yellow = "#ffff87",
  yellow_alt = "#f6f557",
  red = "#eb5247",

  -- Neutrals
  black = "#000001", -- #000000 could change to transparent
  charcoal = "#262626",
  charcoal_medium = "#2b2b2b",
  charcoal_light = "#313131",
  grey_darker_alt = "#3e3e3e",
  grey_darker = "#444444",
  grey_dark = "#4b4b4b",
  grey_medium = "#585858",
  grey = "#8a8a8a",
  grey_light = "#bcbcbc",
  grey_lighter = "#e8e8e8",
  white = "#ffffff",

  -- Functionals
  bg_darker = "#121212",
  bg_dark = "#1e1e1e",
  bg = "#2b2b2b",
  fg_gutter = "#3e3e3e",
  terminal_black = "#444444",
  comment = "#8a8a8a",
  fg_dark = "#e6e6e6",
  fg = "#ffffff",

  -- Extra colors
  git = {
    add = "#a4e400",
    change = "#ff9700",
    delete = "#eb5247",
  },
}

---@type Palette
M.light_palette = {
  -- Base colors
  blue = "#0043c3",
  green = "#207000",
  green_alt = "#30a000",
  magenta = "#d0325c",
  orange = "#cf3000",
  purple = "#6054d0",
  yellow = "#df6f00",

  -- Neutrals (inverted)
  grey_lighter = "#171717",
  grey_light = "#4c4c4c",
  grey = "#7f7f7f",
  grey_medium = "#a5a5a5",
  grey_dark = "#b2b2b2",
  grey_darker = "#bfbfbf",
  grey_darker_alt = "#c9c9c9",
  charcoal_medium = "#dedede",
  charcoal_light = "#d8d8d8",
  charcoal = "#e3e3e3",

  -- Functionals
  fg_dark = "#0e0e0e",        -- #e6e6e6;
  fg = "#333333",             -- #ffffff
  comment = "#7f7f7f",        -- #8a8a8a
  terminal_black = "#bfbfbf", -- #444444
  fg_gutter = "#c9c9c9",      -- #3e3e3e
  bg_darker = "#d0d0d0",      -- #262626
  bg_dark = "#e1e1e1",        -- #121212
  bg = "#ffffff",             -- #2b2b2b

  -- Extra colors
  green_unchanged = "#207000",
  git = {
    add = "#30a000",
    change = "#df6f00",
    delete = "#cf3000",
  },
}

---@return ColorScheme
function M.setup(opts)
  local config = require("martykai.config")
  local is_light = (not opts or not opts.force_style) and config.is_light() or opts and opts.force_style == "light"

  local bg_cfg = is_light and config.options.light_style_background or config.options.dark_style_background
  config.options.transparent = bg_cfg == "transparent"

  local palette = is_light and M.light_palette or {}

  -- Color Palette
  ---@class ColorScheme: Palette
  local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)

  colors.bg = (bg_cfg == "dark" or bg_cfg == "transparent") and colors.bg_dark
      or string.sub(bg_cfg, 1, 1) == "#" and bg_cfg
      or colors.bg
  colors.bg_dark = colors.bg == colors.bg_dark and colors.bg_darker or colors.bg_dark

  -- Default values for functions util.darken() and util.lighter()
  util.bg = colors.bg
  util.fg = colors.fg

  colors.border = colors.blue
  colors.border_highlight = colors.fg

  -- Statusline
  colors.bg_statusline = is_light and util.darken(colors.bg, 0.93, colors.fg) or colors.grey_darker
  colors.bg_status_alt = is_light and colors.charcoal or colors.charcoal_light
  colors.fg_statusline = colors.fg_dark

  -- Sidebar and Floats
  colors.bg_sidebar = config.options.hl_styles.sidebars == "transparent" and colors.none
      or config.options.hl_styles.sidebars == "dark" and colors.bg_dark
      or is_light and colors.bg_statusline
      or colors.charcoal
  colors.bg_float = config.options.hl_styles.floats == "transparent" and colors.none
      or (config.options.hl_styles.floats == "dark" and is_light) and colors.charcoal_medium
      or config.options.hl_styles.floats == "dark" and colors.bg_dark
      or colors.charcoal
  colors.fg_float = colors.fg

  -- Set the background for the current line (current cursor position)
  colors.bg_highlight = util.darken(colors.bg, 0.9, colors.fg) -- (0.97 for #313131)

  colors.bg_columns = config.options.transparent and colors.bg or util.lighten(colors.bg, 0.98, colors.fg)
  colors.bg_visual = is_light and colors.charcoal or colors.grey_darker
  colors.bg_search = colors.yellow
  colors.fg_search = is_light and colors.white or colors.black
  colors.fg_sidebar = colors.fg_dark

  -- Popups
  colors.bg_popup = is_light and colors.charcoal_medium or colors.grey_darker
  colors.bg_menuselbar = util.lighten(colors.bg_popup, 0.95)
  colors.bg_menusel = util.darken(colors.fg_gutter, 0.8)

  -- For lsp floats messages, git, diffs, etc.
  colors.error = colors.red
  colors.hint = colors.green_alt
  colors.info = colors.blue_alt
  colors.note = util.blend(colors.orange, colors.yellow, 0.6)
  colors.todo = colors.purple
  colors.warning = colors.orange
  colors.diff = {
    add = util.darken(colors.green, 0.15),
    delete = util.darken(colors.red, 0.15),
    change = util.darken(colors.blue_alt, 0.15),
    text = util.darken(colors.blue_alt, 0.5),
  }

  -- Rainbow colors (for color_headers, rainbow delimiters and other plugins)
  colors.rainbow = {
    colors.fg,
    colors.yellow,
    colors.orange,
    colors.red,
    colors.purple,
    colors.blue,
  }
  colors.rainbow_bg = {}
  for i = 1, #colors.rainbow do
    colors.rainbow_bg[i] = util.darken(colors.rainbow[i], 0.07)
  end

  -- Apply user config overrides
  config.options.on_colors(colors)

  return colors
end

return M
