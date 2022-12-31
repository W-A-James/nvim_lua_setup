local utils = require("config.utils")
local G = utils.G

local M = {
  LSP_MAPPINGS = { -- mode, keystrokes, callback
    {'n', 'gD', vim.lsp.buf.declaration},
    {'n', 'gd', vim.lsp.buf.definition},
    {'n', 'K', vim.lsp.buf.hover},
    {'n', 'gi', vim.lsp.buf.implementation},
    {'n', '<C-K>', vim.lsp.buf.signature_help},
    {'n', '<Leader wa>', vim.lsp.buf.add_workspace_folder},
    {'n', '<Leader wr>', vim.lsp.buf.remove_workspace_folder},
    {'n', '<Leader wl>', vim.lsp.buf.list_workspace_folders},
    {'n', '<Leader D>', vim.lsp.buf.type_definition},
    {'n', '<Leader rn>', vim.lsp.buf.rename},
    {'n', '<Leader ca>', vim.lsp.buf.code_action},
    {'n', 'gr', vim.lsp.buf.references},
    {'n', '<Leader f>', function()
      print("HELLO")
      vim.lsp.buf.format()
    end},
    {'n', '<Leader e>', vim.diagnostic.open_float},
    {'n', '[d',vim.diagnostic.goto_prev},
    {'n', ']d',vim.diagnostic.goto_next},
    {'n', '<Leader>q', vim.diagnostic.setloclist},
  },
  MAP_LEADER = ' '
}

function M.setLSPKeymaps(bufferNumber)
  for _, mapping in ipairs(M.LSP_MAPPINGS)
  do
    local mode, keystrokes, cb = mapping[1], mapping[2], mapping[3]
    utils.buffer_map_with_cb(bufferNumber, mode, keystrokes, cb)
  end
end

function M.setup ()
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

  -- telescope
  local telescopeBuiltin = require('telescope.builtin')
  utils.map_with_cb('n', '<leader>FF', telescopeBuiltin.find_files)
  utils.map_with_cb('n', '<leader>FG', telescopeBuiltin.live_grep)
  utils.map_with_cb('n', '<leader>FB', telescopeBuiltin.buffers)
  utils.map_with_cb('n', '<leader>FH', telescopeBuiltin.help_tags)
end

G.mapleader = M.MAP_LEADER

return M
