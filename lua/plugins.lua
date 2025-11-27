local ensure_lazy = function()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
    vim.opt.rtp:prepend(lazypath)
    return true
  end
  vim.opt.rtp:prepend(lazypath)
  return false
end

local lazy_bootstrap = ensure_lazy()

if lazy_bootstrap then
  require("lazy").sync()
end

return require("lazy").setup({
  spec = {
    {"wbthomason/packer.nvim"},
    { "nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate" },
    -- Git integration
    {'tpope/vim-fugitive'},
    {'airblade/vim-gitgutter'},

  -- Lualine
   { 'nvim-lualine/lualine.nvim', dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true } },

  -- nvim-tree
  {'kyazdani42/nvim-web-devicons'},
   {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
  },

  -- Theming
  {'sainnhe/gruvbox-material'},
  {'projekt0n/github-nvim-theme'},
  {'EdenEast/nightfox.nvim'},
  {'dracula/vim'},
  { "catppuccin/nvim",  name = "catppuccin" },
  {'hiphish/rainbow-delimiters.nvim'},
  { 'machakann/vim-colorscheme-tatami',  name = "tatami" },
  { 'xfyuan/nightforest.nvim',  name = "nightforest" },

  -- Autocompletion and LSP integration

  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-cmdline'},
  {'hrsh7th/nvim-cmp'},

  -- luasnip
  {'saadparwaiz1/cmp_luasnip'},
  {'L3MON4D3/LuaSnip'},
  {"rafamadriz/friendly-snippets"},

   {
    'nvim-telescope/telescope.nvim',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },

  {'mfussenegger/nvim-dap'},
  {'leoluz/nvim-dap-go'},
   { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap', "nvim-neotest/nvim-nio" } },
   { "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
   {
    "microsoft/vscode-js-debug",
    lazy = true,
    run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
  },
  {'theHamsta/nvim-dap-virtual-text'},

  -- Hugo support
  {'phelipetls/vim-hugo'},
  {'ap/vim-css-color'},

  -- Tidal cycles
  {'https://github.com/tidalcycles/vim-tidal'},

  -- Local plugins
  {'https://gitlab.com/W-A-James/nvim-hugo-utils'},
  },
  checker = { enabled = true, notify=false },
  performance = {
    rtp = {
      disabled_plugins = {
        "tutor"
      }
    }
  }
})

