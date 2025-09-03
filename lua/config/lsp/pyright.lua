local lspconfig = require('lspconfig')
local M = {}

local function getvenv(path)
  return vim.fn.isdirectory(path)
end

local pythonPath = ""

if getvenv("./venv") == 1 then
  pythonPath = "./venv/bin/python3"
else
  if getvenv('./.venv') == 1 then
    pythonPath = "./.venv/bin/python3"
  end
end

function M.setup(flags, on_attach)
  lspconfig.pyright.setup({
    flags = flags,
    on_attach = on_attach,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          autoImportCompletions = true,
          useLibraryCodeForTypes = true
        },
        pythonPath = pythonPath
      }
  }
  })
end

return M
