local lspconfig = require('lspconfig')

local simple_servers = {
  'cmake',
  'hls',
  'rust_analyzer',
  'gopls',
  'ocamllsp',
  'zls',
  'bashls',
  'jsonls',
  'cssls',
  'html',
  'taplo'
}

local rtp
local M = {}

local function configure_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  return capabilities
end

local function configure_rtp()
  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  rtp = runtime_path
end

local function configure_servers()
  local capabilities = configure_capabilities()
  local flags = {
    capabilities = capabilities,
    debounce_text_changes = 150,
  }

  local on_attach = function(_, bufferNumber)
    require('config.keymap').setLSPKeymaps(bufferNumber)
  end

  require('config.lsp.lua').setup(flags, rtp, on_attach)
  require('config.lsp.deno').setup(flags, on_attach)
  require('config.lsp.tsserver').setup(flags, on_attach)
  require('config.lsp.eslint').setup(flags, on_attach)
  require('config.lsp.arduino').setup(flags, on_attach)
  require('config.lsp.clangd').setup(flags, on_attach)
  require('config.lsp.pylsp').setup(flags, on_attach)

  for _, lsp in pairs(simple_servers) do
    lspconfig[lsp].setup {
      on_attach = on_attach,
      flags = flags
    }
  end
end

local function configure_floating_window()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      virtual_text = false,
      signs = true,
      update_in_insert = false,
      underline = true,
    }
  )
end

function M.setup()
  configure_rtp()

  configure_servers()

  configure_floating_window()
end

return M
