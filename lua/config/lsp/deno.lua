local lspconfig = require('lspconfig')

local M = {}

function M.setup(flags, on_attach)
  lspconfig.denols.setup({
    on_attach = on_attach,
    flags = flags,
    root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc')
  })
end

return M
