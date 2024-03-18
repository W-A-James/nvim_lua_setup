local M = {}
-- Luasnip setup
local luasnip = require('luasnip')
local CMP_MAPPINGS = require('config.keymap').CMP_MAPPINGS;

-- nvim-cmp setup
local cmp = require('cmp')
function M.setup()
  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = CMP_MAPPINGS,
    sources = {
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'buffer' },
    },
  }
end

return M
