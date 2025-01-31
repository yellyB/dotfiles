let g:fzf_buffers_jump = 1  " fzf 버퍼 목록에서 이동(0: 현재 창에 버퍼 열림, 1: 기존 버퍼 창 열기)

" 대소문자 구분 & 구분없이 검색하는 fzf 키 매핑
" 1: 현재 커서 위치 단어. 대소문자 구분 / 2: 현재 커서 위치 단어. 대소문자 무시 / 3: 선택한 영역. 대소문자 구분 / 4: 선택한 영역. 대소문자 무시
nnoremap <silent> <Leader>f :call fzf#vim#grep('ag --nogroup --column --color ' . expand('<cword>'))<CR>
nnoremap <silent> <Leader>F :call fzf#vim#grep('ag --nogroup --column --color --ignore-case ' . expand('<cword>'))<CR>
xnoremap <silent> <Leader>f "ty:call fzf#vim#grep('ag --nogroup --column --color "' . escape(@t, '/') . '"')<CR>
xnoremap <silent> <Leader>F "ty:call fzf#vim#grep('ag --nogroup --column --color --ignore-case "' . escape(@t, '/') . '"')<CR>

nnoremap <leader>bb :Buffers<CR>

nnoremap b[ <cmd>bp<cr> 	" : 버퍼 목록 탐색. <cmd>는 : 
nnoremap b] <cmd>bn<cr>

" Ctrl+Shift+F 로 전체 검색
nnoremap <silent> <C-S-F> :Ag<CR>
nnoremap <C-P> :SearchedFileOpenInNewTab<CR>

" fzf 설정: 파일 검색 후 새 탭에서 열기
command! -bang -complete=dir -nargs=* SearchedFileOpenInNewTab
  \ call fzf#run(
    \ fzf#vim#with_preview({
      \ 'sink': 'tabedit'
    \ }), <bang>0)


