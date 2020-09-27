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

  " 行番号
  highlight LineNr ctermfg=8 ctermbg=none cterm=none

  " カーソル行番号
  highlight CursorLineNr ctermfg=7 ctermbg=0 cterm=none

  " カーソル行
  highlight CursorLine ctermfg=none ctermbg=0 cterm=none

  " カーソル列
  highlight CursorColumn ctermfg=none ctermbg=0 cterm=none

  " モード表示
  highlight ModeMsg ctermfg=4 ctermbg=none cterm=bold

  " 補完ポップアップ
  highlight Pmenu ctermfg=12 ctermbg=0 cterm=none

  " 補完ポップアップ選択中アイテム
  highlight PmenuSel ctermfg=0 ctermbg=229 cterm=none

  " ステータスライン
  highlight StatusLine ctermfg=4 ctermbg=none cterm=bold,reverse

  " ステータスライン（非アクティブ）
  highlight StatusLineNC ctermfg=240 ctermbg=none cterm=bold,reverse

  " 選択範囲
  highlight Visual ctermfg=none ctermbg=0 cterm=none

  " コマンドライン選択中補完候補
  highlight WildMenu ctermfg=11 ctermbg=none cterm=none,reverse


  " コメント
  highlight Comment ctermfg=7 ctermbg=none cterm=none


  " 定数
  highlight Constant ctermfg=3 ctermbg=none cterm=none

  " 文字列
  highlight String ctermfg=10 ctermbg=none cterm=none


  " 識別子
  highlight Identifier ctermfg=12 ctermbg=none cterm=none

  " 関数
  highlight Function ctermfg=12 ctermbg=none cterm=none


  " 文(ifなど)
  highlight Statement ctermfg=13 ctermbg=none cterm=none

  " ラベル
  highlight Label ctermfg=13 ctermbg=none cterm=none

  " 演算子
  highlight Operator ctermfg=14 ctermbg=none cterm=none


  " プリプロセッサ
  highlight PreProc ctermfg=13 ctermbg=none cterm=none


  " 型
  highlight Type ctermfg=11 ctermbg=none cterm=none


  " 特殊なシンボル
  highlight Special ctermfg=9 ctermbg=none cterm=none

  " エラー
  highlight Error ctermfg=15 ctermbg=9 cterm=none

  " Todo
  highlight Todo ctermfg=16 ctermbg=229 cterm=none

  " Conceal
  highlight Conceal ctermfg=111 ctermbg=none cterm=none
endif

