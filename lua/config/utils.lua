local M = {
  G = vim.g,
  set = vim.opt
}

--------- Key mapping utils -----------
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

--------- End Key mapping utils -----------

function M.has_value(arr, value)
  for idx, val in ipairs(arr) do
    if val == value then
      return true
    end
  end
  return false
end

function M.dump(object)
  if type(object) == 'table' then
    local s = '{ '
    for k, v in pairs(object) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. '[' .. k .. '] = ' .. M.dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(object)
  end
end

function M.wordcount()
  return tostring(vim.fn.wordcount().words) .. " words"
end

function M.is_markdown()
  return vim.bo.filetype == "markdown"
end

return M
