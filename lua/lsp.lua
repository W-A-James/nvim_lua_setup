------------------------- Mappings ---------------------------------------------
local on_attach = function(client, bufnr)
    local bmap = vim.api.nvim_buf_set_keymap
    local opts = {silent=true, noremap=true}
    bmap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    bmap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    bmap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    bmap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    bmap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    bmap(bufnr, 'n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    bmap(bufnr, 'n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    bmap(bufnr, 'n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    bmap(bufnr, 'n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    bmap(bufnr, 'n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    bmap(bufnr, 'n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    bmap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts) bmap(bufnr, 'n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local map = function(mode, keystrokes, effect)
    local opts = {noremap = true, silent=true}
    vim.api.nvim_set_keymap(mode, keystrokes, effect, opts)
end

map('n', '<Leader>b', ':NERDTreeToggle<CR>')
map('n', '<Leader><Leader>', 'gt')

-- Suggestions
map('i', '<c-s>', '<ESC>:w<CR>i')
map('n', '<c-s>', ':w<CR>')
map('n', '<c-h>', '<c-w><c-h>')
map('n', '<c-j>', '<c-w><c-j>')
map('n', '<c-k>', '<c-w><c-k>')
map('n', '<c-l>', '<c-w><c-l>')
map('n', '<Leader><CR>', ':NERDTreeRefreshRoot<CR>')
map('n', 'Y', 'yy')
map('n', '<Leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
map('n', '<Leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = {
  'clangd',
  'rls',
  'tsserver',
  'gopls',
  'ocamllsp',
  'zls',
  'bashls',
  'jsonls',
  'cssls',
  'html',
  'ltex'
}

vim.cmd [[ autocmd BufRead,BufNewFile *.org set filetype=org ]]

for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      capabilities = capabilities,
      debounce_text_changes = 150,
    }
  }
end

require('lspconfig').arduino_language_server.setup({
  cmd = {
    "~/bin/arduino-language-server",
    "-cli-config", "~/.arduino15/arduino-cli.yaml",
    "-cli", "~/bin/arduino-cli",
    "-clangd", "/usr/bin/clangd-12",
    "-cli-daemon-addr", "localhost:50051"
  }
})

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require('lspconfig').sumneko_lua.setup({
   settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})
