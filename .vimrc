call plug#begin()

  Plug 'preservim/nerdtree'          " 디렉토리 탐색 플러그인
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  Plug 'neovim/nvim-lspconfig'       " LSP 클라이언트 설정 플러그인
  Plug 'hrsh7th/nvim-cmp'            " 자동완성 플러그인
  Plug 'hrsh7th/cmp-nvim-lsp'        " LSP 소스 연결
  Plug 'hrsh7th/cmp-buffer'          " 버퍼 소스
  Plug 'hrsh7th/cmp-path'            " 파일 경로 완성
  Plug 'hrsh7th/cmp-vsnip'           " Snippet 지원
  Plug 'hrsh7th/vim-vsnip'           " Snippet 엔진

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'numToStr/Comment.nvim'                                " 주석 플러그인
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'          " 주석 플러그인: tsx 용
  Plug 'nvim-lua/plenary.nvim'                                " 플러그인 의존성
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }    " 코드 액션 UI
  Plug 'nvim-telescope/telescope-ui-select.nvim'              " 코드 액션 UI

  Plug 'github/copilot.vim'          " copilot for vim
  Plug 'f-person/git-blame.nvim'     " git blame 플러그인

  " UI 플러그인
  Plug 'Xuyuanp/nerdtree-git-plugin'    " Git 상태를 표시하는 플러그인
  Plug 'ryanoasis/vim-devicons'         " 아이콘을 표시하는 플러그인
  Plug 'mawkler/modicator.nvim'         " 모드를 표시하는 플러그인
  Plug 'nvim-lualine/lualine.nvim'      " 상태 표시줄 플러그인
  Plug 'nvim-tree/nvim-web-devicons'    " 아이콘 표시 플러그인
  Plug 'Mofiqul/vscode.nvim'            " vscode theme
  
call plug#end()



let g:NERDTreeShowIcons = 1   " NERDTree 아이콘 활성화
let g:NERDTreeGitStatus = 1   " NERDTree에서 git 상태 표시
let NERDTreeShowHidden=1      " 숨김 파일 표시
"autocmd VimEnter * NERDTree  " vim 실행시 NERDTree 자동 열기

" git blame 설정
let g:gitblame_message_template = '<summary> • <date> • <author>'   " git blame 메시지 템플릿
let g:gitblame_date_format = '%r'                                   " git blame 날짜 형식
let g:gitblame_highlight_group = "Question"
let g:NERDTreeWinSize = 40

let g:fzf_buffers_jump = 1  " fzf 버퍼 목록에서 이동


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
colorscheme vscode


nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <C-P> :SearchedFileOpenInNewTab<CR>

nnoremap <s-h> gT 	" : 탭 전환. 오른쪽
nnoremap <s-l> gt

nnoremap b[ <cmd>bp<cr> 	" : 버퍼 목록 탐색. <cmd>는 : 
nnoremap b] <cmd>bn<cr>

nnoremap <C-h> <C-w>h   " : 창 전환. 왼쪽
nnoremap <C-j> <C-w>j   " : 창 전환. 아래
nnoremap <C-k> <C-w>k   " : 창 전환. 위
nnoremap <C-l> <C-w>l   " : 창 전환. 오른쪽

" 대소문자 구분/구분없이 검색하는 fzf 키 매핑
nnoremap <silent> <Leader>f :call fzf#vim#grep('ag --nogroup --column --color ' . expand('<cword>'))<CR>
nnoremap <silent> <Leader>F :call fzf#vim#grep('ag --nogroup --column --color --ignore-case ' . expand('<cword>'))<CR>
xnoremap <silent> <Leader>f "ty:call fzf#vim#grep('ag --nogroup --column --color "' . escape(@t, '/') . '"')<CR>
xnoremap <silent> <Leader>F "ty:call fzf#vim#grep('ag --nogroup --column --color --ignore-case "' . escape(@t, '/') . '"')<CR>
nnoremap <leader>bb :Buffers<CR>
" Ctrl+Shift+F를 눌렀을 때 전체 검색
nnoremap <silent> <Leader><C-F> :Ag<CR>

nnoremap <leader>f :call <SID>NERDTreeFindOrClose()<CR>
nnoremap <leader>e :NERDTreeToggle<CR>
xnoremap <leader>/ y/<C-r>0<CR>  " Visual 모드에서 선택한 텍스트 바로 검색(\+/)

nnoremap <leader>qf :lua vim.lsp.buf.code_action()<CR>  " Quick Fix 단축키


" 하이라이트 그룹 설정
highlight TabLineSel guifg=#ffffff guibg=#007acc gui=bold
highlight TabLine guifg=#bbbbbb guibg=#4d4d4d


" 탭 라인 설정"
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

    " 파일 이름에 저장되지 않은 변경이 있는 경우 * 표시
    let modified = getbufvar(buflist[winnr - 1], "&mod") ? '[*]' : ''
    let s .= bufname != '' ? fnamemodify(bufname, ':t') . modified : '[No Name]'  " 파일 이름만 표시:t / 경로 표시: p
    let s .= ' '
  endfor
  return s
endfunction


" Point current file in NERDTree
function! s:NERDTreeFindOrClose()
  if &filetype ==# 'nerdtree'
    :NERDTreeClose
  else
    :NERDTreeFind
  endif
endfunction


" fzf 설정: 파일 검색 후 새 탭에서 열기
command! -bang -complete=dir -nargs=* SearchedFileOpenInNewTab
  \ call fzf#run(
    \ fzf#vim#with_preview({
      \ 'sink': 'tabedit'
    \ }), <bang>0)


" copilot enabled status for specific filetypes
let g:copilot_filetypes = {
  \ 'markdown': v:true,
  \ 'yaml': v:true,
  \ 'gitcommit': v:true,
  \ }

runtime! plugin-config/*.lua
