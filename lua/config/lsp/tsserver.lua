local lspconfig = require('lspconfig')

local M = {
  setup = function(flags, on_attach)
    lspconfig.ts_ls.setup({
      on_attach = on_attach,
      flags = flags,
      root_dir = lspconfig.util.root_pattern('package.json'),
      single_file_support = false
    })
  end
}

return M
