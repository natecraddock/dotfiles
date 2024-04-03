--
-- language server configuration
--

local cmd = vim.cmd
local opt = vim.opt

local lsp_config = require("lspconfig")

-- highlight references when cursor is held
cmd([[highlight LspReference guifg=NONE guibg=#665c54 guisp=NONE gui=NONE cterm=NONE ctermfg=NONE ctermbg=59]])
cmd([[highlight! link LspReferenceText LspReference]])
cmd([[highlight! link LspReferenceRead LspReference]])
cmd([[highlight! link LspReferenceWrite LspReference]])

-- change diagnostic signs for signcolumn
cmd([[sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=]])
cmd([[sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=]])
cmd([[sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=]])
cmd([[sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=]])

local function on_attach(client, buffer)
  -- completion
  opt.omnifunc = "v:lua.vim.lsp.omnifunc"

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
  -- cmd([[
  -- augroup lsp
  --   autocmd!
  --   autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  --   autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --   autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  -- augroup END
  -- ]])

  -- disable LSP formatting for lsp servers
  client.resolved_capabilities.document_formatting = false
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Don't show virtual text diagnostics
    virtual_text = false,
  }
)

-- enabled Servers
local servers = {
  {
    name = "clangd",
    init_options = {
      compilationDatabasePath = "build",
    },
  },
  {
    name = "pyright",
  },
  {
    name = "lus_ls",
    settings = luadev,
  },
  {
    name = "zls",
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

require("null-ls").setup({
  sources = {
    require("null-ls").builtins.formatting.clang_format,
  },
})

--
-- autocomplete
--

opt.completeopt = "menu"
opt.shortmess:append("c")
