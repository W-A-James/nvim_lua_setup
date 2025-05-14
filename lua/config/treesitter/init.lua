local M = {
  setup = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { "typescript", "bash", "json", "yaml", "c", "cpp", "go", "javascript", "python", "rst", "markdown", "markdown_inline", "gitignore", "git_config", "git_rebase", "lua"},
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'org' }
      }
    }
  end
}

return M
