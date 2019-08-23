set encoding=utf-8
scriptencoding utf-8

" *******************************
" **  dein.vim
" *******************************

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state ('~/.cache/dein')
  call dein#begin ('~/.cache/dein')

  " requires
  call dein#add ('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " completion
  call dein#add ('Shougo/deoplete.nvim')

  " make deoplete use dictionary
  call dein#add ('deoplete-plugins/deoplete-dictionary')

  " snippets
  call dein#add ('Shougo/neosnippet.vim')

  " default snippets
  "call dein#add('Shougo/neosnippet-snippets')

  " asynchronous lint engine
  call dein#add ('w0rp/ale')

  " 色コードを色で表示
  call dein#add ('gorodinskiy/vim-coloresque')

  call dein#end ()
  call dein#save_state ()
endif

" auto install new plugin
if dein#check_install ()
  call dein#install ()
endif

" *******************************
" **  (v'-')っ First Initialize
" *******************************

" ファイル別のプラグインを有効化
" ファイル別のインデントを有効化
filetype plugin indent on

" syntaxを有効化
syntax on


" *******************************
" **  plugin settings
" *******************************

let g:deoplete#enable_at_startup = 1
call deoplete#custom#source ('dictionary', 'matchers', ['matcher_head'])
call deoplete#custom#source ('dictionary', 'rank', 999)
call deoplete#custom#source ('_', 'sorters', ['sorter_rank', 'sorter_word'])

let g:neosnippet#snippets_directory = '~/.config/nvim/snippets'
" which disables all runtime snippets
let g:neosnippet#disable_runtime_snippets = { '_' : 1 }

let g:ale_linters = {'cpp': ['clang']}
let g:ale_cpp_clang_options = "-std=c++14 -Weverything -Wno-c++98-compat-pedantic -Wno-c11-extensions -Wno-unused-macros -Wno-unused-const-variable -pedantic-errors"


" *******************************
" **  autocmd
" *******************************

" turn off IME when leave insert mode
augroup resetIME
  autocmd!
  autocmd InsertLeave * silent !fcitx-remote -c
augroup END

" auto reload vimrc
augroup auto-reload-vimrc
  autocmd!
  autocmd BufWritePost *init.vim source ${MYVIMRC}
augroup END

augroup dictionary
  autocmd!
  autocmd FileType cpp setlocal dictionary+=~/.config/nvim/dictionary/cpp.dict
augroup END

augroup auto-save
  autocmd!
  autocmd CursorHold,InsertLeave * silent call <SID>AutoSaveIfPossible ()
augroup END

augroup file-reload
  autocmd!
  autocmd InsertEnter,WinEnter * checktime
augroup END


" *******************************
" **  set
" *******************************

" width of EAW
"set ambiwidth=double

" audoindent
set autoindent

" 編集中のファイルが外部で変更されたらそれを自動で読み込む
set autoread

" set background dark
" ※注意: ここでcolorschemeがリロードされるのでこれ以前のhighlightコマンドは上書きされる
set background=dark

" enable Backspace to delete 'auto indent', EOL, and start
set backspace=indent,eol,start

" don't create backup file
set nobackup

" Cのインデントオプション
" Labelのインデントを深くしない
" アクセス修飾子のインデントを深くしない
" templateのインデントを深くしない
set cinoptions+=:0,g0,t0

" 補完の種類
set complete=.,w,b,u,k,s,i,d,t

" ユーザ定義補完関数
"set completefunc=

" completion option
" menuone: use popup menu even though there is only one match.
" preview: show extra information
" noinsert: do not insert until select
" noselect: do not select
"set completeopt=menuone,preview,noinsert
set completeopt=menuone,preview,noselect

" concealを有効にするモード
" n: normal
" v: visual (not recommend)
" i: insert (not recommend)
" c: command line editing
set concealcursor=nc

" if 0, disable conceal
"set conceallevel

" 保存せずに終了しようとした時に確認を行う
set confirm

" 既存行のインデント構造をコピーする
" Tab文字で構成されている場合は新しい行のインデントもTab文字で構成する
set copyindent

" show cursor column
"set cursorcolumn

" show cursor line
set cursorline

