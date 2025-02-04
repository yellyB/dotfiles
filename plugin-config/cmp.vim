lua <<EOF
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)  -- Snippet 확장
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- 선택 확인
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },  -- LSP 소스
    { name = 'vsnip' },     -- Snippet 소스
  }, {
    { name = 'buffer' },    -- 버퍼 소스
    { name = 'path' },      -- 파일 경로 소스
  })
})
EOF
