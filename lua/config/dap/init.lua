local utils = require('config.utils')
local mappings = require('config.keymap').DAP_MAPPINGS
local dapui = require('dapui')
local dapvirtual = require('nvim-dap-virtual-text')

local M = {}

local function configureUI()
  dapui.setup()
  dapvirtual.setup({})
  vim.fn.sign_define('DapBreakpoint', { text = '' })
end

local function configureAdapters()
  require('config.dap.node').setup()
  require('config.dap.go').setup()
end

local function configureKeymaps()
  for _, mapping in ipairs(mappings) do
    local mode, keystrokes, cb = mapping[1], mapping[2], mapping[3]
    utils.map_with_cb(mode, keystrokes, cb)
  end
end

function M.setup()
  configureAdapters()
  configureKeymaps()
  configureUI()
end

return M
