local M = {
  setup = function()
    require("nvim-tree").setup {
      git = {
        ignore = false
      },
    }
end
}

return M
