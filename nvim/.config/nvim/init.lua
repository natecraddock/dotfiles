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

  -- lang support
  use "ziglang/zig.vim"

  -- appearance related
  use "goolord/alpha-nvim"
  use "gruvbox-community/gruvbox"
  use {
    "kyazdani42/nvim-tree.lua",
    event = "VimEnter",
    -- cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require("nvim-tree").setup({
        auto_close = true,
        hijack_cursor = true,
        update_cwd = true,
      })
    end,
  }
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use { "nvim-treesitter/playground" }
  use "psliwka/vim-smoothie"
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  }
  use "kyazdani42/nvim-web-devicons"
  use {
    "folke/trouble.nvim",
    requires = {"nvim-lua/plenary.nvim"},
    cmd = "Trouble",
    config = function()
      require("trouble").setup()
    end,
  }
  use "folke/todo-comments.nvim"
  use { "lewis6991/gitsigns.nvim" }

  -- telescope
  use {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    keys = { "<leader>p" },
    module = "telescope",
    requires = {
      "~/dev/nvim/telescope-zf-native.nvim/"
    },
    config = function()
      require("plugins.telescope")
    end,
  }

  -- editing
  use "tpope/vim-sleuth"
  use "tpope/vim-surround"
  use "tpope/vim-unimpaired"
  use "tpope/vim-repeat"
  use "tpope/vim-commentary"
  use "farmergreg/vim-lastplace"
  use "justinmk/vim-sneak"

  -- lsp
  use "neovim/nvim-lspconfig"
  use "folke/lsp-colors.nvim"
  use "jose-elias-alvarez/null-ls.nvim"

  -- plugin development
  use "folke/lua-dev.nvim"

  use "~/dev/nvim/subtle.nvim/"

  use {
    "~/dev/nvim/workspaces.nvim/",
    config = function()
      require("workspaces").setup({
        hooks = {
          -- hooks run before change directory
          open_pre = {
            -- save current session state if currently recording
            "SessionsStop",

            -- delete all buffers (does not save changes)
            "silent %bdelete!",
          },

          -- hooks run after change directory
          open = {
            -- load any saved session from current directory
            function(name, path)
              if not require("sessions").load(nil, { silent = true }) then
                require("telescope.builtin").find_files({ initial_mode = "insert" })
                vim.schedule(function() vim.cmd("startinsert") end)
              end
            end
          }
        },
      })
    end
  }

  use {
    "~/dev/nvim/sessions.nvim/",
    config = function()
      require("sessions").setup({
        session_filepath = ".nvim/session"
      })
    end
  }
end)

--
-- core behavior
--

-- disable swapfiles
opt.swapfile = false

-- persistent undo
opt.undofile = true

opt.undodir = "/tmp/nvim/undo/"

-- support using the mouse in normal and visual mode
opt.mouse = "nv"

-- integrate with system clipboard
opt.clipboard = "unnamedplus"

-- time before the CursorHold event in ms
-- rk
opt.updatetime = 400


--
-- appearance
--

-- dashboard

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  "███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
  "████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
  "██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
  "██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
  "██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
  "╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
}
dashboard.section.header.opts.hl = "Normal"

dashboard.section.buttons.val = {
  dashboard.button("n", "  New file", ":enew <cr>"),
  dashboard.button("f", "  Find file", ":Telescope find_files<cr>"),
  dashboard.button("w", "  Workspaces", ":Telescope workspaces<cr>"),
  dashboard.button("r", "  Recent", ":Telescope oldfiles<cr>"),
  dashboard.button("u", "  Update Plugins",":PackerSync<cr>"),
  dashboard.button("s", "  Settings", ":e $MYVIMRC | :cd %:p:h<cr>"),
  dashboard.button("q", "  Quit NVIM", ":qa<cr>"),
}

dashboard.section.buttons.opts.spacing = 0

dashboard.section.footer.val = require("alpha.fortune")()
dashboard.section.footer.opts.hl = "SpecialKey"

alpha.setup(dashboard.opts)

-- statusline
require("statusline")

-- init colorscheme and get colors
require("colorscheme")

-- hide intro text and status info
opt.shortmess:append("I")
opt.showmode = false
opt.showcmd = false

-- line numbers and signcolumn
opt.number = true
opt.signcolumn = "auto"
opt.cursorline = true

cmd[[
au!
au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
au WinLeave * setlocal nocursorline
]]

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

-- nvim tree
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
-- TODO: take colors from theme
require("todo-comments").setup({
  signs = false,
  highlight = {
    keyword = "fg",
    after = "",
  },
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


-- terminal mode
cmd[[
augroup terminal
  autocmd!
  autocmd TermOpen * startinsert
  autocmd TermLeave * stopinsert
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd TermOpen * :set nonumber nocursorline signcolumn=no
  autocmd TermClose * :bd
augroup END
]]

-- allow for window commands in the terminal, at the cost of <c-w>
-- requiring two presses when desired
map("t", "<c-w>", "<c-\\><c-n><c-w>")

-- <esc> will send <esc> to running process, so use <c-q> to access
-- normal mode in the terminal buffer (not commonly needed)
map("t", "<c-q>", "<c-\\><c-n>")

--
-- editing
--

-- use 4 spaces for indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- use smart search casing
opt.ignorecase = true
opt.smartcase = true

-- disable auto-comment on o and O and enter
cmd([[
augroup formatoptions
  autocmd!
  autocmd BufEnter * setlocal formatoptions -=o formatoptions -=r
augroup END
]])

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

-- vim-sneak
g["sneak#label"] = 1
g["sneak#s_next"] = 0
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

-- disable annoying Ex mode by moving macro recording to Q
map("n", "Q", "q")
map("v", "Q", "q")
map("x", "Q", "q")

-- remove command-line window mappings. Use <c-f> from : / or ? modes
-- to view the history if desired.
map("n", "q", "<nop>")
map("n", "q:", "<nop>")
map("n", "q/", "<nop>")
map("n", "q?", "<nop>")
map("x", "q", "<nop>")
map("x", "q:", "<nop>")
map("x", "q/", "<nop>")
map("x", "q?", "<nop>")

-- close help buffers with q
cmd("autocmd FileType help noremap <buffer> <nowait> q :q<cr>")

-- swap caret and zero for beginning of line
map("n", "0", "^")
map("n", "^", "0")
map("v", "0", "^")
map("v", "^", "0")
map("o", "0", "^")
map("o", "^", "0")

map("n", "<a-j>", "]e==", { noremap = false })
map("n", "<a-k>", "[e==", { noremap = false })
map("v", "<a-j>", "]egv=gv", { noremap = false })
map("v", "<a-k>", "[egv=gv", { noremap = false })

map("n", "gr", "<cmd>TroubleToggle lsp_references<cr>")
map("n", "<leader>x", "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>")

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

-- disable arrows in insert mode
map("i", "<up>", "<nop>")
map("i", "<down>", "<nop>")
map("i", "<left>", "<nop>")
map("i", "<right>", "<nop>")

-- tab to visit previous buffer
map("n", "<tab>", "<c-^>")

-- commenting
map("n", "<c-_>", "gcc", { noremap = false })
map("v", "<c-_>", "gc", { noremap = false })

-- omnifunc (c-f like fish shell completion)
map("i", "<c-f>", "<c-x><c-o>")

map("i", "<c-bs>", "<c-w>")
map("i", "<c-h>", "<c-w>")
map("c", "<c-bs>", "<c-w>", { noremap = false })
map("c", "<c-h>", "<c-w>", { noremap = false })

--
-- configs in separate files
--

require("lsp")
