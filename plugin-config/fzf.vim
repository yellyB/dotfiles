let g:fzf_buffers_jump = 1  " fzf 버퍼 목록에서 이동(0: 현재 창에 버퍼 열림, 1: 기존 버퍼 창 열기)

" fzf 설정: 파일 검색 후 새 탭에서 열기
command! -bang -complete=dir -nargs=* SearchedFileOpenInNewTab
  \ call fzf#run(
    \ fzf#vim#with_preview({
      \ 'sink': 'tabedit'
    \ }), <bang>0)


