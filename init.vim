set encoding=utf-8
scriptencoding utf-8


" *******************************
" **  env
" *******************************

if empty ($XDG_CONFIG_HOME)
  let $XDG_CONFIG_HOME = $HOME . '/.config'
endif

if empty ($XDG_CACHE_HOME)
  let $XDG_CACHE_HOME = $HOME . '/.cache'
endif

let s:nvim_directory = $XDG_CONFIG_HOME . '/nvim'
let s:dein_directory = $XDG_CACHE_HOME . '/dein'


" *******************************
" **  dein.vim
" *******************************

" install dein automatically
if !isdirectory (s:dein_directory)
  call system ('curl -s https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh | sh -s -- ' . s:dein_directory)
endif

let s:dein_repo_directory = s:dein_directory . '/repos/github.com/Shougo/dein.vim'

" add dein path in runtimepath
"execute 'set runtimepath+=' . s:dein_directory . '/repos/github.com/Shougo/dein.vim'
"let &runtimepath = s:dein_repo_directory . ',' . &runtimepath
let &runtimepath = &runtimepath . ',' . s:dein_repo_directory


if dein#load_state (s:dein_directory)
  call dein#begin (s:dein_directory)

  " requires
  call dein#add (s:dein_repo_directory)

  " colorscheme
  " call dein#add ('cocopon/iceberg.vim')

  " LSP client, completion
  call dein#add ('neoclide/coc.nvim', {'merged': 0, 'rev': 'release'})

  " completion
  "call dein#add ('Shougo/deoplete.nvim')

  " make deoplete use dictionary
  "call dein#add ('deoplete-plugins/deoplete-dictionary')

  " snippets
  "call dein#add ('Shougo/neosnippet.vim')

  " default snippets
  "call dein#add ('Shougo/neosnippet-snippets')

  " asynchronous lint engine
  "call dein#add ('w0rp/ale')

  " customize statusline
  call dein#add ('itchyny/lightline.vim')

  " visible indent
  "call dein#add ('Yggdroot/indentLine')

  " 色コードを色で表示
  call dein#add ('gorodinskiy/vim-coloresque')

  " toggle comment
  call dein#add ('tpope/vim-commentary')

  " syntax
  " call dein#add ('sheerun/vim-polyglot')

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

runtime! init/*.vim

filetype plugin indent on
syntax on

" *******************************
" **  コマンド
" *******************************
command! Reload source ${MYVIMRC}

command! -nargs=* Hterminal botright split new | resize 15 | terminal <args>
command! -nargs=* Vterminal botright vertical new | terminal <args>

command! -nargs=* W w <args>

" root権限に昇格して書き込み
cnoreabbrev w!! w !sudo -S tee > /dev/null %

" *******************************
" **  plugin settings
" *******************************

if dein#tap ('lightline.vim')
  let g:lightline = {
        \   'colorscheme': 'wombat',
        \   'active': {
        \     'left': [
        \       [ 'mode', 'paste' ],
        \       [ 'readonly', 'absolutepath', 'modified' ]
        \     ],
        \     'right': [
        \       [ 'lineinfo' ],
        \       [ 'percent' ],
        \       [ 'fileformat', 'fileencoding', 'filetype' ],
        \       [ 'cocstatus' ]
        \     ]
        \   },
        \   'component_function': {
        \     'cocstatus': 'coc#status'
        \   },
        \   'tab': {
        \     'active': ['filename', 'modified'],
        \     'inactive': ['filename', 'modified']
        \   },
        \   'enable': { 'tabline': 0 }
        \ }
endif

if dein#tap('coc.nvim')
  let g:coc_global_extensions = [
        \ 'coc-lists',
        \ 'coc-vimlsp',
        \ 'coc-json',
        \ 'coc-tsserver',
        \ 'coc-deno',
        \]

  augroup coc-config
    autocmd!
    autocmd CursorHold * silent call CocActionAsync ('highlight')
  augroup END
endif

" 上のヘルプコメントを隠す
let g:netrw_banner = 0
" tree形式で表示
let g:netrw_liststyle = 3
" サイズ表示を1024baseなK,M,G表記にする
let g:netrw_sizestyle = "H"
" 左右分割を右側に開く
let g:netrw_altv = 1
" 分割で開いたときに85%のサイズで開く
let g:netrw_winsize = 15
" 直前に開いていた位置で開く
let g:netrw_browse_split = 4

" jsonのconcealを無効にする
let g:vim_json_conceal = 0

" *******************************
" **  autocmd
" *******************************

" turn off IME when leave insert mode
if executable('fcitx-remote')
  augroup resetIME
    autocmd!
    autocmd InsertLeave * silent !fcitx-remote -c
  augroup END
endif

" auto reload vimrc
augroup auto-reload-vimrc
  autocmd!
  autocmd BufWritePost *init.vim ++nested source ${MYVIMRC}
augroup END

augroup dictionary
  autocmd!
  autocmd FileType cpp setlocal dictionary+=~/.config/nvim/dictionary/cpp.dict
augroup END

"augroup auto_save
"  autocmd!
"  autocmd TextChanged,InsertLeave * silent call auto_save#save ()
"augroup END

augroup auto_mkdir
  autocmd!
  autocmd BufWritePre * call auto_mkdir#mkdir(expand('<afile>:p:h'), v:cmdbang)
augroup END

augroup reload-file
  autocmd!
  autocmd InsertEnter,WinEnter,FocusGained * checktime
augroup END

augroup load-template
  autocmd!
  autocmd BufNewFile *.cpp  execute '0r ' . s:nvim_directory . '/template/.cpp'
  autocmd BufNewFile *.html execute '0r ' . s:nvim_directory . '/template/.html'
  autocmd BufNewFile *.sh execute '0r' . s:nvim_directory . '/template/.sh'
  autocmd BufNewFile pack.mcmeta execute '0r ' . s:nvim_directory . '/template/pack.mcmeta'
augroup END

augroup fix-terminal
  autocmd!
  autocmd TermOpen term://* setlocal nonumber bufhidden=wipe
  autocmd TermOpen,TermEnter,WinEnter term://* startinsert
  autocmd TermClose term://* stopinsert
  autocmd TermClose term://*/zsh bw!
  autocmd TermClose term://*/fish bw!
