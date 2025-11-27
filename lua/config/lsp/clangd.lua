local utils = require('config.utils')
local M = {}

function M.setup(flags, on_attach)
  vim.lsp.enable('clangd')
  vim.lsp.config('clangd',
  {
    flags = flags,
    on_attach = function(_, bufnr)
      utils.map('n', '<Leader>s', ':ClangdSwitchSourceHeader<CR>')
      on_attach(_, bufnr)
    end,
    settings = {
      cmd = "clangd"
    }
  })
end

return M
