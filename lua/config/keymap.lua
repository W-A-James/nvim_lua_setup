local utils = require("config.utils")
local G = utils.G
local cmp = require('cmp')
local dap = require('dap')
local dapui = require('dapui')
local luasnip = require('luasnip')

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function async_format()
  vim.lsp.buf.format({ async = true })
end

local M = {
  LSP_MAPPINGS = { -- mode, keystrokes, callback
    { 'n', 'gD',         vim.lsp.buf.declaration },
    { 'n', 'gd',         vim.lsp.buf.definition },
    { 'n', 'K',          vim.lsp.buf.hover },
    { 'n', 'gi',         vim.lsp.buf.implementation },
    { 'n', '<C-K>',      vim.lsp.buf.signature_help },
    { 'n', '<leader>wa', vim.lsp.buf.add_workspace_folder },
    { 'n', '<leader>wr', vim.lsp.buf.remove_workspace_folder },
    { 'n', '<leader>wl', vim.lsp.buf.list_workspace_folders },
    { 'n', '<leader>D',  vim.lsp.buf.type_definition },
    { 'n', '<leader>rn', vim.lsp.buf.rename },
    { 'n', '<leader>ca', vim.lsp.buf.code_action },
    { 'n', 'gr',         vim.lsp.buf.references },
    { 'n', '<leader>f',  async_format },
    { 'n', '<leader>e',  vim.diagnostic.open_float },
    { 'n', '[d',         vim.diagnostic.goto_prev },
    { 'n', ']d',         vim.diagnostic.goto_next },
    { 'n', '<leader>q',  vim.diagnostic.setloclist },
  },
  CMP_MAPPINGS = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs( -4),
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
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.mapping.select_prev_item()
      elseif luasnip.jumpable( -1) then
        luasnip.jump( -1)
      else
        fallback()
      end
    end,
  },
  DAP_MAPPINGS = {
    { 'n', '<F5>',       dap.continue },
    { 'n', '<F10>',      function() dap.step_over({ stepping_granularity = 'line' }) end },
    { 'n', '<F11>',      function() dap.step_into({ stepping_granularity = 'line', askForTagets = true }) end },
    { 'n', '<F12>',      dap.step_out },
    { 'n', '<C-b>',      dap.toggle_breakpoint },
    { 'n', '<C-C>',      dap.clear_breakpoints },
    { 'n', '<C-L>',      function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end },
    { 'n', '<Leader>dr', dap.repl.toggle },
    { 'n', '<Leader>du', dapui.toggle },
    { 'n', '<Leader>dl', dap.repl.run_last },
  },
  MAP_LEADER = ' '
}

local function convert_to_jira_markup()
  -- Copy from buffer
  -- run through pandoc
  -- copy result to clipboard
  -- Print success/failure message
end
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
  utils.map('n', '<c-Left>', '<c-w><c-h>')
  utils.map('n', '<c-Down>', '<c-w><c-j>')
  utils.map('n', '<c-Up>', '<c-w><c-k>')
  utils.map('n', '<c-Right>', '<c-w><c-l>')

  -- jump to previous buffer
  utils.map('n', 'gb', ':b#<CR>')

  utils.map("i", "<c-j>", "<Plug>luasnip-next-choice")
  utils.map("s", "<c-j>", "<Plug>luasnip-next-choice")
  utils.map("i", "<c-k>", "<Plug>luasnip-prev-choice")
  utils.map("s", "<c-k>", "<Plug>luasnip-prev-choice")
  -- Copy entire line
  utils.map('n', 'Y', 'yy')

  -- Copy file to clipboard
  utils.map('n', 'C', ':!cat % | clip.exe<CR><CR>:echo "Copied" @% "to clipboard"<CR>')

  -- Reflow text
  utils.map('v', '<Leader>R', ':gq<CR>')

  -- telescope
  local telescopeBuiltin = require('telescope.builtin')

  local function live_grep(search_dirs)
    return function()
      telescopeBuiltin.live_grep({ search_dirs = search_dirs })
    end
  end

  local function find_files(search_dirs)
    return function()
      telescopeBuiltin.find_files({ search_dirs = search_dirs, hidden = true })
    end
  end

  local function fuzzy_find()
    return function()
      telescopeBuiltin.current_buffer_fuzzy_find({ skip_empty_lines = false })
    end
  end

  utils.map_with_cb('n', '<leader>FF', find_files({}))
  utils.map_with_cb('n', '<leader>FS', find_files({ "src" }))
  utils.map_with_cb('n', '<leader>FT', find_files({ "test", "tests" }))

  utils.map_with_cb('n', '<leader>GG', live_grep({}))
  utils.map_with_cb('n', '<leader>GS', live_grep({ "src" }))
  utils.map_with_cb('n', '<leader>/', fuzzy_find())
  utils.map_with_cb('n', '<leader>GT', live_grep({ "test", "tests" }))

  utils.map_with_cb('n', '<leader>FB', function()
    telescopeBuiltin.buffers({
      sort_mru = true
    })
  end)
  utils.map_with_cb('n', '<leader>FH', telescopeBuiltin.help_tags)

  utils.map_with_cb('n', '<leader>g', function()
    local bufname = vim.api.nvim_buf_get_name(0)
    -- if bufname starts with fugitive, close buffer
    if string.find(bufname, 'fugitive://') == 1 then
      vim.cmd("q")
      print('closing diff')
    else
      -- else execute :Gdiffsplit
      vim.cmd("Gdiffsplit")
      print('showing diff')
    end
  end)
end

G.mapleader = M.MAP_LEADER

return M
