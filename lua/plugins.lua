vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'}}
  -- Git integration
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'

  use 'kyazdani42/nvim-web-devicons'
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

  -- Autocompletion and LSP integration

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'

  -- Rust
  use 'simrat39/rust-tools.nvim'

  -- luasnip
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  vim.opt.completeopt = { "menu", "menuone", "noselect" }
end)
