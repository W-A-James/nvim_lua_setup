local lspconfig = require('lspconfig')
local utils = require('utils')
local M = {}

function M.setup(flags, on_attach)
  lspconfig.clangd.setup({
    flags = flags,
    on_attach = function(_, bufnr)
      utils.map('n', '<Leader>s', ':ClangdSwitchSourceHeader<CR>')
      on_attach(_, bufnr)
    end,
    settings = {
      cmd = "clangd-14"
    }
  })
end

return M
