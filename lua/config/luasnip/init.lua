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
          "    src=\"\"",
          "    alt=\"\"",
          "    caption=\"\" >}}"
      })
    }),
     -- Checkbox
      ls.s("ch", {
        ls.t (
          " * [ ]"
        )
      }),
    -- Filler text
      ls.s("lipsum", {
        ls.t({
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada ultricies nulla eget dictum.",
          "Fusce pharetra sit amet felis bibendum varius. Cras sit amet pellentesque arcu, ut mollis elit.",
          "Pellentesque quis ornare tortor, eu cursus velit. Vestibulum malesuada vehicula ornare.",
          "Vivamus sed posuere diam, vitae malesuada eros. Maecenas nibh augue, mollis eget ligula sit amet, consectetur luctus quam.",
          "Aenean feugiat vulputate egestas. Donec vel interdum augue, a aliquet ante.",
          "Mauris semper vel tortor sit amet maximus. Vestibulum ut ipsum consectetur, auctor sapien id, ornare arcu."
        })
      })
  }
  }
)
end

return M
