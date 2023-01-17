local M = {}

local set = require("config.utils").set
local G = require("config.utils").G

function M.setup()
  ------------------------Gruvbox material theming--------------------------------
  set.background='dark'
  G['gruvbox_material_background'] = 'hard'
  G['gruvbox_material_better_performance'] = '1'
  G['gruvbox_material_enable_bold'] = '1'
  G['gruvbox_material_enable_italic'] = '1'
  G['gruvbox_material_transparent_background'] = '0'

  vim.cmd "colorscheme nordfox"

  -- Lualine setup
  require('lualine').setup ()
end

return M
