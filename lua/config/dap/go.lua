local dap = require('dap')
local dapgo = require('dap-go')

local M = {}

function M.setup()
  dap.adapters.go = {
    type = 'executable',
    command = 'node',
    args = { os.getenv('HOME') .. '/dev/tools/vscode-go/extension/dist/debugAdapter.js' },
  }
  dap.configurations.go = {
    {
      type = 'go',
      name = 'Debug',
      request = 'launch',
      showLog = false,
      program = "${file}",
      dlvToolPath = vim.fn.exepath('dlv') -- Adjust to where delve is installed
    },
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
