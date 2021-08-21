local map = require("utils").map

local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")

-- global default setup for telescope
telescope.setup({
  defaults = {
    layout_config = {
      vertical = {
        mirror = true,
      },
    },
    previewer = false,
    sorting_strategy = "ascending",
  },
})

-- use fzy native for better search
-- TODO: replace with my own finder extension
telescope.load_extension("fzy_native")

-- better dropdown theme
local function dropdown(opts)
  opts = opts or {}

  local theme_opts = {
    theme = "dropdown improved",
    results_title = false,

    previewer = false,

    layout_strategy = "center",
    sorting_strategy = "ascending",
    layout_config = {
      width = function(_, max_columns, _)
        return math.min(max_columns - 3, 80)
      end,

      height = function(_, _, max_lines)
        return math.min(max_lines - 4, 15)
      end,
    },

    border = true,
    borderchars = {
      { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
    },
  }

  return vim.tbl_deep_extend("force", theme_opts, opts)
end

-- telescope mappings
map("n", "<leader>p", function()
  telescope_builtin.find_files(dropdown())
end)
map("n", "<leader>b", function()
  telescope_builtin.buffers(dropdown())
end)
map("n", "<leader>f", function()
  telescope_builtin.grep_string({ initial_mode = "normal" })
end)
map("n", "<leader>F", function()
  telescope_builtin.live_grep()
end)
