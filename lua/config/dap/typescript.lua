local dap = require('dap')
local dap_utils = require('dap.utils')
local M = {}

function M.setup()
  dap.adapters.node2= {
    type = 'executable',
    command = 'node',
    args = {os.getenv('HOME') .. '/tools/vscode-node-debug2/out/src/nodeDebug.js'},
  }

  local function get_mocha_pid()
    local output = io.popen("ps ah | rg -e 'npm exec mocha.*inspect-brk' | head -1 | awk -F ' ' '{ print $1 }'")
    local pid = output:read("*a")
    output:close()
    return pid
  end

  dap.configurations.typescript= {
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
    },
    {
      name = 'Attach to mocha',
      type = 'node2',
      request = 'attach',
      processId = get_mocha_pid
    }
  }
end

return M
