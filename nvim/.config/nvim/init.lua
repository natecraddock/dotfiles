--
-- nvim config
--

-- expose useful tables
local g = vim.g
local opt = vim.opt

local keymap = vim.keymap

-- set leader key to space
keymap.set("", "<space>", "<nop>")
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
  use "kyazdani42/nvim-web-devicons"
  use { "lewis6991/gitsigns.nvim" }

  -- telescope
  use {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    module = "telescope",
    requires = {
      "~/code/nvim/telescope-zf-native.nvim/",
      "https://github.com/nvim-lua/plenary.nvim",
    },
    config = function()
      require("user.telescope")
    end,
  }

  -- editing
  use "tpope/vim-sleuth"
  use "tpope/vim-surround"
  use "tpope/vim-unimpaired"
  use "tpope/vim-commentary"
  use "farmergreg/vim-lastplace"
  use "justinmk/vim-sneak"

  -- lsp

  -- plugin development

  use "ratfactor/zf.vim"

  use {
    "~/code/nvim/workspaces.nvim/",
    config = function()
      require("workspaces").setup({
        cd_type = "tab",
        auto_open = true,
        hooks = {
          -- hooks run before change directory
          open_pre = {
            -- save current session state if currently recording
            "SessionsStop",

            -- delete all buffers (does not save changes)
            -- "silent %bdelete!",
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
    "~/code/nvim/sessions.nvim/",
    config = function()
      require("sessions").setup({
        session_filepath = ".nvim/session",
      })
    end
  }
end)

-- TODO: this or farmergreg/lastplace?
-- vim.cmd[[
-- augroup cursor-restore
--   autocmd!
--   autocmd BufRead * autocmd FileType <buffer> ++once
--     \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
-- augroup END
-- ]]

--
-- core behavior
--

vim.g.python3_host_prog = "python"

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


vim.cmd [[ colorscheme shine ]]

-- statusline
require("user.statusline")

-- init colorscheme and get colors
-- require("user.colorscheme")

-- hide intro text and status info
opt.shortmess:append("I")
opt.showmode = false
opt.showcmd = false

-- line numbers and signcolumn
opt.number = true
opt.signcolumn = "auto"
opt.cursorline = true

vim.api.nvim_create_autocmd({"VimEnter", "WinEnter", "BufWinEnter"}, {
  pattern = "*",
  callback = function() opt.cursorline = true end,
})

vim.api.nvim_create_autocmd("WinLeave", {
  pattern = "*",
  callback = function() opt.cursorline = false end,
})

-- set window title in supported terminals
opt.title = true

-- open new split windows to bottom and right
opt.splitbelow = true
opt.splitright = true

opt.equalalways = false

-- line wrapping and scrolling
opt.wrap = false
opt.scrolloff = 4
opt.sidescrolloff = 16

-- limit completion popup to height of 10
opt.pumheight = 10

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  command = "silent! lua vim.highlight.on_yank({ on_visual = false })",
})

-- nvim tree
g.nvim_tree_add_trailing = 1
g.nvim_tree_group_empty = 1

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
local group = vim.api.nvim_create_augroup("Terminal", {})
vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  pattern = "*",
  command = "startinsert",
})

vim.api.nvim_create_autocmd("TermLeave", {
  group = group,
  pattern = "*",
  command = "stopinsert",
})

vim.api.nvim_create_autocmd({"BufWinEnter","WinEnter"}, {
  group = group,
  pattern = "term://*",
  command = "startinsert",
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  pattern = "*",
  command = ":set nonumber nocursorline signcolumn=no",
})

vim.api.nvim_create_autocmd("TermClose", {
  group = group,
  pattern = "*",
  command = ":bd",
})

-- allow for window commands in the terminal, at the cost of <c-w>
-- requiring two presses when desired
keymap.set("t", "<c-w>", "<c-\\><c-n><c-w>")

-- <esc> will send <esc> to running process, so use <c-q> to access
-- normal mode in the terminal buffer (not commonly needed)
keymap.set("t", "<c-q>", "<c-\\><c-n>")

opt.fillchars:append({ eob = " " })

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
group = vim.api.nvim_create_augroup("formatoptions", {})
vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  pattern = "*",
  command = "setlocal formatoptions -=o formatoptions -=r",
})

-- strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local l = vim.fn.line(".")
    local c = vim.fn.col(".")
    vim.cmd([[:%s/\s\+$//e]])
    vim.fn.cursor({l, c})
  end,
})

-- Autoload buffers when modified outside
-- From: https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim
vim.api.nvim_create_autocmd({"FocusGained", "BufEnter", "CursorHold", "CursorHoldI"}, {
  pattern = "*",
  command = "if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif",
})
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None",
})

-- vim-sneak
g["sneak#label"] = 1
g["sneak#s_next"] = 0
g["sneak#absolute_dir"] = 1

keymap.set("n", "f", "<plug>Sneak_f", { remap = true })
keymap.set("n", "F", "<plug>Sneak_F", { remap = true })
keymap.set("n", "t", "<plug>Sneak_t", { remap = true })
keymap.set("n", "T", "<plug>Sneak_T", { remap = true })

-- spellchecking
opt.spelllang = "en_us"

-- disable redraw during macros
opt.lazyredraw = false

--
-- mappings
--

-- Allow moving through wrapped lines like a normal person
keymap.set("n", "j", "gj")
keymap.set("n", "k", "gk")

-- disable annoying Ex mode by moving macro recording to Q
keymap.set("n", "Q", "q")
keymap.set("v", "Q", "q")
keymap.set("x", "Q", "q")

-- remove command-line window mappings. Use <c-f> from : / or ? modes
-- to view the history if desired.
keymap.set("n", "q", "<nop>")
keymap.set("n", "q:", "<nop>")
keymap.set("n", "q/", "<nop>")
keymap.set("n", "q?", "<nop>")
keymap.set("x", "q", "<nop>")
keymap.set("x", "q:", "<nop>")
keymap.set("x", "q/", "<nop>")
keymap.set("x", "q?", "<nop>")

-- close help buffers with q
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function()
  end,
})

-- swap caret and zero for beginning of line
keymap.set("n", "0", "^")
keymap.set("n", "^", "0")
keymap.set("v", "0", "^")
keymap.set("v", "^", "0")
keymap.set("o", "0", "^")
keymap.set("o", "^", "0")

keymap.set("n", "<a-j>", "]e==", { remap = true })
keymap.set("n", "<a-k>", "[e==", { remap = true })
keymap.set("v", "<a-j>", "]egv=gv", { remap = true })
keymap.set("v", "<a-k>", "[egv=gv", { remap = true })

keymap.set("n", "gr", "<cmd>TroubleToggle lsp_references<cr>")
keymap.set("n", "<leader>x", "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>")

keymap.set("n", "n", "'Nn'[v:searchforward] . 'zz'", { expr = true })
keymap.set("n", "N", "'nN'[v:searchforward] . 'zz'", { expr = true })

-- undo breakpoints when inserting
keymap.set("i", ",", ",<c-g>u")
keymap.set("i", ".", ".<c-g>u")
keymap.set("i", "!", "!<c-g>u")
keymap.set("i", "?", "?<c-g>u")
keymap.set("i", ";", ";<c-g>u")

-- disable arrows in insert mode
keymap.set("i", "<up>", "<nop>")
keymap.set("i", "<down>", "<nop>")
keymap.set("i", "<left>", "<nop>")
keymap.set("i", "<right>", "<nop>")

-- tab to visit previous buffer
keymap.set("n", "<tab>", "<c-^>")

-- commenting
keymap.set("n", "<c-_>", "gcc", { remap = true })
keymap.set("v", "<c-_>", "gc", { remap = true })

-- omnifunc (c-f like fish shell completion)
keymap.set("i", "<c-f>", "<c-x><c-o>")

keymap.set("i", "<c-bs>", "<c-w>")
keymap.set("i", "<c-h>", "<c-w>")
keymap.set("c", "<c-bs>", "<c-w>", { remap = true })
keymap.set("c", "<c-h>", "<c-w>", { remap = true })

-- much more convenient to switch to last window
keymap.set("n", "<c-w>w", "<c-w><c-p>")
keymap.set("n", "<c-w><c-w>", "<c-w><c-p>")

--
-- configs in separate files
--

-- require("user.lsp")
