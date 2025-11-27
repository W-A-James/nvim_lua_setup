local M = {}

function M.setup(flags, on_attach)
  vim.lsp.enable('pylsp')
  vim.lsp.config('pylsp', {
    flags = flags,
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
    end,
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
