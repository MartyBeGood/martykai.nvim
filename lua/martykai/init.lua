local util = require("martykai.util")
local theme = require("martykai.theme")
local config = require("martykai.config")

local M = {}

M.loaded = false

---@param opts Config|nil
function M.load(opts)
  -- Set MartykaiToggleLight
  if not M.loaded then
    vim.cmd("command! MartykaiToggleLight lua MartykaiToggleLight()")

    -- HACK: Add back the removed Treesitter header markers. Use this workaround
    -- until they add something similar (if so)
    if opts and opts.markdown_header_marks == true then
      require("martykai.extras.ts_markdown").set_headers_marks()
    end
    M.loaded = true
  end

  if opts then
    require("martykai.config").extend(opts)
  end
  util.load(theme.setup())
end

---Toggle `vim.o.background` value to `dark` or `light`.
function MartykaiToggleLight()
  vim.o.background = (vim.o.background == "dark") and "light" or "dark"
end

M.toggle = MartykaiToggleLight

M.setup = config.setup

-- keep for backward compatibility
M.colorscheme = M.load

return M
