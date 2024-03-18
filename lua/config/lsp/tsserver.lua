local lspconfig = require('lspconfig')

local M = {
  setup = function(flags, on_attach)
    lspconfig.tsserver.setup({
      on_attach = on_attach,
      flags = flags,
      root_dir = lspconfig.util.root_pattern('package.json'),
      single_file_support = true
    })
  end
}

return M
