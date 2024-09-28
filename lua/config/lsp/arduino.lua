local lspconfig = require('lspconfig')
local M = {}

function M.setup(flags, on_attach)
  local home = os.getenv('HOME')
  lspconfig.arduino_language_server.setup({
    flags = flags,
    on_attach = on_attach,
    cmd = {
      home .. "/dev/tools/arduino-language-server/arduino-language-server",
      "-cli", home .. "/bin/arduino-cli",
      "-cli-config", home .. "/.arduino15/arduino-cli.yaml",
      "-clangd", "/usr/bin/clangd-14",
      "-fqbn", "esp32:esp32:featheresp32"
    }
  })
end

return M
