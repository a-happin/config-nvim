set encoding=utf-8
scriptencoding utf-8

let s:xdg_config_home = empty ($XDG_CONFIG_HOME) ? expand ('~/.config') : $XDG_CONFIG_HOME
let s:xdg_cache_home = empty ($XDG_CACHE_HOME) ? expand ('~/.cache') : $XDG_CACHE_HOME
let s:nvim_directory = s:xdg_config_home . '/nvim'
let s:dein_directory = s:xdg_cache_home . '/dein'

" *******************************
" **  dein.vim
" *******************************

" install dein automatically
if !isdirectory (s:dein_directory)
  call system ('curl -s https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh | sh -s -- ' . s:dein_directory)
endif

" add dein path in runtimepath
execute 'set runtimepath+=' . s:dein_directory . '/repos/github.com/Shougo/dein.vim'

if dein#load_state (s:dein_directory)
  call dein#begin (s:dein_directory)

  " requires
  call dein#add (s:dein_directory . '/repos/github.com/Shougo/dein.vim')

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

  " 色コードを色で表示
  call dein#add ('gorodinskiy/vim-coloresque')

  call dein#end ()
  call dein#save_state ()
endif

" auto install new plugin
if has ('vim_starting') && dein#check_install ()
  call dein#install ()
endif

" *******************************
" **  (v'-')っ First Initialize
" *******************************

filetype plugin indent on
syntax on

" *******************************
" **  plugin settings
" *******************************

let g:deoplete#enable_at_startup = 0
"call deoplete#custom#source ('dictionary', 'matchers', ['matcher_head'])
"call deoplete#custom#source ('dictionary', 'rank', 999)
"call deoplete#custom#source ('_', 'sorters', ['sorter_rank', 'sorter_word'])

let g:neosnippet#snippets_directory = '~/.config/nvim/snippets'
" which disables all runtime snippets
let g:neosnippet#disable_runtime_snippets = { '_' : 1 }

let g:ale_linters = {'cpp': ['clang']}
let g:ale_cpp_clang_options = "-std=c++2a -Weverything -Wno-c++98-compat-pedantic -Wno-c11-extensions -Wno-unused-macros -Wno-unused-const-variable -pedantic-errors -I ~/work/kizuna/include"
" 競プロモード！
command! ContestMode let g:ale_cpp_clang_options = "-std=c++14 -Weverything -Wno-c++98-compat-pedantic -Wno-c11-extensions -Wno-unused-macros -Wno-unused-const-variable -Wno-sign-conversion -pedantic-errors"

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
        \   }
        \ }
endif

let g:coc_global_extensions = [
      \ 'coc-lists',
      \ 'coc-vimlsp',
      \ 'coc-json',
      \ 'coc-tsserver',
      \]

augroup coc-config
  autocmd!
  autocmd CursorHold * silent call CocActionAsync ('highlight')
augroup END

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
  autocmd CursorHold,InsertLeave * silent call <SID>auto_save_if_possible ()
augroup END

augroup file-reload
  autocmd!
  autocmd InsertEnter,WinEnter * checktime
augroup END

augroup reset-parentheses-completion-stack
  autocmd!
  autocmd InsertEnter * let b:parentheses_completion_stack = 0
augroup END

augroup load-template
  autocmd!
  autocmd BufNewFile *.cpp  execute '0r ' . s:nvim_directory . '/template/.cpp'
  autocmd BufNewFile *.html execute '0r ' . s:nvim_directory . '/template/.html'
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

" 置き換え時にプレビュー表示
set inccommand=split

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

" Enables pseudo-transparency for the |popup-menu|.
set pumblend=0

" 相対行番号
"set relativenumber

" show position of cursor
set ruler

" <>などでインデント調整時にshiftwidthの倍数に丸める
set shiftround

" indent width
" if 0, the same as tabstop.
set shiftwidth=2

" c: don't give |ins-completion-menu| messages.
set shortmess+=c

" display inputting command on lower right
set showcmd

