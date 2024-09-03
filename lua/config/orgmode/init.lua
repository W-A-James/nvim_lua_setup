local orgmode = require('orgmode')
local M = {
  setup = function()
    orgmode.setup({
      org_agenda_files = {'~/notes/org/*'},
      org_default_notes_file = '~/notes/org/notes.org',
      org_todo_keywords = { 'TODO', 'WORKING', '|', 'DONE', 'GONE_AWAY' },
      win_split_mode = 'vsplit',
      org_capture_templates = {
        t = {
          description = 'Task',
          template = '* TODO %?',
          target = '~/notes/org/todo.org'
        },
        T = {
          description = 'Ticket',
          template = '* NODE-%?\n** Description\n\n** Acceptance Criteria\n\n*** Implementation Requirements\n\n*** Testing Requirements\n\n** Kickoff Notes\n\n*** Implementation Notes\n\n*** Testing Notes',
          target = '~/notes/org/tickets.org'
        },
        n = {
          description = 'Note',
          template = '%U\n %?',
          target = '~/notes/org/notes.org'
        },
        k = {
          description = 'Kickoff',
          template = '* NODE-%?\n** Implementation Notes\n\n** Testing Notes',
          target = '~/notes/org/kickoff.org'
        }
      }
    })
  end
}

return M

