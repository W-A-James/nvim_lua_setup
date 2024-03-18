local dap = require('dap')

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
end

return M