" 現在の入力モードを表示しない(プラグインでstatuslineに表示するようにしたので)
set noshowmode

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
"set statusline=%F\ %m%r%h%w%=[FORMAT=%{&ff}]\ %y\ (%3v,%3l)\ [%2p%%]

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
vnoremap <C-a> gg0oG$

" 選択中にCtrl-Cでクリップボードにコピー
vnoremap <C-c> "+y

" Shift-Tabでインデントを1つ減らす
nnoremap <S-Tab> <<

" Shift-Yで行末までヤンク
nnoremap Y y$

" 見た目上での縦移動(wrapしてできた行を複数行とみなす？)
nnoremap j gj
nnoremap k gk

" ビジュアルモードでインデント調整時に選択範囲を解除しない
xnoremap < <gv
xnoremap > >gv

" Paste from clipboard
nnoremap <Space>p "+p
nnoremap <Space>P "+P

" 空白1文字挿入
nnoremap <Space>i i<Space><Esc>
nnoremap <Space>a a<Space><Esc>

" 改行挿入
nnoremap <Space>o o<Esc>
nnoremap <Space>O O<Esc>

" 入れ替え
nnoremap ; :
nnoremap : ;

" 保存
nnoremap <Space>w :<C-u>w<CR>

nnoremap f<CR> $

" 選択範囲をヤンクした文字列で上書き時にレジスタを汚さない
nnoremap p pgvy

" 定義ジャンプ
nmap <silent> gd <Plug>(coc-definition)

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
inoremap <silent><expr> <Tab> <SID>tab_key ()
"smap <expr><Tab> neosnippet#expandable_or_jumpable () ? '<Plug>(neosnippet_expand_or_jump)' : '<Tab>'

" ポップアップ補完メニューが表示されているときは前の候補を選択
" それ以外はインデントを1つ下げる
inoremap <silent><expr> <S-Tab> pumvisible () ? '<C-p>' : '<C-d>'

" ポップアップ補完メニューが表示されているときは確定
"inoremap <expr><CR> pumvisible () ? '<C-y>' : KamiCR ()
inoremap <silent><expr> <CR> <SID>cr_key ()

" 括弧の対応の補完
inoremap <silent><expr> ( <SID>begin_parenthesis ('(',')')
inoremap <silent><expr> ) <SID>end_parenthesis   ('(',')')
inoremap <silent><expr> { <SID>begin_parenthesis ('{','}')
inoremap <silent><expr> } <SID>end_parenthesis   ('{','}')
inoremap <silent><expr> [ <SID>begin_parenthesis ('[',']')
inoremap <silent><expr> ] <SID>end_parenthesis   ('[',']')

