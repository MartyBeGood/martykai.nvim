local config = require("martykai.config")
local dark_style = config.options.lualine_style == "dark"
    or config.options.lualine_style ~= "light" and not config.is_light()
    or false

local martykai = {}

if dark_style then
  local c = require("martykai.colors").setup({ force_style = "dark" })

  martykai.normal = {
    a = { fg = c.black, bg = c.green },
    b = { fg = c.green, bg = c.bg_status_alt },
    c = { fg = c.fg_statusline, bg = c.bg_statusline },
  }

  martykai.insert = {
    a = { fg = c.black, bg = c.yellow_alt },
    b = { fg = c.yellow_alt, bg = c.bg_status_alt },
  }

  martykai.command = {
    a = { fg = c.green, bg = c.black },
    b = { fg = c.green, bg = c.bg_status_alt },
  }

  martykai.visual = {
    a = { fg = c.black, bg = c.purple },
    b = { fg = c.fg, bg = c.bg_status_alt },
  }

  martykai.replace = {
    a = { fg = c.black, bg = c.red },
    b = { fg = c.red, bg = c.bg_status_alt },
  }

  martykai.terminal = {
    a = { fg = c.green, bg = c.black },
    b = { fg = c.green, bg = c.bg_status_alt },
  }

  martykai.inactive = {
    a = { fg = c.blue, bg = c.bg_dark },
    b = { fg = c.fg_gutter, bg = c.bg_dark, gui = "bold" },
    c = { fg = c.grey, bg = c.bg_dark },
  }
else
  local c = require("martykai.colors").setup({ force_style = "light" })

  martykai.normal = {
    a = { fg = c.white, bg = c.green },
    b = { fg = c.fg_sidebar, bg = c.bg_status_alt },
    c = { fg = c.fg_statusline, bg = c.bg_statusline },
  }

  martykai.insert = {
    a = { fg = c.black, bg = c.yellow_alt },
    b = { fg = c.fg_sidebar, bg = c.bg_status_alt },
  }

  martykai.command = {
    a = { fg = c.green_unchanged, bg = c.black },
    b = { fg = c.fg_sidebar, bg = c.bg_status_alt },
  }

  martykai.visual = {
    a = { fg = c.white, bg = c.purple },
    b = { fg = c.purple, bg = c.bg_status_alt },
  }

  martykai.replace = {
    a = { fg = c.white, bg = c.red },
    b = { fg = c.red, bg = c.bg_status_alt },
  }

  martykai.terminal = {
    a = { fg = c.green_unchanged, bg = c.black },
    b = { fg = c.fg_sidebar, bg = c.bg_status_alt },
  }

  martykai.inactive = {
    a = { fg = c.blue, bg = c.bg_status_alt },
    b = { fg = c.fg_gutter, bg = c.bg_status_alt, gui = "bold" },
    c = { fg = c.grey, bg = c.bg_status_alt },
  }
end

if config.options.lualine_bold then
  for _, mode in pairs(martykai) do
    mode.a.gui = "bold"
  end
end

return martykai
