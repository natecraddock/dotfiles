--
-- nvim config
--

local utils = require("utils")
local map = utils.map

-- expose useful tables
local g = vim.g
local opt = vim.opt
local cmd = vim.cmd

-- set leader key to space
map("", "<space>", "<nop>")
g.mapleader = " "

--
-- plugins
--

-- bootstrap the installation of packer for plugins
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
  vim.api.nvim_command("packadd packer.nvim")
end

require("packer").startup(function(use)
  -- packer can update itself
  use "wbthomason/packer.nvim"

  -- appearance related
  use "gruvbox-community/gruvbox"
  use "hoob3rt/lualine.nvim"
  use { "kyazdani42/nvim-tree.lua", opt = true, cmd = { "NvimTreeToggle", "NvimTreeFindFile" } }
  use { "nvim-treesitter/nvim-treesitter", branch = "0.5-compat", run = ":TSUpdate" }
  use "ziglang/zig.vim"
  use "psliwka/vim-smoothie"
  use { "norcalli/nvim-colorizer.lua", config = function() require("colorizer").setup() end }
  use "kyazdani42/nvim-web-devicons"
  use { "folke/trouble.nvim", requires = {"nvim-lua/plenary.nvim"}, config = function() require("trouble").setup() end }
  use "folke/todo-comments.nvim"
  use { "folke/zen-mode.nvim", config = function() require("zen-mode").setup() end }
  use { "folke/twilight.nvim", config = function() require("zen-mode").setup() end }
  use { "lewis6991/gitsigns.nvim" }

  -- telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-fzy-native.nvim"

  -- editing
  use "tpope/vim-sleuth"
  use "tpope/vim-surround"
  use "tpope/vim-unimpaired"
  use "tpope/vim-repeat"
  use "tpope/vim-commentary"
  use "tommcdo/vim-exchange"
  use "farmergreg/vim-lastplace"
  use "justinmk/vim-sneak"
  use "christoomey/vim-tmux-navigator"
  use "tversteeg/registers.nvim"

  -- lsp and completion
  use "neovim/nvim-lspconfig"
  use "hrsh7th/nvim-compe"
  use "folke/lsp-colors.nvim"
  use "jose-elias-alvarez/null-ls.nvim"

  -- plugin development
  use "folke/lua-dev.nvim"

  -- personal plugins
  -- use "~/dev/nvim-find"
end)


--
-- core behavior
--

-- disable swapfiles
opt.swapfile = false

-- support using the mouse in normal and visual modes
opt.mouse = "nv"

-- integrate with system clipboard
opt.clipboard = "unnamedplus"

-- time before the CursorHold event in ms
opt.updatetime = 400


--
-- appearance
--

-- hide intro text and status info
opt.shortmess:append("I")
opt.showmode = false
opt.showcmd = false

-- colorscheme
cmd "colorscheme gruvbox"
opt.background = "dark"
opt.termguicolors = true

-- g.gruvbox_contrast_dark = "soft"
g.gruvbox_sign_column = "bg0"
g.gruvbox_invert_selection = 0
g.gruvbox_italic = 1
-- g.gruvbox_improved_strings = 1

-- line numbers and signcolumn
opt.number = true
opt.signcolumn = "yes"
opt.cursorline = true

-- set window title in supported terminals
opt.title = true

-- open new split windows to bottom and right
opt.splitbelow = true
opt.splitright = true

-- line wrapping and scrolling
opt.wrap = false
opt.scrolloff = 4
opt.sidescrolloff = 16

-- limit completion popup to height of 10
opt.pumheight = 10

-- highlight on yank
cmd("autocmd TextYankPost * silent! lua vim.highlight.on_yank({ on_visual = false })")

-- statusline
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "gruvbox",
    component_separators = "",
    section_separators = "",
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename', {'diagnostics', sources = {'nvim_lsp'}}},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
})

-- nvim tree
g.nvim_tree_auto_close = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_add_trailing = 1
g.nvim_tree_group_empty = 1
g.nvim_tree_disable_window_picker = 1
g.nvim_tree_quit_on_open = 1

map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")

-- treesitter syntax highlight
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
})

