local utils = require('config.utils')
local mappings = require('config.keymap').DAP_MAPPINGS

local M = {}

local function configureAdapters()
  require('config.dap.haskell').setup()
  require('config.dap.node').setup()
  require('config.dap.typescript').setup()
end

local function configureKeymaps()
  for _, mapping in ipairs(mappings)
  do
    local mode, keystrokes, cb = mapping[1], mapping[2], mapping[3]
    utils.map_with_cb(mode, keystrokes, cb)
  end
end

function M.setup ()
  configureAdapters()
  configureKeymaps()
end

return M
