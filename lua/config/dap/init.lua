local utils = require('config.utils')
local configureKeymaps = require('config.keymap').setDAPKeymaps
local dapui = require('dapui')
local dapvirtual = require('nvim-dap-virtual-text')

local M = {}

local function configureUI()
  dapui.setup()
  dapvirtual.setup({})
  vim.fn.sign_define('DapBreakpoint', { text = '' })
  vim.fn.sign_define('DapBreakpointCondition', { text = '' })
  vim.fn.sign_define('DapStopped', { text = '=>' })
  vim.fn.sign_define('DapLogPoint', { text = '' })
end

local function configureAdapters()
  require('config.dap.node').setup()
  require('config.dap.go').setup()
end

function M.setup()
  configureAdapters()
  configureKeymaps()
  configureUI()
end

return M
