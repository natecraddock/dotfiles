--
-- language server configuration
--

local cmd = vim.cmd
local opt = vim.opt

local lsp_config = require("lspconfig")
local protocol = require("vim.lsp.protocol")

-- highlight references when cursor is held
cmd([[highlight LspReference guifg=NONE guibg=#665c54 guisp=NONE gui=NONE cterm=NONE ctermfg=NONE ctermbg=59]])
cmd([[highlight! link LspReferenceText LspReference]])
cmd([[highlight! link LspReferenceRead LspReference]])
cmd([[highlight! link LspReferenceWrite LspReference]])

-- change diagnostic signs for signcolumn
cmd([[sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=]])
cmd([[sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=]])
cmd([[sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=]])
cmd([[sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=]])

local function on_attach(client, buffer)
  -- helpers
  local function set_keymap(...) vim.api.nvim_buf_set_keymap(buffer, ...) end

  -- mappings
  local options = { noremap = true, silent = true }

  set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", options)
  set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", options)
  set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>", options)
  set_keymap("n", "<leader>k", "<cmd>lua vim.lsp.buf.hover()<cr>", options)
  set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", options)
  set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", options)

  -- autocommands
  cmd([[
  augroup lsp
    autocmd!
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  augroup END
  ]])

  -- disable LSP formatting
  client.resolved_capabilities.document_formatting = false
end

-- symbols in completion popups
protocol.CompletionItemKind = {
  "", -- Text
  "", -- Method
  "", -- Function
  "", -- Constructor
  "", -- Field
  "", -- Variable
  "", -- Class
  "ﰮ", -- Interface
  "", -- Module
  "", -- Property
  "", -- Unit
  "", -- Value
  "", -- Enum
  "", -- Keyword
  "﬌", -- Snippet
  "", -- Color
  "", -- File
  "", -- Reference
  "", -- Folder
  "", -- EnumMember
  "", -- Constant
  "", -- Struct
  "", -- Event
  "ﬦ", -- Operator
  "", -- TypeParameter
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Don't show virtual text diagnostics
    virtual_text = false,
  }
)

-- enabled Servers
local luadev = require("lua-dev").setup({
  lspconfig = {
    cmd = {"lua-language-server-custom"},
    settings = {
      Lua = {
        completion = {
          showWord = "Fallback",
        },
      },
    },
  },
})

local servers = {
  {
    name = "clangd",
  },
  {
    name = "pyright",
  },
  {
    name = "sumneko_lua",
    settings = luadev,
  },
}

for _, server in ipairs(servers) do
  local settings = {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  }
  if server.settings then
    settings = server.settings
    settings.on_attach = on_attach
  end

  lsp_config[server.name].setup(settings)
end

local null_ls = require("null-ls")
null_ls.config({
  sources = {
    null_ls.builtins.formatting.clang_format,
  },
})

-- LSP formatting
lsp_config["null-ls"].setup({})

--
-- compe autocomplete
--

opt.completeopt = "menuone,noselect"
opt.shortmess:append("c")

require("compe").setup({
  enabled = true,
  autocomplete = true,
  preselect = "always",
  -- max_menu_width = 0,

  source = {
    path = true,
    nvim_lsp = true,
    calc = false,
    spell = false,
  },
})

cmd([[
inoremap <silent><expr> <c-space> compe#complete()
inoremap <silent><expr> <c-e>     compe#close('<C-e>')
inoremap <silent><expr> <c-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <c-d>     compe#scroll({ 'delta': -4 })
inoremap <silent><expr> <c-j>     pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr> <c-k>     pumvisible() ? "\<c-p>" : "\<tab>"
inoremap <silent><expr> <tab>     pumvisible() ? compe#confirm({ 'select': v:true }) : "\<tab>"
imap <silent><expr> <cr>      pumvisible() ? "\<c-e>\<cr>" : "\<cr>"
]], false)
