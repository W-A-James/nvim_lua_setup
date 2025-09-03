local M = {}

local set = require("config.utils").set
local G = require("config.utils").G
local is_markdown = require("config.utils").is_markdown
local wordcount = require("config.utils").wordcount

function M.setup()
  ------------------------Gruvbox material theming--------------------------------
  set.background = 'dark'
  G['gruvbox_material_background'] = 'soft'
  G['gruvbox_material_better_performance'] = '1'
  G['gruvbox_material_enable_bold'] = '1'
  G['gruvbox_material_enable_italic'] = '1'
  G['gruvbox_material_transparent_background'] = '1'

  vim.cmd "colorscheme dawnforest"

  -- Lualine setup
  require('lualine').setup({
    sections = {
      lualine_z = {
        { "location" },
        { wordcount, cond = is_markdown }
      }
    }
  })

  -- Rainbow delimiters
  require('rainbow-delimiters')
end

return M
