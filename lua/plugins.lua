vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use) 
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
  use 'projekt0n/github-nvim-theme'


  -- Autocompletion

  use 'neovim/nvim-lspconfig'
  use {
    'hrsh7th/nvim-cmp',
  }

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'

  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'

  use 'simrat39/rust-tools.nvim'
  use { 'nvim-orgmode/orgmode',
    config = function()
      require('orgmode').setup{}
    end
  }
end)
