local dap = require('dap')
local dap_utils = require('dap.utils')
local dap_vscode_js = require('dap-vscode-js')
local M = {}

function M.setup()
  dap_vscode_js.setup({
    adapters = { 'pwa-node', 'node-terminal' }
  })

  dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = { os.getenv('HOME') .. '/tools/vscode-node-debug2/out/src/nodeDebug.js' },
  }

  local function get_mocha_pid()
    local output = io.popen("ps ah | sed --quiet --regexp-extended '{s/([0-9]+).*npm exec mocha.*inspect(-brk)?/\1/; /^[0-9]+$/p}'")
    local pid
    if output ~= nil then
      pid = output:read("*a")
      output:close()
      return pid
    else
      return -1
    end
  end

  dap.configurations.typescript = {
    {
      name = 'Launch',
      type = 'pwa-node',
      request = 'launch',
      runtimeExecutable = 'npx',
      runtimeArgs = {'mocha -n inspect-brk'},
      program = '${file}',
      cwd = vim.fn.getcwd(),
      protocol = 'inspector',
      sourceMaps = true,
      console = 'integratedTerminal',
      internalConsoleOptions = 'neverOpen'
    },
    {
      name = 'Attach to process',
      type = 'pwa-node',
      request = 'attach',
      protocol = 'inspector',
      processId = dap_utils.pick_process,
      console = 'integratedTerminal',
      internalConsoleOptions = 'neverOpen'
    },
    {
      name = 'Attach to mocha',
      type = 'pwa-node',
      request = 'attach',
      sourceMaps = true,
      protocol = 'inspector',
      processId = get_mocha_pid,
      console = 'integratedTerminal',
      internalConsoleOptions = 'neverOpen'
    }
  }

  dap.configurations.javascript = dap.configurations.typescript
end

return M
