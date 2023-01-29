local lspconfig = require('lspconfig')
local M

function M.setup(flags, on_attach)
  lspconfig.arduino_language_server.setup({
    flags = flags,
    on_attach = on_attach,
    cmd = {
      "~/bin/arduino-language-server",
      "-cli-config", "~/.arduino15/arduino-cli.yaml",
      "-cli", "~/bin/arduino-cli",
      "-clangd", "/usr/bin/clangd-14",
      "-cli-daemon-addr", "localhost:50051"
    }
  })
end

return M
