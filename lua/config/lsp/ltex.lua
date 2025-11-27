local lspconfig = require('lspconfig')

local M = {
  setup = function(flags, runtime_path, on_attach)
    vim.lsp.enable('ltex')
    vim.lsp.config('ltex', {
      flags = flags,
      on_attach = on_attach,
      settings = {
        filetypes = { "bib", "gitcommit", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "quarto", "rmd", "context", "mail", "text" },
      }
    })
  end
}

return M
