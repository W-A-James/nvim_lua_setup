local M = {}

function M.setup(flags, on_attach)
  vim.lsp.enable('denols')
  vim.lsp.config('denols', {
    on_attach = on_attach,
    flags = flags,
    root_markers = { 'deno.json', 'deno.jsonc' }
  })
end

return M
