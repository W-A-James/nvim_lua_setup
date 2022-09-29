-- Luasnip setup
local luasnip = require('luasnip')

-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup ({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<c-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 'c'}),
    ['<c-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 'c'}),
    ['<c-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    ['<c-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
    ['<c-Space>'] = cmp.mapping(cmp.mapping.complete({}), {'i', 'c'}),
    ['<CR>'] = cmp.mapping.confirm {
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.mapping.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.mapping.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  }),
  sources = cmp.config.sources ({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path'},
    { name = 'buffer'},
  },{
    {name = 'buffer'}
  }),
})
