" require before load:
"   syntax on
"   set background=...


" set colorscheme's name
let g:colors_name = expand ('<sfile>:t:r')


" reset!!
highlight clear
if exists ("syntax_on")
  syntax reset
endif


" バッファ外の~を消す
highlight link EndOfBuffer Ignore

if &background ==# 'dark'

  highlight LineNr ctermfg=8 ctermbg=none cterm=none
  highlight CursorLineNr ctermfg=7 ctermbg=0 cterm=none

  " カーソル行の色
  highlight CursorLine ctermfg=none ctermbg=0 cterm=none

  " ステータスラインの色設定
  highlight StatusLine ctermfg=4 ctermbg=none cterm=bold,reverse

endif


