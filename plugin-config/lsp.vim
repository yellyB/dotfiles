lua <<EOF
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  lspconfig.ts_ls.setup {
    capabilities = capabilities,
  }
  lspconfig.gdscript.setup {
    capabilities = capabilities,
  }
  -- format on save
  vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
          local mode = vim.api.nvim_get_mode().mode
          local filetype = vim.bo.filetype
          if vim.bo.modified == true and mode == 'n' then
              vim.cmd('lua vim.lsp.buf.format()')
          else
          end
      end
  })
EOF
