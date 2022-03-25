vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function() 
  use 'wbthomason/packer.nvim'
  use {'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'}}

  -- Git integration
  use 'tpope/vim-fugitive'

  -- Lualine 
  use {'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt=true}}

  -- Nerdtree
  use 'preservim/nerdtree'
  use 'Xuyuanp/nerdtree-git-plugin'
  use 'ryanoasis/vim-devicons'


  -- Theming
  use 'sainnhe/gruvbox-material'


  -- Autocompletion

  use 'neovim/nvim-lspconfig'
  use {
    'hrsh7th/nvim-cmp', requires= {
      {'kdheepak/cmp-latex-symbols'}
    },
    sources= {
      {name='latex_symbols'}
    }
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'

  use 'lervag/vimtex'
  use 'ziglang/zig.vim'
end)
