local M = {
  setup = function(flags, on_attach)
    vim.lsp.enable('eslint')
    vim.lsp.config('eslint', {
      flags = flags,
      root_markers = { 'package.json' },
      on_attach = on_attach
    })
  end
}

return M
