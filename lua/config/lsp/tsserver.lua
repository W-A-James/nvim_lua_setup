local lspconfig = require('lspconfig')

local M = {}

function M.setup(flags, on_attach)
  lspconfig.tsserver.setup({
    on_attach = on_attach,
    flags = flags,
    root_dir = lspconfig.util.root_pattern('package.json'),
    single_file_support = false
  })
end

return M
