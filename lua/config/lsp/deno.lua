local lspconfig = require('lspconfig')

local M = {
  setup = function(flags, on_attach)
    lspconfig.denols.setup({
      on_attach = on_attach,
      flags = flags,
      root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc')
    })
    -- Hello
  end
}

return M
