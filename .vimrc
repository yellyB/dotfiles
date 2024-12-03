call plug#begin()

Plug 'preservim/nerdtree'          " 디렉토리 탐색 플러그인

Plug 'neovim/nvim-lspconfig'       " LSP 클라이언트 설정 플러그인
Plug 'neovim/nvim-lspconfig'       " LSP 클라이언트 설정 플러그인

Plug 'hrsh7th/nvim-cmp'            " 자동완성 플러그인
Plug 'hrsh7th/cmp-nvim-lsp'        " LSP 소스 연결
Plug 'hrsh7th/cmp-buffer'          " 버퍼 소스
Plug 'hrsh7th/cmp-path'            " 파일 경로 완성
Plug 'hrsh7th/cmp-vsnip'           " Snippet 지원
Plug 'hrsh7th/vim-vsnip'           " Snippet 엔진

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'github/copilot.vim'          " copilot for vim

" Plug 'sainnhe/sonokai'             " sonokai theme
Plug 'tomasiser/vim-code-dark'     " code dark theme
" Plug 'Mofiqul/vscode.nvim'     " vscode theme

call plug#end()



set hlsearch
set number
set clipboard+=unnamed    " Yanking goes on the clipboard instead.

" Tab settings
set smarttab              " Smarter tab levels
set tabstop=2             " Set the default tabstop
set expandtab             " Make tabs into spaces (set by tabstop)
set shiftwidth=2          " Set the default shift width for indents
set softtabstop=2

" Tabline 설정
set showtabline=2           " 항상 탭라인을 표시
set tabpagemax=10           " 최대 탭 페이지 수

" 현재 파일 이름 표시
set tabline=%!MyTabLine()

set t_Co=256
set t_ut=
colorscheme codedark
" " sonokai 테마 설정
" " Important!!
" if has('termguicolors')
"   set termguicolors
" endif
" colorscheme sonokai




nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <C-P> :GFiles<CR>


nnoremap <s-h> gT 	" : 탭 전환. 오른쪽
nnoremap <s-l> gt

nnoremap [b <cmd>bp<cr> 	" : 버퍼 목록 탐색. <cmd>는 : 
nnoremap ]b <cmd>bn<cr>




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
lspconfig.ts_ls.setup {
  capabilities = capabilities,
}
EOF



function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " 현재 탭 강조 표시
        let tabnr = i + 1
        let s .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')

        " 탭 번호와 파일 이름
        let s .= ' ' . tabnr . ' '
        let buflist = tabpagebuflist(tabnr)
        let winnr = tabpagewinnr(tabnr)
        let bufname = bufname(buflist[winnr - 1])
        let s .= bufname != '' ? fnamemodify(bufname, ':t') : '[No Name]'
        let s .= ' '
    endfor
    return s
endfunction


