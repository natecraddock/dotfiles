-- everything for the beautiful colorschemes I use

local colorscheme = {}

local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

opt.termguicolors = true

-- g.gruvbox_contrast_dark = "soft"
g.gruvbox_sign_column = "bg0"
g.gruvbox_invert_selection = 0
g.gruvbox_italic = 1

local scheme = vim.env["COLORSCHEME"]

-- default colors if not set in env
if scheme == nil then
elseif scheme == "gruvbox-dark" then
  cmd "colorscheme adwaita"
  opt.background = "light"

  colorscheme.colors = {
    bg = "#3c3836",
    bg_statusline = "#3c3836",
    red = "#fb4934",
    green = "#b8bb26",
    yellow = "#d79921",
    blue = "#83a598",
    purple = "#b16286",
    aqua = "#689d6a",
    orange = "#fe8019",
    magenta = "#a89984",
    fg = "#ebdbb2",
  }
elseif scheme == "gruvbox-light" then
  -- cmd "colorscheme gruvbox"
  opt.background = "light"

  colorscheme.colors = {
    bg = "#ebdbb2",
    bg_statusline = "#ebdbb2",
    red = "#9d0006",
    green = "#797403",
    yellow = "#b57614",
    blue = "#076678",
    purple = "#8f3f71",
    aqua = "#427b58",
    orange = "#af3a03",
    magenta = "#7c6f64",
    fg = "#3c3836",
  }
end

return colorscheme
