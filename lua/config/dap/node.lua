local dap = require('dap')
local dap_utils = require('dap.utils')
local M = {}

function M.setup()
  dap.adapters.node2= {
    type = 'executable',
    command = 'node',
    args = {os.getenv('HOME') .. '/tools/vscode-node-debug2/out/src/nodeDebug.js'},
  }

  dap.configurations.javascript= {
    {
      name = 'Launch',
      type = 'node2',
      request = 'launch',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      protocol = 'inspector',
      sourceMaps = true,
      console = 'integratedTerminal'
    },
    {
      name = 'Attach to process',
      type = 'node2',
      request = 'attach',
      processId = dap_utils.pick_process
    }
  }
end

return M
