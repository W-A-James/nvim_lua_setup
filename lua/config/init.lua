local M = {
  setup = function()
    require('plugins')

    require('config.keymap').setup()

    require('config.theme').setup()
    require('config.editor').setup()

    require('config.completion').setup()
    require('config.lsp').setup()

    require('config.nvim-tree').setup()
    require('config.treesitter').setup()

    require('config.dap').setup()

    require('config.orgmode').setup()
  end
}

return M
