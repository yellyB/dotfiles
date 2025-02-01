lua <<EOF
  local highlight = {
      "Highlight",
      "Whitespace",
      "CoursorColumn",
  }

  local hooks = require "ibl.hooks"
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "Highlight", { fg = "#464646" })  -- 커서 scope 색상
      vim.api.nvim_set_hl(0, "Whitespace", { fg = "#303030" })  --그 외 scope 색상
      vim.api.nvim_set_hl(0, "CoursorColumn", { fg = "#61AFEF" })
  end)


  vim.g.rainbow_delimiters = { highlight = highlight }
  require("ibl").setup { scope = { highlight = highlight } }

  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
EOF
