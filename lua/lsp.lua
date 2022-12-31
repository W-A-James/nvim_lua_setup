------------------------- Mappings ---------------------------------------------
--
local map = function(mode, keystrokes, effect)
    local opts = {noremap = true, silent=true}
    vim.api.nvim_set_keymap(mode, keystrokes, effect, opts)
end

local map_cb = function(mode, keystrokes, callback)
  vim.api.nvim_set_keymap(mode, keystrokes, '', {noremap=true, silent=true, callback=callback})
end

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
    bmap(bufnr, 'n', '<Leader>e', '', with_callback(vim.diagnostic.open_float))
    bmap(bufnr, 'n', '[d', '', with_callback(vim.diagnostic.goto_prev))
    bmap(bufnr, 'n', ']d', '', with_callback(vim.diagnostic.goto_next))
    bmap(bufnr, 'n', '<Leader>q', '', with_callback(vim.diagnostic.setloclist))
end

map('n', '<leader>b', ':NvimTreeToggle<CR>')
map('n', '<leader>B', ':NvimTreeFocus<CR>')
map('n', '<leader>F', ':NvimTreeFindFile<CR>')
map('n', '<Leader><CR>', ':NvimTreeRefresh<CR>')


-- Suggestions
map('i', '<c-s>', '<ESC>:w<CR>a')
map('n', '<c-s>', ':w<CR>')
map('n', '<c-h>', '<c-w><c-h>')
map('n', '<c-j>', '<c-w><c-j>')
map('n', '<c-k>', '<c-w><c-k>')
map('n', '<c-l>', '<c-w><c-l>')
map('n', 'Y', 'yy')

-- telescope
local telescopeBuiltin = require('telescope.builtin')
map_cb('n', '<leader>FF', telescopeBuiltin.find_files)
map_cb('n', '<leader>FG', telescopeBuiltin.live_grep)
map_cb('n', '<leader>FB', telescopeBuiltin.buffers)
map_cb('n', '<leader>FH', telescopeBuiltin.help_tags)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = {
  'cmake',
  'clojure_lsp',
  'hls',
  'rust_analyzer',
  'tsserver',
  'gopls',
  'ocamllsp',
  'zls',
  'bashls',
  'tsserver',
  'jsonls',
  'cssls',
  'html',
  'pylsp',
  'taplo'
}
local lspconfig = require('lspconfig')

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.org"},
  callback = function()
    vim.opt.filetype='org'
  end
})

for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      capabilities = capabilities,
      debounce_text_changes = 150,
    }
  }
end

local rust_tools_opts = {
  tools = {
    autoSetHints = true,
    -- hover_with_actions = true,
    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "<-- ",
      other_hints_prefix = "--> ",
      highlight = "Comment"
    },
  },
  server = {
    on_attach = on_attach,
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy"
      }
    }
  }
}

require('rust-tools').setup(rust_tools_opts)

lspconfig.arduino_language_server.setup({
  cmd = {
    "~/bin/arduino-language-server",
    "-cli-config", "~/.arduino15/arduino-cli.yaml",
    "-cli", "~/bin/arduino-cli",
    "-clangd", "/usr/bin/clangd-14",
    "-cli-daemon-addr", "localhost:50051"
  }
})

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.clangd.setup({
  on_attach = function(_, bufnr)
      map('n','<Leader>s', ':ClangdSwitchSourceHeader<CR>')
      on_attach(_, bufnr)
    end,
  settings = {
    cmd = "clangd-14"
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

lspconfig.pylsp.setup({
  pylsp = {
    plugins = {
      flake8 = {
        enabled = true
      },
      autopep8 = {
        enabled = false
      },
      jedi_completion = {
        fuzzy = true
      }
    }
  }
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
