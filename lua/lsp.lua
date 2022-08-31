------------------------- Mappings ---------------------------------------------
local on_attach = function(_, bufnr)
    local bmap = vim.api.nvim_buf_set_keymap
    local with_callback = function (callback)
      return {silent=true, noremap=true,callback=callback}
    end
    local buf = vim.lsp.buf
    bmap(bufnr, 'n', 'gD', '', with_callback(buf.declaration))
    bmap(bufnr, 'n', 'gd', '', with_callback(buf.definition))
    bmap(bufnr, 'n', 'K', '', with_callback(buf.hover))
    bmap(bufnr, 'n', 'gi', '', with_callback(buf.implementation))
    bmap(bufnr, 'n', '<C-K>', '', with_callback(buf.signature_help))
    bmap(bufnr, 'n', '<Leader>wa', '', with_callback(buf.add_workspace_folder))
    bmap(bufnr, 'n', '<Leader>wr', '', with_callback(buf.remove_workspace_folder))
    bmap(bufnr, 'n', '<Leader>wl', '', with_callback(buf.list_workspace_folders))
    bmap(bufnr, 'n', '<Leader>D', '', with_callback(buf.type_definition))
    bmap(bufnr, 'n', '<Leader>rn', '', with_callback(buf.rename))
    bmap(bufnr, 'n', '<Leader>ca', '', with_callback(buf.code_action))
    bmap(bufnr, 'n', 'gr', '', with_callback(buf.references))
    bmap(bufnr, 'n', '<Leader>f', '', with_callback(buf.formatting))
end

local map = function(mode, keystrokes, effect)
    local opts = {noremap = true, silent=true}
    vim.api.nvim_set_keymap(mode, keystrokes, effect, opts)
end

local map_cb = function(mode, keystrokes, callback)
  vim.api.nvim_set_keymap(mode, keystrokes, '', {noremap=true, silent=true, callback=callback})
end

map('n', '<Leader>b', ':NERDTreeToggle<CR>')
map('n', '<Leader><Leader>', 'gt')
map('n', '<leader>t', ':split term://zsh<CR>')

-- Suggestions
map('i', '<c-s>', '<ESC>:w<CR>a')
map('n', '<c-s>', ':w<CR>')
map('n', '<c-h>', '<c-w><c-h>')
map('n', '<c-j>', '<c-w><c-j>')
map('n', '<c-k>', '<c-w><c-k>')
map('n', '<c-l>', '<c-w><c-l>')
map('n', '<Leader><CR>', ':NERDTreeRefreshRoot<CR>')
map('n', 'Y', 'yy')

map_cb('n', '<Leader>e', vim.diagnostic.open_float)
map_cb('n', '[d', vim.diagnostic.goto_prev)
map_cb('n', ']d', vim.diagnostic.goto_next)
map_cb('n', '<Leader>q', vim.diagnostic.setloclist)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = {
  -- 'clangd',
  'bashls',
  'jsonls',
  'pyright',
  'taplo'
}
local lspconfig = require('lspconfig')

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

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.clangd.setup({
  settings = {
    cmd = "clangd"
  }
})

lspconfig.sumneko_lua.setup({
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

-- Enable floating window
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
  }
)
