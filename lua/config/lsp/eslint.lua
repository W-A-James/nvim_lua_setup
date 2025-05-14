local lspconfig = require('lspconfig')

local M = {
  setup = function(flags, on_attach)
    lspconfig.eslint.setup({
      flags = flags,
      root_dir = lspconfig.util.root_pattern('package.json'),
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          command = 'EslintFixAll'
        })
        on_attach(client, bufnr)
      end,
      settings = {
        useFlatConfig = false,
        experimental = {
          useFlatConfig = false
        }
      }
    })
  end
}

return M
