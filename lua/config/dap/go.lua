local dap = require('dap')
local dapgo = require('dap-go')

local M = {}

function M.setup()
  dap.adapters.go = {
    type = 'executable',
    command = 'node',
    args = { os.getenv('HOME') .. '/dev/tools/vscode-go/extension/dist/debugAdapter.js' },
  }
  dapgo.setup({
    dap_configurations = {
      {
        type = "go",
        name = "Attach remote",
        mode = "remote",
        request = "attach",
      },
    },
    delve = {
      path = "dlv",
      intialize_timeout_sec = 20,
      port = "${port}",
      args = {},
      build_flags = ""
    }
  })
end

return M
