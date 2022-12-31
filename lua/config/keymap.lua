local utils = require("config.utils")

local buf = vim.lsp.buf
local M = {
  LSP_MAPPINGS = { -- mode, keystrokes, callback
    {'n', 'gD', buf.declaration},
    {'n', 'gd', buf.definition},
    {'n', 'K', buf.hover},
    {'n', 'gi', buf.implementation},
    {'n', '<CK', buf.signature_help},
    {'n', '<Leader wa>', buf.add_workspace_folder},
    {'n', '<Leader wr>', buf.remove_workspace_folder},
    {'n', '<Leaderl wl>',buf.list_workspace_folders},
    {'n', '<Leader D>', buf.type_definition},
    {'n', '<Leader rn>', buf.rename},
    {'n', '<Leader ca>', buf.code_action},
    {'n', 'gr', buf.references},
    {'n', '<Leader f>', buf.formatting},
    {'n', '<Leader e>', vim.diagnostic.open_float},
    {'n', '[d',vim.diagnostic.goto_prev},
    {'n', ']d',vim.diagnostic.goto_next},
    {'n', '<Leader>q', vim.diagnostic.setloclist},
  },
  MAP_LEADER = ' '
}

function M.setup ()
  utils.G.mapleader = M.MAP_LEADER
  -- Set up NvimTree keybindings
  utils.map('n', '<leader>b', ':NvimTreeToggle<CR>')
  utils.map('n', '<leader>B', ':NvimTreeFocus<CR>')
  utils.map('n', '<leader>F', ':NvimTreeFindFile<CR>')
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
  utils.map_cb('n', '<leader>FF', telescopeBuiltin.find_files)
  utils.map_cb('n', '<leader>FG', telescopeBuiltin.live_grep)
  utils.map_cb('n', '<leader>FB', telescopeBuiltin.buffers)
  utils.map_cb('n', '<leader>FH', telescopeBuiltin.help_tags)
end

return M
