local M = {
  G = vim.g,
  set = vim.opt
}

function M.map(mode, keystrokes, effect)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap(mode, keystrokes, effect, opts)
end

function M.map_with_cb(mode, keystrokes, callback)
  local opts = { noremap = true, silent = true, callback = callback }
  vim.api.nvim_set_keymap(mode, keystrokes, '', opts)
end

function M.buffer_map_with_cb(bufferNumber, mode, keystrokes, callback)
  local opts = { silent = true, noremap = true, callback = callback }
  vim.api.nvim_buf_set_keymap(bufferNumber, mode, keystrokes, '', opts)
end

function M.has_value(arr, value)
  for idx, val in ipairs(arr) do
    if val == value then
      return true
    end
  end
  return false
end

M.javascript_dirs = {
  '/home/wajames/node_driver',
  '/home/wajames/js-bson'
}

return M
