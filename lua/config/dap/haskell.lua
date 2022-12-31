local dap = require('dap')
local M = {}

function M.setup()
  dap.adapters.haskell = {
    type = 'executable',
    command = 'haskell-debug-adapter',
    args = {'--hackage-version=0.0.33.0'},
  }

  dap.configuration.haskell = {
    {
      type = 'haskell',
      request = 'launch',
      name = 'Debug',
      workspace = '${workspaceFolder}',
      startup = '${file}',
      stopOnEntry = true,
      logFile = vim.fn.stdpath('data') .. '/haskell-dap.log',
      logLevel = 'WARNING',
      ghciEnv = vim.empty_dict(),
      ghciPrompt = '> ',
      ghciCmd = 'stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show',
    }
  }
end

return M
