local M = {}

function M.setup(flags, on_attach)
  local rust_tools_opts = {
    tools = {
      autoSetHints = true,
      -- hover_with_actions = true,
      inlay_hints = {
        show_parameter_hints = true,
        parameter_hints_prefix = "<-- ",
        other_hints_prefix = "--> ",
        highlight = "Comment"
      },
    },
    server = {
      flags = flags,
      on_attach = on_attach,
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy"
        }
      }
    }
  }

  require('rust-tools').setup(rust_tools_opts)
end

return M
