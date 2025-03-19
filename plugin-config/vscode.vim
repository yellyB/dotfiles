lua <<EOF
local vscode = require('vscode')
local c = require('vscode.colors').get_colors()

vscode.setup({
  group_overrides = {
    -- @tag.builtin
    ['@tag'] = {fg = c.vscBlueGreen, bg = 'NONE' },
  },
})
vscode.load()
EOF
