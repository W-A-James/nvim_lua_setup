local lspconfig = require('lspconfig')
local M = {}

function M.setup(flags, on_attach)
  lspconfig.pylsp.setup({
    flags = flags,
    on_attach = on_attach,
    pylsp = {
      plugins = {
        flake8 = {
          enabled = true
        },
        autopep8 = {
          enabled = false
        },
        jedi_completion = {
          fuzzy = true
        }
      }
    }
  })
end

return M
