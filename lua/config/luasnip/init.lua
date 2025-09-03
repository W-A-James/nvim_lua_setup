local ls = require('luasnip');

local M = {}

function M.setup()
  require("luasnip.loaders.from_vscode").lazy_load()
  ls.add_snippets(nil, {
    typescript = {
      ls.s(
        "clientBefore", {
          ls.t({
            "let client: MongoClient;",
            "",
            "beforeEach(async function() {)",
            "  client = this.configuration.newClient();",
            "  await client.connect();",
            "});"
          }),
        }
      )
    },
    org = {
      ls.s(
        "check", {
          ls.t(
            ' * [ ]'
          )
        }
      )
    },
    -- Used in hugo markdown
    markdown = {
      -- Figure
      ls.s("fig", {
        ls.t({
          "{{< figure",
          "src=\"\"",
          "alt=\"\"",
          "caption=\"\"",
          ">}}"
      })
    }),
     -- Checkbox
      ls.s("ch", {
        ls.t (
          " * [ ]"
        )
      })
  }
  }
)
end

return M
