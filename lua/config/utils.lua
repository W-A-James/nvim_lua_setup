local M = {
  G = vim.g,
  set = vim.opt
}

function M.map(mode, keystrokes, effect)
    local opts = {noremap = true, silent=true}
    vim.api.nvim_set_keymap(mode, keystrokes, effect, opts)
end

function M.map_with_cb(mode, keystrokes, callback)
  local opts = {noremap=true, silent=true, callback=callback}
  vim.api.nvim_set_keymap(mode, keystrokes, '', opts)
end

function M.buffer_map_with_cb(mode, keystrokes, bufferNumber, callback)
  local opts = {silent = true, noremap = true, callback = callback}
  vim.api.nvim_buf_set_keymap(bufferNumber, mode, keystrokes, '', opts)
end

return M
