local utils = {}

local maps = {}

function utils.register_mapping(fn)
  table.insert(maps, fn)
  return #maps
end

function utils.run_mapping(num)
  local fn = maps[num]
  fn()
end

function utils.map(mode, lhs, rhs, opts)
  -- until there is an api for setting keymaps directly to lua functions
  -- we will store functions in a table and refer to them by integer keys.

  if type(rhs) == "function" then
    local map_num = utils.register_mapping(rhs)
    rhs = string.format("<cmd>lua require('utils').run_mapping(%s)<cr>", map_num)
  end

  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return utils
