local set = vim.opt
local G = vim.g
G.mapleader = ' '

require('plugins')
require('lsp')

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
set.colorcolumn = '100'
set.cursorline = true
set.encoding = 'utf-8'
set.splitbelow = true
set.splitright = true
set.termguicolors = true
--set.laststatus=3

-------------------------Backup locations---------------------------------------

set.backupdir='.backup/.~/.backup,/tmp//'
set.backupdir='.swp/.~/.swp/,/tmp//'
set.undodir='.undo/.~/.undo/./tmp//'

vim.g.backupdir='~/.backup'
vim.g.directory='~/.swp'
vim.g.undodir='~/.undo'

------------------------Gruvbox material theming--------------------------------
set.background='dark'
G['gruvbox_material_background'] = 'hard'
G['gruvbox_material_better_performance'] = '1'
G['gruvbox_material_enable_bold'] = '1'
G['gruvbox_material_enable_italic'] = '1'
G['gruvbox_material_transparent_background'] = '0'

vim.cmd "colorscheme nightfox"

-------------------------NVIM web dev icons-------------------------------------
require('nvim-web-devicons').setup({
  default = true
})
-- Lualine setup
require('lualine').setup({
  options = {
    globalstatus = false,
    tabline = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_d = {'windows', 'tabs'}
    }
  }
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

---------------------------nvim-tree--------------------------------------------
require("nvim-tree").setup {
  git = {
    ignore = false
  },
}
