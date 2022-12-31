vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'}}
  -- Git integration
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'

  -- Lualine 
  use {'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt=true}}

  -- nvim-tree
  use 'kyazdani42/nvim-web-devicons'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
  }

  -- conjure
  use 'Olical/conjure'

  -- Theming
  use 'sainnhe/gruvbox-material'
  use 'projekt0n/github-nvim-theme'
  use 'EdenEast/nightfox.nvim'
  use 'dracula/vim'

  -- Autocompletion and LSP integration

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'

  -- luasnip
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'

  use 'simrat39/rust-tools.nvim'
  use { 'nvim-orgmode/orgmode',
    config = function()
      require('orgmode').setup{}
    end
  }
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.0',
  requires = { {'nvim-lua/plenary.nvim'} }
}
end)
