local orgmode = require('orgmode')
local M = {
  setup = function()
    orgmode.setup_ts_grammar()
    orgmode.setup({
      org_default_notes_file = vim.env.HOME .. '/.org/refile.org'
    })
  end
}

return M
