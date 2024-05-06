local M = {}

local set = require("config.utils").set
local G = require("config.utils").G
local JS_DIRS = require("config.utils").javascript_dirs
local has_value = require("config.utils").has_value

local function configureTermDebug()
  vim.cmd [[
    packadd termdebug
    tnoremap <Esc> <C-\><C-n>
  ]]
end

function M.setup()
  -- Indentation
  set.tabstop = 2
  set.shiftwidth = 2
  set.softtabstop = 2
  set.expandtab = true
  set.smarttab = true
  set.foldmethod = 'indent'
  set.foldenable = false
  set.foldnestmax = 40
  set.foldlevel = 40

  -- Quality of life
  set.number = true
  set.mouse = 'a'

  set.textwidth = 100
  set.colorcolumn = '100'
  -- set.wrap = true
  -- set.linebreak = true
  -- set.list = false

  set.showtabline = 2
  set.cursorline = true
  set.encoding = 'utf-8'
  set.splitbelow = true
  set.splitright = true
  set.termguicolors = true
  set.laststatus = 2

  -------------------------Backup locations-------------------------------------
  set.backupdir = '.backup/.~/.backup,/tmp//'
  set.backupdir = '.swp/.~/.swp/,/tmp//'
  set.undodir = '.undo/.~/.undo/./tmp//'

  G.backupdir = '~/.backup'
  G.directory = '~/.swp'
  G.undodir = '~/.undo'

  ---------------------------Set spell checking-----------------------------------
  set.spell = true

  ------------------------Restore session if pressent----------------------------
  --[[
  vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
      for i, f in ipairs(vim.fs.dir(vim.api.nvim_getcwd())) do
        -- Check if this is a session
      end
    end
  })

  ]]
  --

  configureTermDebug()

  -- Setup telescope to ignore certain folders
  if has_value(JS_DIRS, vim.fn.getcwd()) then
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = {
          "docs"
        }
      }
    })
  end
end

return M