-- todo comments
-- TODO: remove signs?
require("todo-comments").setup({
  colors = {
    info = "#83a598",
    error = "#dc2626",
    warning = "#fbbf24",
    hint = "#83a598",
    default = "#7c3aed",
  }
})

-- gitsigns
require("gitsigns").setup({
  signs = {
    add = { text = "┃" },
    change = { hl = 'GruvboxBlueSign', text = "┃" },
    delete = { text = "━" },
    changedelete = { hl = "GruvboxBlueSign" },
  },
})

--
-- editing
--

-- use 4 spaces for indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- join with single rather than double space
opt.joinspaces = false

-- highlight searches and use smart search casing
opt.inccommand = "nosplit"
opt.ignorecase = true
opt.smartcase = true

-- allow leaving buffers with changes
opt.hidden = true

-- disable auto-comment on o and O and enter
cmd([[
augroup formatoptions
  autocmd!
  autocmd BufEnter * setlocal formatoptions -=o formatoptions -=r
augroup END
]])

-- TODO: This is really gross
function _G.strip_trailing_whitespace()
  local l = vim.fn.line(".")
  local c = vim.fn.col(".")
  cmd([[:%s/\s\+$//e]])
  vim.fn.cursor({l, c})
end
cmd("autocmd BufWritePre * :call v:lua.strip_trailing_whitespace()")

-- Autoload buffers when modified outside
-- From: https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim
cmd([[autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif]])
cmd([[autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None]])
opt.autoread = true

-- local cfg = require("nvim-find.config")
-- cfg.files.ignore = {"node_modules/*", "__pycache__/*", "*.png", "*.jpg", "*.gif", "*.svg", "*.dat", "*.ico"}

-- vim-sneak
g["sneak#label"] = 1
g["sneak#s_next"] = 1
g["sneak#absolute_dir"] = 1

map("n", "f", "<plug>Sneak_f", { noremap = false })
map("n", "F", "<plug>Sneak_F", { noremap = false })
map("n", "t", "<plug>Sneak_t", { noremap = false })
map("n", "T", "<plug>Sneak_T", { noremap = false })

-- spellchecking
opt.spelllang = "en_us"

--
-- mappings
--

-- Allow moving through wrapped lines like a normal person
map("n", "j", "gj")
map("n", "k", "gk")

-- clear highlights
map("n", "<leader>/", ":noh<cr>")

-- disable annoying Ex mode
map("n", "Q", "<nop>")

cmd("autocmd FileType help noremap <buffer> <nowait> q :q<cr>")

-- local find = require("nvim-find.defaults")
-- map("n", "<c-p>", find.files)
-- map("n", "<leader>b", find.buffers)
-- map("n", "<leader>f", find.search_at_cursor)
-- map("n", "<leader>F", find.search)
-- map("v", "<leader>f", find.search)

map("n", "0", "^")
map("n", "^", "0")
map("v", "0", "^")
map("v", "^", "0")

map("n", "<a-j>", "]e==", { noremap = false })
map("n", "<a-k>", "[e==", { noremap = false })
map("v", "<a-j>", "]egv=gv", { noremap = false })
map("v", "<a-k>", "[egv=gv", { noremap = false })

map("n", "gr", "<cmd>TroubleToggle lsp_references<cr>")
map("n", "<leader>x", "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>")

-- reselect pasted text
map("n", "gp", "`[v`]")

map("n", "n", "'Nn'[v:searchforward] . 'zz'", { expr = true })
map("n", "N", "'nN'[v:searchforward] . 'zz'", { expr = true })

-- undo breakpoints when inserting
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")
map("i", ";", ";<c-g>u")

map("n", "<leader>lf", vim.lsp.buf.formatting)
map("v", "<leader>lf", vim.lsp.buf.range_formatting)

--
-- filetype specific settings
--

-- git commit messages
function _G.gitcommit_filetype()
  vim.wo.spell = true
  vim.bo.indentexpr = ""
  vim.bo.expandtab = true
  vim.bo.shiftwidth = 4
  vim.bo.tabstop = 4
  vim.bo.textwidth = 72
end
cmd([[autocmd FileType gitcommit call v:lua.gitcommit_filetype()]])

--
-- configs in separate files
--

require("plugins.telescope")
require("lsp")
