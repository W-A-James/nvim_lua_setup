local set = vim.opt
local G = vim.g

vim.cmd [[
  packadd termdebug
  tnoremap <Esc> <C-\><C-n>
]]

---------------------------Indentation-----------------------------------------

set.tabstop=2
set.shiftwidth=2
set.softtabstop=2
set.expandtab=true
set.smarttab=true
set.foldmethod='indent'
set.foldenable=false
set.foldnestmax=40
set.foldlevel=40

--------------------------Quality of life---------------------------------------

set.number = true
set.mouse = 'a'
set.colorcolumn = '80'
set.cursorline = true
set.encoding = 'utf-8'
set.splitbelow = true
set.splitright = true
set.termguicolors = true
set.laststatus = 3

G.mapleader = ' '
-------------------------Backup locations---------------------------------------
set.backupdir='.backup/.~/.backup,/tmp//'
set.backupdir='.swp/.~/.swp/,/tmp//'
set.undodir='.undo/.~/.undo/./tmp//'

vim.g.backupdir='~/.backup'
vim.g.directory='~/.swp'
vim.g.undodir='~/.undo'

------------------------Load plugins--------------------------------------------
require('plugins')
require('lsp')
require('completion')
------------------------Gruvbox material theming--------------------------------
set.background='dark'
G['gruvbox_material_background'] = 'hard'
G['gruvbox_material_better_performance'] = '1'
G['gruvbox_material_enable_bold'] = '1'
G['gruvbox_material_enable_italic'] = '1'
G['gruvbox_material_transparent_background'] = '0'

vim.cmd "colorscheme nightfox"


-- Lualine setup
require('lualine').setup ({
})

---------------------------Set spell checking-----------------------------------

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.md", "*.txt"},
  callback = function()
    set.spell = true
  end
})



---------------------------Treesitter-------------------------------------------
require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting=false
  }
}

---------------------------nvim orgmode----------------------------------------
require('orgmode').setup_ts_grammar()
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'}
  },
  ensure_installed = {'org'}
}

require('orgmode').setup({
  org_agenda_files = {'~/org/*'},
  org_default_notes_file = '~/org/refile.org'
})

---------------------------nvim-tree--------------------------------------------
require("nvim-tree").setup {
  git = {
    ignore = false
  },
}
