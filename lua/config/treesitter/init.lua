local M = {
  setup = function()
    local version = vim.version()
    if (version.major >= 10) then
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "c", "vim", "typescript", "python", "go", "arduino", "lua", "javascript", "vim", "vimdoc", "markdown", "markdown_inline" },
        sync_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { 'org' }
        }
      }
    end
  end
}

return M
