call plug#begin()

" 디렉토리 탐색
Plug 'preservim/nerdtree'                                     " 디렉토리 탐색
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" LSP 관련
Plug 'neovim/nvim-lspconfig'                                  " LSP 클라이언트 설정 
Plug 'hrsh7th/nvim-cmp'                                       " 자동완성 플러그인
Plug 'hrsh7th/cmp-nvim-lsp'                                   " LSP 소스 연결
Plug 'hrsh7th/cmp-buffer'                                     " 버퍼 소스
Plug 'hrsh7th/cmp-path'                                       " 파일 경로 완성
Plug 'hrsh7th/cmp-vsnip'                                      " Snippet 지원
Plug 'hrsh7th/vim-vsnip'                                      " Snippet 엔진

" 코드 분석
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}   " 문법 강조 
Plug 'nvim-telescope/telescope.nvim'                          " 코드 액션 UI
Plug 'nvim-telescope/telescope-ui-select.nvim'                " 코드 액션 UI
Plug 'nvim-lua/plenary.nvim'                                  " 플러그인 의존성  

" 코드 편집
Plug 'numToStr/Comment.nvim'                                  " 주석 플러그인
Plug 'JoosepAlviste/nvim-ts-context-commentstring'            " 주석 플러그인: tsx 용
Plug 'f-person/git-blame.nvim'                                " git 작성 정보

" UI 
Plug 'Xuyuanp/nerdtree-git-plugin'                            " Git 상태를 표시
Plug 'ryanoasis/vim-devicons'                                 " 아이콘을 표시
Plug 'mawkler/modicator.nvim'                                 " 모드를 표시
Plug 'nvim-lualine/lualine.nvim'                              " 상태 표시줄 
Plug 'nvim-tree/nvim-web-devicons'                            " 아이콘 표시
Plug 'lukas-reineke/indent-blankline.nvim'                    " 들여쓰기 표시
Plug 'Mofiqul/vscode.nvim'                                    " vscode theme

" 서드 파티 
Plug 'github/copilot.vim'                                     " copilot for vim
Plug 'tpope/vim-fugitive'                                     " Git 플러그인
Plug 'rbong/vim-flog'

call plug#end()




runtime! plugin-config/*.vim

colorscheme vscode


set hlsearch
set number
set clipboard+=unnamed    " Yanking goes on the clipboard instead.
set whichwrap+=<,>

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


" nnoremap <s-h> gT 	" : 탭 전환. 오른쪽
" nnoremap <s-l> gt

nnoremap <C-h> <C-w>h   " : 창 전환. 왼쪽
nnoremap <C-j> <C-w>j   " : 창 전환. 아래
nnoremap <C-k> <C-w>k   " : 창 전환. 위
nnoremap <C-l> <C-w>l   " : 창 전환. 오른쪽

xnoremap <leader>/ y/<C-r>0<CR>  " Visual 모드에서 선택한 텍스트 바로 검색(\+/)

" Gemini API 호출 함수
function! CallGeminiAPI(prompt)
    let api_key = $GEMINI_API_KEY
    let url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=' . api_key
    
    let data = {
        \ "contents": [{
        \   "parts": [{"text": a:prompt}]
        \ }]
    \ }
    
    let json_data = json_encode(data)
    let cmd = 'curl -s -X POST "' . url . '" -H "Content-Type: application/json" -d ' . shellescape(json_data)
    
    let response = system(cmd)
    let parsed = json_decode(response)
    
    if has_key(parsed, 'candidates') && len(parsed.candidates) > 0
        return parsed.candidates[0].content.parts[0].text
    else
        return "API 호출 실패: " . response
    endif
endfunction

" 선택한 텍스트를 Gemini로 보내기
function! AskGemini() range
    let selected_text = join(getline(a:firstline, a:lastline), "\n")
    let prompt = input("질문: ", "다음 코드를 설명해줘:\n" . selected_text)
    
    if prompt != ""
        echo "Gemini에게 질문 중..."
        let response = CallGeminiAPI(prompt)
        
        " 새 버퍼에 결과 표시
        new
        put =response
        setlocal buftype=nofile
        setlocal bufhidden=wipe
        setlocal noswapfile
    endif
endfunction

" 키 매핑
vnoremap <leader>ai :call AskGemini()<CR>
nnoremap <leader>ai :call AskGemini()<CR>
" [플러그인 숏컷]
" --- fzf ---
" 대소문자 구분 & 구분없이 검색하는 fzf 키 매핑. (ag) (-w: 단어 단위 검색)
" 1: 현재 커서 위치 단어. 대소문자 구분 / 2: 현재 커서 위치 단어. 대소문자 무시 / 3: 선택한 영역. 대소문자 구분 / 4: 선택한 영역. 대소문자 무시
nnoremap <silent> <Leader>f :call fzf#vim#grep('ag --nogroup --column --color -w --case-sensitive ' . expand('<cword>'), fzf#vim#with_preview())<CR>
nnoremap <silent> <Leader>F :call fzf#vim#grep('ag --nogroup --column --color -w ' . expand('<cword>'), fzf#vim#with_preview())<CR>
xnoremap <silent> <Leader>f "ty:call fzf#vim#grep('ag --nogroup --column --color -w --case-sensitive "' . escape(@t, '/') . '"', fzf#vim#with_preview())<CR>
xnoremap <silent> <Leader>F "ty:call fzf#vim#grep('ag --nogroup --column --color -w "' . escape(@t, '/') . '"', fzf#vim#with_preview())<CR>

" Ctrl+Shift+F 로 전체 검색
nnoremap <silent> <C-F> :Ag<CR>

nnoremap <C-P> :SearchedFileOpenInNewTab<CR>

nnoremap <leader>bb :Buffers<CR>
nnoremap b[ <cmd>bp<cr> 	" : 버퍼 목록 탐색. <cmd>는 : 
nnoremap b] <cmd>bn<cr>
nnoremap <silent> <leader>bd :bp \| bd #<CR>  " 현재 창을 버퍼 목록에서 삭제 + 이전 버퍼로 이동


" --- lsp ---
nnoremap qf :lua vim.lsp.buf.code_action()<CR>  " Quick Fix 단축키

" --- NERDTree ---  
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>r :call <SID>NERDTreeFindOrClose()<CR>



" 하이라이트 그룹 설정
highlight TabLineSel guifg=#ffffff guibg=#007acc gui=bold
highlight TabLine guifg=#bbbbbb guibg=#4d4d4d


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


function! s:NERDTreeFindOrClose()
  if &filetype ==# 'nerdtree'
    :NERDTreeClose
  else
    :NERDTreeFind
  endif
endfunction


" copilot enabled status for specific filetypes
let g:copilot_filetypes = {
  \ 'markdown': v:true,
  \ 'yaml': v:true,
  \ 'gitcommit': v:true,
  \ }



