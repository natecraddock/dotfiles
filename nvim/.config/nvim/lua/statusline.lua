local colors = require("colorscheme").colors

local mode_map = {
  n = "NORMAL",
  i = "INSERT",
  v = "VISUAL",
  [""] = "V-BLOCK",
  V = "V-LINE",
  c = "COMMAND",
  R = "REPLACE",
  r = "REPLACE",
  nt = "TERM",
  t = "TERM",
}

local function vim_mode()
  return mode_map[vim.fn.mode()]:lower() .. "  "
end

local function git_status()
  local signs = vim.b.gitsigns_status_dict or { head = "", added = "", changed = "", removed = "" }
  local is_head_empty = signs.head == ""

  if is_head_empty then return "" end

  return string.format(" %s  ", signs.head)
end

local function modified_status()
  local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local modified = vim.api.nvim_buf_get_option(buf, "modified")
  if modified then
    return "*"
  else
    return ""
  end
end

local function file_name()
  local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local name = vim.api.nvim_buf_get_name(buf)
  name = vim.fn.fnamemodify(name, ":~:.")
  -- name = vim.fn.pathshorten(name)
  return name .. modified_status()
end

local function file_type()
  local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  return vim.api.nvim_buf_get_option(buf, "filetype"):lower()
end

local function file_encoding()
  local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local encoding = vim.api.nvim_buf_get_option(buf, "fileencoding")
  if encoding == "" then return "" end
  return "  " .. encoding:lower()
end

local function lsp_diagnostics()
  local s = vim.diagnostic.severity
  local errors = #vim.diagnostic.get(0, { severity = s.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = s.WARN })
  local info = #vim.diagnostic.get(0, { severity = s.INFO })
  local hints = #vim.diagnostic.get(0, { severity = s.HINT })

  -- no diagnostics when no errors
  if errors == 0 and warnings == 0 and info == 0 and hints == 0 then return "" end

  local diagnostics = " "
  if errors ~= 0 then
    diagnostics = diagnostics .. " :" .. errors
  end
  if warnings ~= 0 then
    diagnostics = diagnostics .. " :" .. warnings
  end
  if info ~= 0 then
    diagnostics = diagnostics .. " :" .. info
  end
  if hints ~= 0 then
    diagnostics = diagnostics .. " :" .. hints
  end

  return diagnostics
end

local current_workspace = function()
  local workspaces = require("workspaces")
  local name = workspaces.name()
  if name then return " " .. name end
  return ""
end

-- a global so luaeval can find it
function CustomStatusLine(type)
  if type == "active" then
    return table.concat({
      " ",
      vim_mode(),
      git_status(),
      file_name(),
      "%=",
      file_type(),
      file_encoding(),
      -- lsp_diagnostics(),
      -- "  %l, %c  %3p%%",
      current_workspace(),
      " ",
    })
  elseif type == "inactive" then
    return table.concat({
      " ",
      file_name(),
      "%=",
      file_type(),
      " ",
    })
  elseif type == "file" then
    return table.concat({
      "  Files",
    })
  elseif type == "alpha" then
    return ""
  end
end

vim.cmd([[
augroup CustomStatusLine
au!
au WinEnter,BufEnter * setlocal statusline=%!v:lua.CustomStatusLine('active')
au WinLeave,BufLeave * setlocal statusline=%!v:lua.CustomStatusLine('inactive')
au WinEnter,BufEnter NvimTree setlocal statusline=%!v:lua.CustomStatusLine('file')
au WinEnter,BufEnter alpha setlocal statusline=%!v:lua.CustomStatusLine('alpha')
augroup END
]])
