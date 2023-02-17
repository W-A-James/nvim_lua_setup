local utils = require("config.utils")
local G = utils.G
local cmp = require('cmp')
local dap = require('dap')
local dapui = require('dapui')
local luasnip = require('luasnip')

local M = {
  LSP_MAPPINGS = { -- mode, keystrokes, callback
    { 'n', 'gD', vim.lsp.buf.declaration },
    { 'n', 'gd', vim.lsp.buf.definition },
    { 'n', 'K', vim.lsp.buf.hover },
    { 'n', 'gi', vim.lsp.buf.implementation },
    { 'n', '<C-K>', vim.lsp.buf.signature_help },
    { 'n', '<leader>wa', vim.lsp.buf.add_workspace_folder },
    { 'n', '<leader>wr', vim.lsp.buf.remove_workspace_folder },
    { 'n', '<leader>wl', vim.lsp.buf.list_workspace_folders },
    { 'n', '<leader>D', vim.lsp.buf.type_definition },
    { 'n', '<leader>rn', vim.lsp.buf.rename },
    { 'n', '<leader>ca', vim.lsp.buf.code_action },
    { 'n', 'gr', vim.lsp.buf.references },
    { 'n', '<leader>f', function() vim.lsp.buf.format { async = true } end },
    { 'n', '<leader>e', vim.diagnostic.open_float },
    { 'n', '[d', vim.diagnostic.goto_prev },
    { 'n', ']d', vim.diagnostic.goto_next },
    { 'n', '<leader>q', vim.diagnostic.setloclist },
  },
  CMP_MAPPINGS = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
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
  },
  DAP_MAPPINGS = {
    { 'n', '<F5>', dap.continue },
    { 'n', '<F10>', function() dap.step_over({ stepping_granularity = 'line' }) end },
    { 'n', '<F11>', function() dap.step_into({ stepping_granularity = 'line', askForTagets = true }) end },
    { 'n', '<F12>', dap.step_out },
    { 'n', '<C-b>', dap.toggle_breakpoint },
    { 'n', '<C-C>', dap.clear_breakpoints },
    { 'n', '<C-L>', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end },
    { 'n', '<Leader>dr', dap.repl.toggle },
    { 'n', '<Leader>du', dapui.toggle },
    { 'n', '<Leader>dl', dap.repl.run_last },
  },
  MAP_LEADER = ' '
}

function M.setLSPKeymaps(bufferNumber)
  for _, mapping in ipairs(M.LSP_MAPPINGS) do
    local mode, keystrokes, cb = mapping[1], mapping[2], mapping[3]
    utils.buffer_map_with_cb(bufferNumber, mode, keystrokes, cb)
  end
end

function M.setup()
  -- Set up NvimTree keybindings
  utils.map('n', '<leader>b', ':NvimTreeToggle<CR>')
  utils.map('n', '<leader>B', ':NvimTreeFocus<CR>')
  utils.map('n', '<Leader><CR>', ':NvimTreeRefresh<CR>')

  -- <C-s> to write file
  utils.map('i', '<c-s>', '<ESC>:w<CR>a')
  utils.map('n', '<c-s>', ':w<CR>')

  -- split navigation
  utils.map('n', '<c-h>', '<c-w><c-h>')
  utils.map('n', '<c-j>', '<c-w><c-j>')
  utils.map('n', '<c-k>', '<c-w><c-k>')
  utils.map('n', '<c-l>', '<c-w><c-l>')

  -- Copy entire line
  utils.map('n', 'Y', 'yy')

  -- Copy file to clipboard
  utils.map('n', 'C', ':!cat % | clip.exe<CR><CR>:echo "Copied" @% "to clipboard"<CR>')

  -- telescope
  local telescopeBuiltin = require('telescope.builtin')
  utils.map_with_cb('n', '<leader>FF', telescopeBuiltin.find_files)
  utils.map_with_cb('n', '<leader>FG', telescopeBuiltin.live_grep)
  utils.map_with_cb('n', '<leader>FB', telescopeBuiltin.buffers)
  utils.map_with_cb('n', '<leader>FH', telescopeBuiltin.help_tags)
end

G.mapleader = M.MAP_LEADER

return M