" クォーテーションの自動補完
inoremap <silent><expr> " <SID>quotation_key ('"')
inoremap <silent><expr> ' <SID>quotation_key ('''')
inoremap <silent><expr> ` <SID>quotation_key ('`')

" Backspace
inoremap <silent><expr> <BS> <SID>backspace_key ()
"inoremap <expr><Del> delete_key ()

" いいかんじの'/'
inoremap <silent><expr> / <SID>slash_key ()

" スペースキー
inoremap <silent><expr> <Space> <SID>space_key ()

" インデントを考慮した<Home>
nnoremap <silent><expr> 0 <SID>home_key ()
xnoremap <silent><expr> 0 <SID>home_key ()
nnoremap <silent><expr> <Home> <SID>home_key ()
vnoremap <silent><expr> <Home> <SID>home_key ()
inoremap <silent><expr> <Home> '<C-o>' . <SID>home_key ()

" コメントアウト
" Linuxでは<C-/>は<C-_>で設定しないといけないらしいが<C-/>で動くのだが…？
nnoremap <C-/> I// <Esc>

" CocList
nnoremap <silent> <Space><Space> :<C-u>CocList<CR>

" Rename
nmap <silent> <Space>r <Plug>(coc-rename)

" 次のdiagnostic(エラー、警告)
nmap <silent> gi <Plug>(coc-diagnostic-next)

" show documentation
nnoremap <silent> <F1> :<C-u>call <SID>show_documentation ()<CR>

"inoremap <F5> <C-o>:<C-u>echo <SID>cursor_line_string()<CR>

" auto complete
" 文字列化してexecuteしないとkeyがキーとして解釈されてしまう
"for key in split ("1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM_",'\zs')
"  execute "inoremap <expr>" . key . " AutoComplete ('" . key . "')"
"endfor

"augroup insert-custom
"  autocmd!
"  autocmd InsertEnter * let b:last_cursor_moved = v:false
"  autocmd CursorMoved * let b:cursor_moved = v:true
"  autocmd InsertCharPre * let b:last_cursor_moved = v:false
"augroup END


" *******************************
" **  function!
" *******************************

" カーソル位置の文字
function! s:cursor_char ()
  return matchstr (getline ('.') , '.' , col ('.') - 1)
endfunction

" 現在の行にある文字列をカーソル位置の前と後に分割して返す
" 前はカーソル直下の文字を含まない
" 後はカーソル直下の文字を含む
function! s:cursor_line_string ()
  let l:str = getline ('.')
  let l:pos = col ('.') - 1
  if l:pos == 0
    return ['', l:str]
  else
    return [l:str[:l:pos - 1], l:str[l:pos:]]
  endif
endfunction

" 空の括弧の中にいるかどうか
function! s:is_in_empty_parentheses (pre, post)
  return  (a:pre =~# '($' && a:post =~# '^)')   ||
        \ (a:pre =~# '[$' && a:post =~# '^]')   ||
        \ (a:pre =~# '{$' && a:post =~# '^}')   ||
        \ (a:pre =~# '<$' && a:post =~# '^>')
endfunction

function! s:is_in_empty_quotation (pre, post)
  return  (a:pre =~# '"$' && a:post =~# '^"')   ||
        \ (a:pre =~# '''$' && a:post =~# '^''') ||
        \ (a:pre =~# '`$' && a:post =~# '^`')
endfunction

function! s:is_in_empty_parenthes_with_space (pre, post)
  return  (a:pre =~# '( $' && a:post =~# '^ )')   ||
        \ (a:pre =~# '[ $' && a:post =~# '^ ]')   ||
        \ (a:pre =~# '{ $' && a:post =~# '^ }')   ||
        \ (a:pre =~# '< $' && a:post =~# '^ >')
endfunction

" 括弧閉じるを補完するべきかどうか
" カーソル位置が末尾、
" カーソル位置に空白、
" カーソル位置に括弧閉じるがある場合は補完するべき。(連続で入力したときに補完されないのはおかしいので)
function! s:should_complete_end_parenthesis (pre, post)
  return a:post =~# '^$\|^\s\|^[)}\]>]'
endfunction

""""""""""""""""""""""""""""""""
" Key
""""""""""""""""""""""""""""""""

" 括弧開始
" カーソル直下がキーワードでなかった場合、閉じ括弧を補完
function! s:begin_parenthesis (begin, end)
  let [l:pre, l:post] = s:cursor_line_string ()
  if s:should_complete_end_parenthesis (l:pre, l:post)
    let b:parentheses_completion_stack += 1
    return a:begin . a:end . "\<Left>"
  else
    return a:begin
  endif
endfunction

" 括弧閉じ
" 補完スタックがある時、単に右に移動
" それ以外は括弧閉じる
function! s:end_parenthesis (begin, end)
  let [l:pre, l:post] = s:cursor_line_string ()
  if b:parentheses_completion_stack > 0 && l:post =~# '^' . a:end
    let b:parentheses_completion_stack -= 1
    return "\<Right>"
  else
    return a:end
  endif
endfunction


" quotation
" vimscriptの場合は行頭はコメントなので補完しない
" カーソル位置に同じ文字がある場合は<Right>
" 直前と直後に空白や括弧しかない場合は補完する
" それ以外は補完しない
function! s:quotation_key (key)
  let [l:pre, l:post] = s:cursor_line_string ()
  if &filetype ==# 'vim' && l:pre ==# '' && a:key ==# '"'
    return a:key
  elseif l:post =~# '^' . a:key
    return "\<Right>"
  elseif l:pre =~# '^$\|\s$\|[({[<]$' && l:post =~# '^$\|^\s\|^[)}\]>]'
    return a:key . a:key . "\<Left>"
  else
    return a:key
  endif
endfunction


" Tab
" キーワードなら補完開始
" スラッシュならファイル名補完開始
" それ以外はTab
function! s:tab_key ()
  if pumvisible ()
    return "\<C-n>"
  else
    let [l:pre, l:post] = s:cursor_line_string ()
    if l:pre =~# '\k$'
      return "\<C-n>"
    elseif l:pre =~# '/$'
      return "\<C-x>\<C-f>"
    else
      return "\<Tab>"
    endif
  endif
endfunction


" CR
" カーソルが{}の間ならいい感じに改行
" カーソルが``の間なら```にして改行
" それ以外は改行
function! s:cr_key ()
  if pumvisible ()
    return "\<C-y>"
  else
    let [l:pre, l:post] = s:cursor_line_string ()
    if s:is_in_empty_parentheses (l:pre, l:post)
      return "\<CR>\<Up>\<End>\<CR>"
    elseif l:pre =~# '"$' && l:post =~# '^"'
      return "\"\"\<CR>\"\"\<Up>\<End>\<CR>"
    elseif l:pre =~# '''$' && l:post =~# '^'''
      return "''\<CR>''\<Up>\<End>\<CR>"
    elseif l:pre =~# '`$' && l:post =~# '^`'
      return "``\<CR>``\<Up>\<End>\<CR>"
    else
      return "\<CR>"
    endif
  endif
endfunction


" Backspace Key
function! s:backspace_key ()
  let [l:pre, l:post] = s:cursor_line_string ()
  if s:is_in_empty_parentheses (l:pre, l:post) || s:is_in_empty_quotation (l:pre, l:post) || s:is_in_empty_parenthes_with_space (l:pre, l:post)
    return "\<BS>\<Del>"
  else
    return "\<BS>"
  endif
endfunction

" Delete Key
function! s:delete_key ()
  let [l:pre, l:post] = s:cursor_line_string ()
  if s:is_in_empty_parentheses (l:pre, l:post) || s:is_in_empty_quotation (l:pre, l:post) || s:is_in_empty_parenthes_with_space (l:pre, l:post)
    return "\<BS>\<Del>"
  else
    return "\<Del>"
  endif
endfunction


" Slash Key
" 直前が*または\だった場合、そのまま/
" < だった場合、/を入力した後オムニ補完開始
" それ以外: /を入力した後ファイル名補完開始
function! s:slash_key ()
  let [l:pre, l:post] = s:cursor_line_string ()
  if l:pre =~# '[/*\\]$'
    return "/"
  elseif l:pre =~# '<$'
    if &omnifunc != ''
      return "/\<C-x>\<C-o>"
    else
      return "/"
    endif
  else
    return "/\<C-x>\<C-f>"
  endif
endfunction


" Home Key
" インデントを考慮した<Home>
function! s:home_key ()
  let [l:pre, l:post] = s:cursor_line_string ()
  if l:pre =~# '^\s\+$'
    return "0"
  else
    return "^"
  endif
endfunction


" Space Key
" インデントを考慮した<Home>
function! s:space_key ()
  let [l:pre, l:post] = s:cursor_line_string ()
  if s:is_in_empty_parentheses (l:pre, l:post)
    return "\<Space>\<Space>\<Left>"
  else
    return "\<Space>"
  endif
endfunction


""""""""""""""""""""""""""""""""
" utility
""""""""""""""""""""""""""""""""

" show vim help
function! s:show_documentation ()
  if (index (['vim', 'help'], &filetype) >= 0)
    execute 'help ' . expand ('<cword>')
  else
    call CocAction ('doHover')
  endif
endfunction


" 自動保存
function! s:auto_save_if_possible ()
  if &modified && &filetype != 'gitcommit' && filewritable (expand ('%'))
    write
  endif
endfunction

