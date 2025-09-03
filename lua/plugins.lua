local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use { 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } }

  -- Git integration
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'

  -- Lualine
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }

  -- nvim-tree
  use 'kyazdani42/nvim-web-devicons'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
  }

  -- Theming
  use 'sainnhe/gruvbox-material'
  use 'projekt0n/github-nvim-theme'
  use 'EdenEast/nightfox.nvim'
  use 'dracula/vim'
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'hiphish/rainbow-delimiters.nvim'
  use { 'machakann/vim-colorscheme-tatami', as = "tatami" }
  use { 'xfyuan/nightforest.nvim', as = "nightforest" }

  -- Autocompletion and LSP integration

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  -- luasnip
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use "rafamadriz/friendly-snippets"

  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use 'mfussenegger/nvim-dap'
  use 'leoluz/nvim-dap-go'
  use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap', "nvim-neotest/nvim-nio" } }
  use { "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } }
  use {
    "microsoft/vscode-js-debug",
    opt = true,
    run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
  }
  use 'theHamsta/nvim-dap-virtual-text'

  -- Hugo support
  use 'phelipetls/vim-hugo'
  use 'ap/vim-css-color'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