augroup END

augroup fix-netrw
  autocmd!
  autocmd FileType netrw setlocal bufhidden=wipe
augroup END

augroup fix-filetype
  autocmd!
  autocmd BufNewFile,BufReadPost *.fish setlocal filetype=sh
  autocmd BufNewFile,BufReadPost *.mcmeta setlocal filetype=json
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
set cinoptions& cinoptions+=:0,g0,t0,+0

" share clipboard
if has('unnamedplus')
  set clipboard=unnamedplus
endif

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
set conceallevel=2

" 保存せずに終了しようとした時に確認を行う
set confirm

" 既存行のインデント構造をコピーする
" Tab文字で構成されている場合は新しい行のインデントもTab文字で構成する
set copyindent

" show cursor column
" show cursor line
set nocursorcolumn nocursorline

" dictionary
"set dictionary=

" replace Tab with spaces
set expandtab

" :bでバッファを切り替えるときに保存しなくてもよくなる
set hidden

" 検索時に大文字と小文字を区別しない
set ignorecase

" 置き換え時にプレビュー表示
set inccommand=split

" 入力中に検索を開始する
set incsearch

" キーワード (\k)
" @はアルファベットを表す
" ハイフン(-)もキーワードとみなす
" @自体を追加したい場合は@-@とする(範囲指定)
set iskeyword& iskeyword+=-

" show status line
" if 2, always
set laststatus=2

" 空白文字の可視化
" visualize space character
set list

" set listで表示する文字
set listchars=tab:»\ ,trail:_,nbsp:%

" 括弧の対応
set matchpairs=(:),{:},[:],<:>

" showmatchのジャンプ時間(1 = 0.1sec)
"set matchtime=2

" enable mouse
" 'a' means enable in all mode
set mouse=ar

" show line number
set number

"
"set omnifunc=

" インデントを減らそうとした時、すでに存在するインデント構造を破壊しない
" ただし、インデントを増やした場合はTabとspaceの混合になるので注意
set preserveindent

" 補完メニューの高さを制限する
" if 0, スペースいっぱい使う
set pumheight=25

" Enables pseudo-transparency for the |popup-menu|. Valid values are in
" the range of 0 for fully opaque popupmenu (disabled) to 100 for fully
" transparent background. Values between 0-30 are typically most useful.
" 半透明描画ができないターミナルだと全部透過されて残念な見た目になる…。
set pumblend=0

" 相対行番号
"set relativenumber

" show position of cursor
set ruler

" 環境変数SHELLから自動で設定されるので設定の必要なし
" set shell=fish

" <>などでインデント調整時にshiftwidthの倍数に丸める
set shiftround

" indent width
" if 0, the same as tabstop.
set shiftwidth=2

" c: don't give |ins-completion-menu| messages.
set shortmess& shortmess+=c

" display inputting command on lower right
set showcmd

" 現在の入力モードを表示しない(プラグインでstatuslineに表示するようにしたので)
set showmode

" 括弧入力時に対応する括弧に一瞬ジャンプしない（うざい）
set noshowmatch

" 大文字で検索した時は大文字と小文字を区別する
set smartcase

" 行頭のTabはshiftwidthに、それ以外はtabstopまたはsofttabstopに従う
set smartindent

" かしこい
set smarttab

" Tab幅がsofttabstopであるかのように見えるようになる
" Tabを押した時にsofttabstopの幅だけspacesを挿入する
" Backspaceでsofttabstopの幅だけspacesを削除する
" if 0, disable this feature
" if negative, the same as shiftwidth
set softtabstop=0

" enable spell check
"set spell

" 日本語をスペルチェック対象外にする
set spelllang=en,cjk

" 分割した時に下側に新しいウインドウを表示
"set splitbelow

" 分割した時に右側に新しいウインドウを表示
set splitright

" format of status line
set statusline=%F\ %m%r%h%w%=[FORMAT=%{&ff}]\ %y\ (%3v,%3l)\ [%2p%%]

" do not create swap file
set noswapfile

set tabline=%!tabline#make()

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
set whichwrap=b,s

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

" Make a backup before overwriting a file.
set nowritebackup

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
" note: colorscheme defaultはbackgroundを書き換えるのでdefaultがいい場合は何も読み込まないことを推奨
" 読み込み失敗してもエラーを吐かないように例外処理
try
  colorscheme pink-theme
catch /:E185:/
endtry

" highlight Normal ctermbg=none
" highlight CursorLineNr ctermfg=15

