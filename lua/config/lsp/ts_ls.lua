local M = {
  setup = function(flags, on_attach)
    vim.lsp.enable('ts_ls')
    vim.lsp.config('ts_ls', {
      on_attach = on_attach,
      flags = flags,
      root_markers = { 'package.json' },
      single_file_support = true
    })
  end
}

return M
