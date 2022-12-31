local utils = require('config.utils')
local mappings = require('config.keymap').DAP_MAPPINGS

local M = {}

local function configureAdapters()
  require('config.dap.haskell').setup()
end

local function configureKeymaps()
end

function M.setup ()
  configureAdapters()
end

return M
