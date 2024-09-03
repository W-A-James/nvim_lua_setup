local dap = require('dap')
local dap_utils = require('dap.utils')
local dap_vscode_js = require('dap-vscode-js')
local M = {}

function M.setup()
  dap_vscode_js.setup({
    adapters = { 'pwa-node', 'node-terminal' }
  })

  local function get_mocha_pid()
    local output = io.popen(
      "ps ah | sed --quiet --regexp-extended '{s/ *([0-9]+).*npm exec mocha.*inspect(-brk)?/\1/; /^[0-9]+$/p}'")
    local pid
    if output ~= nil then
      pid = output:read("*a")
      output:close()
      return pid
    else
      return -1
    end
  end

  local function get_node_pid()
    --local output = io.popen(
    --"ps ah | sed --quiet --regexp-extended '{s/ *([0-9]+).*node .*--inspect(-brk)?.*/\1/; /^[0-9]+$/p}'")
    local output = io.popen(
      "ps ah | awk -F ' ' '/node.* --inspect(-brk)/ && $5 != \"awk\" && $5 != \"gawk\" {print $1}'")
    local pid
    if output ~= nil then
      pid = output:read("*a")
      output:close()
      return pid
    else
      return -1
    end
  end

  for _, lang in ipairs({ 'typescript', 'javascript' }) do
    dap.configurations[lang] = {
      {
        name = 'Attach to process',
        type = 'pwa-node',
        request = 'attach',
        protocol = 'inspector',
        processId = dap_utils.pick_process,
        console = 'integratedTerminal',
        internalConsoleOptions = 'neverOpen',
        justMyCode = false,
      },
      {
        name = 'Attach to Mocha',
        type = 'pwa-node',
        request = 'attach',
        sourceMaps = true,
        protocol = 'inspector',
        continueOnAttach = true,
        processId = get_mocha_pid,
        console = 'integratedTerminal',
        internalConsoleOptions = 'neverOpen',
        justMyCode = false,
      },
      {
        name = 'Attach to Node',
        type = 'pwa-node',
        request = 'attach',
        sourceMaps = true,
        protocol = 'inspector',
        continueOnAttach = true,
        processId = get_node_pid,
        console = 'integratedTerminal',
        internalConsoleOptions = 'neverOpen',
        justMyCode = false,
      },
      {
        name = 'Launch unit test with Mocha',
        type = 'pwa-node',
        request = 'launch',
        --protocol = 'inspector',
        runtimeExecutable = 'node',
        runtimeArgs = { '--inspect', '--no-lazy', '--require', 'ts-node/register/transpile-only', './node_modules/mocha/bin/mocha.js', '${file}' },
        rootPath = '${workspaceFolder}',
        cwd = '${workspaceFolder}',
        console = 'integratedTerminal',
        internalConsoleOptions = 'neverOpen',
      },
      {
        name = 'Launch integration test with Mocha',
        type = 'pwa-node',
        request = 'launch',
        --protocol = 'inspector',
        runtimeExecutable = 'node',
        runtimeArgs = { '--inspect', '--no-lazy', '--require', 'ts-node/register/transpile-only', './node_modules/mocha/bin/mocha.js', '--config', './test/mocha_mongodb.json', '${file}' },
        rootPath = '${workspaceFolder}',
        cwd = '${workspaceFolder}',
        console = 'integratedTerminal',
        internalConsoleOptions = 'neverOpen',
      },
      {
        name = 'Launch with ts-node',
        type = 'pwa-node',
        request = 'launch',
        runtimeExecutable = 'node',
        runtimeArgs = { '--inspect', '--no-lazy', '--require', 'ts-node/register/transpile-only' },
        cwd = '${workspaceFolder}',
        program = '${file}',
      }
    }
  end
end

return M
