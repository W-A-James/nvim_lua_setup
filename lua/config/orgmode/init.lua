local orgmode = require('orgmode')
local M = {
  setup = function()
    orgmode.setup_ts_grammar()
    orgmode.setup({
      org_default_notes_file = vim.env.HOME .. '/notes/org/refile.org',
      org_todo_keywords = { 'TODO', 'IN_PROGRESS', '|', 'DONE', 'GONE_AWAY'},
      win_split_mode = 'tabnew'
    })
  end
}

return M
