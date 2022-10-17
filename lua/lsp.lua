vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.paste = false
-- nvim-cmp setup
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local cmp = require('cmp')
local luasnip = require('luasnip')
local select_opts = {behavior = cmp.SelectBehavior.Insert}

cmp.setup ({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = { completeopt = 'menu,menuone,noinsert' },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(select_opts)),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(select_opts)),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm ({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.mapping.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {'i', c=cmp.config.disable, 's'}),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.mapping.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', c=cmp.config.disable, 's'}),
  }),
  sources = cmp.config.sources ({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path'},
    { name = 'buffer'},
  },{
    {name = 'buffer'},
  })
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(), -- important!
  sources = {
    { name = 'nvim_lua' },
    { name = 'cmdline' },
  },
})
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(), -- important!
  sources = {
    { name = 'buffer' },
  },
})


local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
------------------------- Mappings ---------------------------------------------
local map = function(mode, keystrokes, effect)
    local opts = {noremap = true, silent=false}
    vim.api.nvim_set_keymap(mode, keystrokes, effect, opts)
end

local map_cb = function(mode, keystrokes, callback)
  vim.api.nvim_set_keymap(mode, keystrokes, '', {noremap=true, silent=true, callback=callback})
end

-- Suggestions
map('n', '<Leader><Leader>', 'gt')

map('n', '<Leader>b', ':NvimTreeToggle<CR>')
map('n', '<Leader>B', ':NvimTreeFocus<CR>')
map('n', '<Leader>F', ':NvimTreeFindFile<CR>')
map('n', '<Leader><CR>', ':NvimTreeRefresh<CR>')
-- Save with ctrl+s
map('i', '<c-s>', '<ESC>:w<CR>a')
map('n', '<c-s>', ':w<CR>')
-- move between panes
map('n', '<c-h>', '<c-w><c-h>')
map('n', '<c-j>', '<c-w><c-j>')
map('n', '<c-k>', '<c-w><c-k>')
map('n', '<c-l>', '<c-w><c-l>')
-- Copy line
map('n', 'Y', 'yy')

map_cb('n', '<Leader>e', vim.diagnostic.open_float)
map_cb('n', '[d', vim.diagnostic.goto_prev)
map_cb('n', ']d', vim.diagnostic.goto_next)
map_cb('n', '<Leader>q', vim.diagnostic.setloclist)

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

local servers = {
  'bashls',
  'tsserver',
  'jsonls',
  'pyright',
  'taplo',
}
-- local lspconfig = require('lspconfig')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      capabilities = capabilities,
      debounce_text_changes = 150,
    }
  }
end


require('lspconfig').clangd.setup({
  on_attach = function(a, bufnr)
      map('n','<Leader>s', ':ClangdSwitchSourceHeader<CR>')
      on_attach(a, bufnr)
    end,
  settings = {
    cmd = "clangd",
    inlayhints = {
      enabled = true,
    }
  },
  flags = {
    capabilities = capabilities
  }
})

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
  flags = {
    capabilities = capabilities
  }
})

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
  },
}

require('rust-tools').setup(rust_tools_opts)

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
