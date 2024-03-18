local lspconfig = require('lspconfig')
local M = {}

function M.setup(flags, on_attach)
  HOME = os.getenv('HOME')
  lspconfig.arduino_language_server.setup({
    flags = flags,
    on_attach = on_attach,
    cmd = {
      HOME .."/.local/go/bin/arduino-language-server",
      "-cli-config", HOME .. "/.arduino15/arduino-cli.yaml",
      "-cli", HOME .. "/bin/arduino-cli",
      "-clangd", "/usr/bin/clangd-14",
      "-cli-daemon-addr", "localhost:50051"
    }
  })
end

return M
