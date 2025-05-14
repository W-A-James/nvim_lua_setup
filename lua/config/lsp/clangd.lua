local lspconfig = require('lspconfig')

local M = {
  setup = function(flags, runtime_path, on_attach)
    lspconfig.clangd.setup({
      flags = flags,
      on_attach = on_attach,
      cmd = { "clangd-12" }
    })
  end
}

return M