" dictionary
"set dictionary=

" replace Tab with spaces
set expandtab

" :bでバッファを切り替えるときに保存しなくてもよくなる
set hidden

" 検索時に大文字と小文字を区別しない
set ignorecase

" 入力中に検索を開始する
set incsearch

" キーワード (\k)
" ハイフン(-)もキーワードとみなす
set iskeyword+=-

" show status line
" if 2, always
set laststatus=2

" 空白文字の可視化
" visualize space character
set list

" set listで表示する文字
set listchars=tab:»\ ,trail:_,nbsp:%

" 括弧の対応
set matchpairs=(:),{:},[:]

" showmatchのジャンプ時間(1 = 0.1sec)
"set matchtime=2

" enable mouse
" 'a' means enable in all mode
set mouse=a

" show line number
set number

"
"set omnifunc=

" インデントを減らそうとした時、すでに存在するインデント構造を破壊しない
" ただし、インデントを増やした場合はTabとspaceの混合になるので注意
set preserveindent

" 補完メニューの高さを制限する
" if 0, limit.
set pumheight=25

" 相対行番号
"set relativenumber

" show position of cursor
set ruler

" <>などでインデント調整時にshiftwidthの倍数に丸める
set shiftround

" indent width
" if 0, the same as tabstop.
set shiftwidth=2

" display inputting command on lower right
set showcmd

" 括弧入力時に対応する括弧に一瞬ジャンプしない（うざい）
set noshowmatch

" 大文字で検索した時は大文字と小文字を区別する
set smartcase

" かしこい
set smartindent

" かしこい
set smarttab

" Tab幅がsofttabstopであるかのように見えるようになる
" Tabを押した時にsofttabstopの幅だけspacesを挿入する
" Backspaceでsofttabstopの幅だけspacesを削除する
" if 0, disable this feature
" if negative, the same as shiftwidth
set softtabstop=-1

" enable spell check
"set spell

" 日本語をスペルチェック対象外にする
set spelllang=en,cjk

" 分割した時に下側に新しいウインドウを表示
"set splitbelow

" 分割した時に右側に新しいウインドウを表示
"set splitright

" format of status line
set statusline=%F\ %m%r%h%w%=[FORMAT=%{&ff}]\ %y\ (%3v,%3l)\ [%2p%%]

" do not create swap file
set noswapfile

" tab width
set tabstop=8

" CursorHoldの発動ラグ
set updatetime=1000

