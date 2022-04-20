require('plugins')

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

-------------------------Backup locations---------------------------------------
--
set.backupdir='.backup/.~/.backup,/tmp//'
set.backupdir='.swp/.~/.swp/,/tmp//'
set.undodir='.undo/.~/.undo/./tmp//'

vim.g.backupdir='~/.backup'
vim.g.directory='~/.swp'
vim.g.undodir='~/.undo'


G['NERDTreeShowHidden'] = '1'

------------------------Gruvbox material theming--------------------------------
set.background='dark'
G['gruvbox_material_background'] = 'hard'
G['gruvbox_material_better_performance'] = '1'
G['gruvbox_material_enable_bold'] = '1'
G['gruvbox_material_enable_italic'] = '1'
G['gruvbox_material_transparent_background'] = '0'

vim.cmd [[
	colorscheme gruvbox-material
]]


G.mapleader = ' '

-- Lualine setup
require('lualine').setup ({
  options = {
    theme = "gruvbox-material",
    section_separators = '',
    component_separators = '',
  }
})

require('lsp')
require('completion')


vim.cmd [[
  function! SetOcamlFormat()
    nnoremap <leader>f :w<CR> :!ocamlformat -i %<CR><CR>:e<CR>
  endfunction

  autocmd BufRead,BufNewFile *.ml call SetOcamlFormat()
]]

vim.cmd [[
  function! SetRustDebugger()
      let g:termdebugger="rust-gdb"
      tnoremap s is<CR><ESC>
      tnoremap o io<CR><ESC>
      tnoremap c ic<CR><ESC>
      nnoremap <c-b> :Break<CR>
  endfunction

  autocmd BufRead,BufNewFile *.rs call SetRustDebugger()
]]


---------------------------Set spell checking-----------------------------------
vim.cmd [[
  autocmd BufRead,BufNewFile *.md,*.txt setlocal spell
]]


---------------------------Treesitter-------------------------------------------
require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting=false
  }
}
