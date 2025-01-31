let g:NERDTreeShowIcons = 1   " NERDTree 아이콘 활성화
let g:NERDTreeGitStatus = 1   " NERDTree에서 git 상태 표시
let NERDTreeShowHidden=1      " 숨김 파일 표시
"autocmd VimEnter * NERDTree  " vim 실행시 NERDTree 자동 열기
let g:NERDTreeWinSize = 40

nnoremap <leader>E :NERDTreeToggle<CR>
nnoremap <leader>e :call <SID>NERDTreeFindOrClose()<CR>

" Point current file in NERDTree
function! s:NERDTreeFindOrClose()
  if &filetype ==# 'nerdtree'
    :NERDTreeClose
  else
    :NERDTreeFind
  endif
endfunction


