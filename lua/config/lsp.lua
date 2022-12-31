local utils = require('config.utils')
local M = {}

function M.setup()
  local on_attach = function(_, bufnr)
      -- set up mappings
      local mappings = require('config.keymap').LSP_MAPPINGS
      for _, mapping in ipairs(mappings)
      do
        mode, keystrokes, cb = mapping[1], mapping[2], mapping[3]
        utils.buffer_map_with_cb(mode, keystrokes, '', cb)
      end
  end

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

  for _, lsp in pairs(servers) do
    lspconfig[lsp].setup {
      on_attach = on_attach,
      flags = {
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
        utils.map('n','<Leader>s', ':ClangdSwitchSourceHeader<CR>')
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
end
return M