" 移動キーなどで行をまたいで移動する
" b: <BS>
" s: <Space>
" <: <Left>
" >: <Right>
" [: <Left> in insert mode
" ]: <Right> in insert mode
set whichwrap=b,s,<,[

" charater which starts completion in command line
set wildchar=<Tab>

" When set case is ignored when completing file names and directories.
set wildignorecase

" display wild command completion 
set wildmenu

" Tabを押すごとに次のmatchを補完する
set wildmode=full

" wrap
set wrap

" search loop
set wrapscan


" *******************************
" **  colorscheme
" *******************************

" colorscheme読み込み時に必ずやるはずだからいらない処理
" colorschemeをreset
" colorschemeを設定しないとき用(?)
highlight clear
if exists ("syntax_on")
  syntax reset
endif

" colorschemeの設定
" note: colorscheme defaultはbackgroundを書き換えるクソなのでdefaultがいい場合は何も読み込まないことを推奨
" 読み込み失敗してもエラーを吐かないように例外処理
try
  colorscheme fantasy_happiness
catch /:E185:/
endtry


" *******************************
" **  keymap
" *******************************

" 保存せずに破棄の誤爆防止
nnoremap ZQ <Nop>

" 中ボタンによる貼り付けを無効
nnoremap <MiddleMouse> <Nop>
vnoremap <MiddleMouse> <Nop>

" Ctrl-Cによる挿入モードからの離脱を禁止
" （InsertLeaveが呼ばれないので内部状態がおかしくなる）
inoremap <C-c> <Nop>

" ビジュアルモードでCtrl-Aで全選択
vnoremap <C-a> ggoG

" 選択中にCtrl-Cでクリップボードにコピー
vnoremap <C-c> "+y

" Shift-Tabでインデントを1つ減らす
nnoremap <S-Tab> <<

" Shift-Yで行末までヤンク
nnoremap Y y$

" 選択モードで選択中の範囲を囲む
" ()
xnoremap <Plug>(surround)( "zc(<C-r><C-o>z)<Esc>
xmap <Plug>(surround)) <Plug>(surround)(
" {}
xnoremap <Plug>(surround){ "zc{<C-r><C-o>z}<Esc>
xmap <Plug>(surround)} <Plug>(surround){
" []
xnoremap <Plug>(surround)[ "zc[<C-r><C-o>z]<Esc>
xmap <Plug>(surround)] <Plug>(surround)[
" <>
xnoremap <Plug>(surround)< "zc<<C-r><C-o>z><Esc>
xmap <Plug>(surround)> <Plug>(surround)<
" ""
xnoremap <Plug>(surround)" "zc"<C-r><C-o>z"<Esc>
" ''
xnoremap <Plug>(surround)' "zc'<C-r><C-o>z'<Esc>
" ``
xnoremap <Plug>(surround)` "zc`<C-r><C-o>z`<Esc>

xmap s <Plug>(surround)

" for neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" ポップアップ補完メニューが表示されているときは次の候補を選択
imap <expr><Tab> pumvisible () ? '<C-n>' : neosnippet#expandable_or_jumpable () ? '<Plug>(neosnippet_expand_or_jump)' : TabKey ()
smap <expr><Tab> neosnippet#expandable_or_jumpable () ? '<Plug>(neosnippet_expand_or_jump)' : '<Tab>'

" ポップアップ補完メニューが表示されているときは前の候補を選択
" それ以外はインデントを1つ下げる
inoremap <expr><S-Tab> pumvisible () ? '<C-p>' : '<C-d>'

" ポップアップ補完メニューが表示されているときは確定
"inoremap <expr><CR> pumvisible () ? '<C-y>' : KamiCR ()
imap <expr><CR> pumvisible () ? neosnippet#expandable () ? '<Plug>(neosnippet_expand)' : '<C-y>' : CRKey ()

" 括弧の対応の補完
inoremap <expr>( CursorChar () !~ '\k' ? '()<Left>' : '('
"inoremap <expr>( LeftParenthesis ()
inoremap <expr>) CursorChar () ==# ')' ? '<Right>' : ')'
"inoremap <expr>) RightParenthesis (')')

inoremap <expr>[ CursorChar () !~ '\k' ? '[]<Left>' : '['
inoremap <expr>] CursorChar () ==# ']' ? '<Right>' : ']'

inoremap <expr>{ CursorChar () !~ '\k' ? '{}<Left>' : '{'
inoremap <expr>} CursorChar () ==# '}' ? '<Right>' : '}'

"inoremap <expr>> CursorChar () ==# '>' ? '<Right>' : '>'

inoremap <expr>" CursorChar () ==# '"' ? '<Right>' : CursorChar () !~ '\k' && PreCursorString () =~ '[ ([{,]$' ? '""<Left>' : '"'

inoremap <expr>' CursorChar () ==# '''' ? '<Right>' : CursorChar () !~ '\k' && PreCursorString () =~ '[ ([{,]$' ? '''''<Left>' : ''''

inoremap <expr>` CursorChar () ==# '`' ? '<Right>' : CursorChar () !~ '\k' && PreCursorString () =~ '[ ([{,]$\\|^$' ? '``<Left>' : '`'

" 括弧の対応を一気に消します
inoremap <expr><BS> KamiBackspace ()
inoremap <expr><Del> KamiDelete ()

" いいかんじの'/'
inoremap <expr>/ KamiSlash ()

" 重複したスペースの入力ができなくなります
" 入力したい場合は<C-v><Space>
"inoremap <expr><Space> BanDuplicateSpace ()


" インデントを考慮した<Home>
nnoremap <expr>0 PreCursorString () =~ '^\s*$' ? '0' : '^'
nnoremap <expr><Home> PreCursorString () =~ '^\s*$' ? '<Home>' : '^'
inoremap <expr><Home> PreCursorString () =~ '^\s*$' ? '<Home>' : '<C-o>^'

" auto complete
" 文字列化してexecuteしないとkeyがキーとして解釈されてしまう
"for key in split ("1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM_",'\zs')
"  execute "inoremap <expr>" . key . " AutoComplete ('" . key . "')"
"endfor

"augroup insert-custom
"  autocmd!
"  autocmd InsertEnter * let b:last_cursor_moved = v:false
"  autocmd CursorMovedI * let b:last_cursor_moved = v:true
"  autocmd InsertCharPre * let b:last_cursor_moved = v:false
"augroup END


" *******************************
" **  function!
" *******************************

" auto complete
" 2文字目から自動補完開始
" htmlタグかもしれないときは'>'も挿入する
function! AutoComplete (key)
  if pumvisible ()
    return a:key
  else
    let l:pre = PreCursorString ()
    if l:pre =~ '\k$'
      return a:key . "\<C-n>"
    elseif IsRightAngleBracketInsertable (l:pre , CursorChar ())
      return a:key . ">\<Left>"
    else
    return a:key
endfunction

" カーソル位置の文字
function! CursorChar ()
  return matchstr (getline ('.') , '.' , col ('.') - 1)
endfunction

" カーソル位置までの文字列(直下を含まない)
function! PreCursorString ()
  let l:pos = col ('.') - 1
  if l:pos == 0
    return ''
  else
    return getline ('.')[:l:pos - 1]
  endif
endfunction

" 神Tab
" キーワードなら補完開始
" スラッシュならファイル名補完開始
" それ以外はTab
function! TabKey ()
  let l:pre = PreCursorString ()
  if l:pre =~ '\k$'
    return "\<C-n>"
  elseif l:pre =~ '/$'
    return "\<C-x>\<C-f>"
  else
    return "\<Tab>"
  endif
endfunction

" 神CR
function! CRKey ()
  let l:pre = PreCursorString ()
  let l:cur = CursorChar ()
  if l:pre =~ '{$' && l:cur ==# '}'
    return "\<CR>\<Up>\<End>\<CR>"
  elseif l:pre =~ '`$' && l:cur ==# '`'
    return "``\<CR>``\<Up>\<End>\<CR>"
  else
    return "\<CR>"
  endif
endfunction

" 括弧の対応の消去
function! s:KamiDelete_impl (key)
  let l:pre = PreCursorString ()
  let l:cur = CursorChar ()
  if (l:pre =~ '($' && l:cur ==# ')') || (l:pre =~ '[$' && l:cur ==# ']') || (l:pre =~ '{$' && l:cur ==# '}') || (l:pre =~ '<$' && l:cur ==# '>') || (l:pre =~ '"$' && l:cur ==# '"') || (l:pre =~ '''$' && l:cur ==# '''') || (l:pre =~ '`$' && l:cur ==# '`')
    return "\<BS>\<Del>"
  else
    return a:key
  endif
endfunction

" 神Backspace
function! KamiBackspace ()
  return s:KamiDelete_impl ("\<BS>")
endfunction

" 神Delete
function! KamiDelete ()
  return s:KamiDelete_impl ("\<Delete>")
endfunction

" 神/
" カミツルギではない
function! KamiSlash ()
  let l:pre = PreCursorString ()
  if l:pre =~ '[/*\\]$'
    return '/'
  elseif l:pre =~ '<$'
    if &omnifunc != ''
      return "/\<C-x>\<C-o>\<C-y>"
    else
      return '/'
    endif
  else
    return "/\<C-x>\<C-f>"
endfunction

" ban duplicate space
"function! BanDuplicateSpace ()
"  if PreCursorString () =~ ' $'
"    return ''
"  elseif CursorChar () ==# ' '
"    return "\<Right>"
"  else
"    return "\<Space>"
"  endif
"endfunction

" '>'が自動挿入できるかどうか
" htmlタグ用
function! IsRightAngleBracketInsertable (pre,cur)
  return a:pre =~ '<$' && a:cur !~ '\k' && a:cur !=# '>'
endfunction

" 自動保存
function! s:AutoSaveIfPossible ()
  if &modified && &filetype != 'gitcommit' && filewritable (expand ('%'))
    write
  endif
endfunction

