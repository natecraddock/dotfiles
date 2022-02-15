local map = require("utils").map

local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local themes = require("telescope.themes")

-- global default setup for telescope
telescope.setup({
  defaults = themes.get_ivy({
    mappings = {
      i = {
        ["<c-s>"] = "select_horizontal",
      },
    },
    previewer = true,
    sorting_strategy = "ascending",
    winblend = 8,
  }),

  pickers = {
    find_files = themes.get_ivy({ previewer = false }),
    buffers = themes.get_ivy({ previewer = false }),
    oldfiles = themes.get_ivy({ previewer = false }),
    workspaces = themes.get_ivy({ previewer = false }),
  },

  extensions = {
    workspaces = {
      keep_insert = false,
    },
  },
})

-- use my fuzzy finder for better search :)
telescope.load_extension("zf-native")

-- workspace picker
telescope.load_extension("workspaces")

-- telescope mappings
map("n", "<leader>p", ":Telescope find_files<cr>")
map("n", "<leader>b", ":Telescope buffers<cr>")

map("n", "<leader>F", function()
  telescope_builtin.grep_string(themes.get_ivy({ initial_mode = "normal" }))
end)
map("n", "<leader>f", function()
  telescope_builtin.live_grep(themes.get_ivy())
end)

-- tweaks
vim.cmd[[
" hide cursorline in prompt
autocmd FileType TelescopePrompt set nocursorline
]]
