lua <<EOF
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  lspconfig.ts_ls.setup {
    capabilities = capabilities,
  }
  lspconfig.gdscript.setup {
    capabilities = capabilities,
  }
EOF
