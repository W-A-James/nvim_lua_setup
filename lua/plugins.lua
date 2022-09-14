vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function() 
  use 'wbthomason/packer.nvim'
  use {'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'}}
  -- Git integration
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'

  -- Lualine 
  use {'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt=true}}

  -- nvim-tree 
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
  }

  -- Theming
  use 'sainnhe/gruvbox-material'
  use 'EdenEast/nightfox.nvim'

  -- Autocompletion

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-cmdline'

  -- luasnip

  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
end)
