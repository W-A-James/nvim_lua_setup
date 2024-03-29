local M = {
  setup = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = "all",
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting={'org'}
      }
    }
  end
}

return M
