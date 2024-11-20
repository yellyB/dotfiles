call plug#begin()


Plug 'neovim/nvim-lspconfig'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'       " LSP 클라이언트 설정 플러그인
Plug 'hrsh7th/nvim-cmp'            " 자동완성 플러그인
Plug 'hrsh7th/cmp-nvim-lsp'        " LSP 소스 연결
Plug 'hrsh7th/cmp-buffer'          " 버퍼 소스
Plug 'hrsh7th/cmp-path'            " 파일 경로 완성
Plug 'hrsh7th/cmp-vsnip'           " Snippet 지원
Plug 'hrsh7th/vim-vsnip'           " Snippet 엔진

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()



set hlsearch
set number
set clipboard+=unnamed    " Yanking goes on the clipboard instead.


nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <C-P> :GFiles<CR>




lua << EOF
local lspconfig = require('lspconfig')
local cmp = require('cmp')

-- nvim-cmp 설정
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)  -- Snippet 확장
    end,
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),  -- 다음 항목
    ['<C-p>'] = cmp.mapping.select_prev_item(),  -- 이전 항목
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

-- LSP와 nvim-cmp 연결
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- TypeScript 설정
lspconfig.tsserver.setup {
  capabilities = capabilities,
}
EOF





