scriptencoding utf-8

"---------------------------------------------------------------------------"
" Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator |
"------------------|--------|--------|---------|--------|--------|----------|
" map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |
" nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |
" vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |
" omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |
" xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |
" smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |
" map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |
" imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |
" cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |
"---------------------------------------------------------------------------"

" --------------------------------
"  誤爆防止
" --------------------------------

" 保存せずに破棄の誤爆防止
nnoremap ZQ <Nop>
nnoremap ZZ <Nop>

" 中ボタンによる貼り付けを無効
nnoremap <MiddleMouse> <Nop>
vnoremap <MiddleMouse> <Nop>

" Ctrl-Cによる挿入モードからの離脱を禁止
" （InsertLeaveが呼ばれないので内部状態がおかしくなる）
inoremap <C-c> <Nop>


" --------------------------------
"  挙動修正
" --------------------------------

" 入れ替え
"nnoremap ; :
"nnoremap : ;
"xnoremap ; :
"xnoremap : ;
nnoremap <CR> :
xnoremap <CR> :

" 見た目上での縦移動(wrapしてできた行を複数行とみなす？)
nnoremap <silent> <expr> j v:count > 0 ? 'j' : 'gj'
nnoremap <silent> <expr> k v:count > 0 ? 'k' : 'gk'
xnoremap <silent> <expr> j v:count > 0 ? 'j' : 'gj'
xnoremap <silent> <expr> k v:count > 0 ? 'k' : 'gk'


" ビジュアルモードでインデント調整時に選択範囲を解除しない
"xnoremap < <gv
"xnoremap > >gv

nnoremap f<CR> $

nnoremap # #*N


nnoremap <F5> <Cmd>call system('deno run --allow-all ./generator.ts > fantasy.vim')\|Reload<CR>

" --------------------------------
"  機能追加
" --------------------------------

" 全部閉じて終了
nnoremap <silent> <C-q> <Cmd>confirm qall<CR>


" Shift-Tabでインデントを1つ減らす
"nnoremap <S-Tab> <<

" <Tab>でtab切り替え
nnoremap <Tab> gt
nnoremap <S-Tab> gT

" ファイルチェックして再描画！
nnoremap <C-l> <Cmd>checktime<CR><C-l>


" --------------------------------
"  <Space>
" --------------------------------

" Paste from clipboard
nnoremap <Space>p "+]p
nnoremap <Space>P "+]P

" 空白1文字挿入
nnoremap <Space>i i<Space><Esc>
nnoremap <Space>a a<Space><Esc>

" 改行挿入
nnoremap <Space>o o<Space><C-u><Esc>
nnoremap <Space>O O<Space><C-u><Esc>

nnoremap <Space>h ^
nnoremap <Space>l $
nnoremap <Space><Tab> <Cmd>tabnew<CR>

" 閉じる
nnoremap <silent> <Space>q <Cmd>q<CR>

" 保存
nnoremap <Space>w <Cmd>w<CR>
nnoremap <Space>0 $

" open config file
nnoremap <Space>, <Cmd>edit $MYVIMRC<CR>

" toggle option
nnoremap <silent> <Space>1 <Cmd>setlocal cursorline! cursorcolumn!<CR>
nnoremap <silent> <Space>2 <Cmd>setlocal relativenumber!<CR>
nnoremap <silent> <Space>3 <Cmd>setlocal spell!<CR>
" nnoremap <silent> <Space>0 <Cmd>setlocal paste!<CR>


" --------------------------------
"  テキストオブジェクト
" --------------------------------

" ビジュアルモードでCtrl-Aで全選択
vnoremap <C-a> gg0oG$

" allテキストオブジェクト ファイル全体
xnoremap all gg0oG$
onoremap all <Cmd>normal! vgg0oG$<CR>

xnoremap il g_o0o
onoremap il <Cmd>normal! v_o$h<CR>

"xnoremap <Space> gE<Space>f<Space>ow<BS>F<Space>


" --------------------------------
"  コメントアウト
" --------------------------------

" Linuxでは<C-/>は<C-_>で設定しないといけないらしい
nmap <C-_> gcc
imap <C-_> <C-o>gcc
xmap <C-_> gc


" --------------------------------
"  yank系
" --------------------------------

" Shift-Yで行末までヤンク
nnoremap Y y$

" 選択範囲をヤンクした文字列で上書き時にレジスタを汚さない
xnoremap p pgvy

" 選択中にCtrl-Cでクリップボードにコピー
vnoremap <C-c> "+y


" --------------------------------
"  netrw
" --------------------------------
"nnoremap <C-e> :<C-u>NERDTreeToggle<CR>
nnoremap <silent> <C-e> <Cmd>call <SID>toggle_netrw ()<CR>


" --------------------------------
"  coc
" --------------------------------

" 定義ジャンプ
nmap <silent> gd <Plug>(coc-definition)

" CocList
" nnoremap <silent> <Space><Space> :<C-u>CocList<CR>

" 次のdiagnostic(エラー、警告)
nmap <silent> gi <Plug>(coc-diagnostic-next)

nmap qf <Plug>(coc-fix-current)

" show documentation
nnoremap <silent> <F1> <Cmd>call <SID>show_documentation ()<CR>


" --------------------------------
"  surround
" --------------------------------

" 選択モードで選択中の範囲を囲む
" ()
xnoremap sb "zc(<C-r><C-o>z)<Esc>
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


" --------------------------------
"  自動補完
" --------------------------------

" for neosnippet
"imap <C-k> <Plug>(neosnippet_expand_or_jump)
"smap <C-k> <Plug>(neosnippet_expand_or_jump)
"xmap <C-k> <Plug>(neosnippet_expand_target)
"imap <C-k> <Plug>(coc-snippets-expand-jump)

" ポップアップ補完メニューが表示されているときは次の候補を選択
inoremap <silent><expr> <Tab> <SID>tab_key ()

" ポップアップ補完メニューが表示されているときは前の候補を選択
" それ以外はインデントを1つ下げる
inoremap <silent><expr> <S-Tab> pumvisible () ? '<C-p>' : '<C-d>'

" ポップアップ補完メニューが表示されているときは確定
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
nnoremap <silent><expr> <Home> <SID>home_key ()

xnoremap <silent><expr> 0 <SID>home_key ()
vnoremap <silent><expr> <Home> <SID>home_key ()
inoremap <silent><expr> <Home> '<C-o>' . <SID>home_key ()

" --------------------------------
"  command mode
" --------------------------------

" 補完メニューが表示されているときの挙動修正
cnoremap <silent><expr> <CR> pumvisible () ? '<End>' : '<CR>'
cnoremap <silent><expr> <Left> pumvisible () ? '<End>' : '<Left>'
cnoremap <silent><expr> <Right> pumvisible () ? '<End>' : '<Right>'

" Better <C-n>/<C-p> in Command
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <Up> <C-p>
cnoremap <Down> <C-n>


" --------------------------------
"  Terminal
" --------------------------------

"tnoremap <Esc><Esc> <C-\><C-n>
" クリックでterminal windowを選択時にnormalモードに戻らないようにする
tnoremap <LeftRelease> <Nop>
tnoremap <C-w> <C-\><C-n><C-w>

" *******************************
" **  function!
" *******************************

" カーソル位置の文字
function! s:cursor_char () abort
  return matchstr (getline ('.') , '.' , col ('.') - 1)
endfunction

" 現在の行にある文字列をカーソル位置の前と後に分割して返す
" 前はカーソル直下の文字を含まない
" 後はカーソル直下の文字を含む
function! s:getline () abort
  let str = getline ('.')
  let pos = col ('.') - 1
  let prev = strpart (str, 0, pos)
  let post = strpart (str, pos)
  return [prev, post]
endfunction

function! s:starts_with (str, x) abort
  return a:str =~# '\v^\V' . a:x
endfunction

function! s:ends_with (str, x) abort
  return a:str =~# '\V' . a:x . '\v$'
endfunction

let s:pairs = {
  \ '(': ')',
  \ '{': '}',
  \ '[': ']',
  \ '<': '>',
  \ '''': '''',
  \ '"': '"',
  \ '`': '`',
  \ }

" 空の括弧の中にいるかどうか
function! s:is_in_empty_parentheses (prev, post) abort
  for [begin, end] in items (s:pairs)
    " skip quotation
    if begin ==# end
      continue
    endif

    if s:ends_with (a:prev, begin) && s:starts_with (a:post, end)
      return 1
    endif
  endfor

  return 0
endfunction

function! s:is_in_empty_quotation (prev, post) abort
  for [begin, end] in items (s:pairs)
    " skip parentheses
    if begin !=# end
      continue
    endif

    if s:ends_with (a:prev, begin) && s:starts_with (a:post, end)
      return 1
    endif
  endfor

  return 0
endfunction

function! s:is_in_empty_parenthes_with_space (prev, post) abort
  for [begin, end] in items (s:pairs)
    " skip quotation
    if begin ==# end
      continue
    endif

    if s:ends_with (a:prev, begin . ' ') && s:starts_with (a:post, ' ' . end)
      return 1
    endif
  endfor

  return 0
endfunction

" 括弧閉じるを補完するべきかどうか
" カーソル位置が末尾、
" カーソル位置に空白、
" カーソル位置に括弧閉じるがある場合は補完するべき。(連続で入力したときに補完されないのはおかしいので)
function! s:should_complete_end_parenthesis (prev, post) abort
  if a:post =~# '\v^$|^\s'
    return 1
  endif

  for [begin, end] in items (s:pairs)
    " skip quotation
    if begin ==# end
      continue
    endif

    if s:starts_with (a:post, end)
      return 1
    endif
  endfor

  return 0
endfunction

" quotation閉じるを補完すべきかどうか
" カーソルの前後が空白か括弧のときは補完するべき（と思う）
function! s:should_complete_quotation (prev, post) abort
  let left_flag = 0
  let right_flag = 0

  if a:prev =~# '\v^$|\s$'
    let left_flag = 1
  endif

  if a:post =~# '\v^$|^\s'
    let right_flag = 1
  endif

  for [begin, end] in items (s:pairs)
    if begin ==# end
      continue
    endif

    if s:ends_with (a:prev, begin)
      let left_flag = 1
    endif

    if s:starts_with (a:post, end)
      let right_flag = 1
    endif
  endfor

  return left_flag == 1 && right_flag == 1
endfunction


""""""""""""""""""""""""""""""""
" Key
""""""""""""""""""""""""""""""""

" 括弧開始
" カーソル直下がキーワードでなかった場合、閉じ括弧を補完
function! s:begin_parenthesis (begin, end) abort
  let [prev, post] = s:getline ()
  if s:should_complete_end_parenthesis (prev, post)
    let b:parentheses_completion_stack += 1
    return a:begin . a:end . "\<Left>"
  else
    return a:begin
  endif
endfunction

" 括弧閉じ
" 補完スタックがある時、単に右に移動
" それ以外は括弧閉じる
function! s:end_parenthesis (begin, end) abort
  let [prev, post] = s:getline ()
  if b:parentheses_completion_stack > 0 && post =~# '^' . a:end
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
function! s:quotation_key (key) abort
  let [prev, post] = s:getline ()
  if &filetype ==# 'vim' && prev =~# '^\s*$' && a:key ==# '"'
    return a:key
  elseif post =~# '^' . a:key
    return "\<Right>"
  elseif s:should_complete_quotation (prev, post)
    return a:key . a:key . "\<Left>"
  else
    return a:key
  endif
endfunction


" Tab
" キーワードなら補完開始
" スラッシュならファイル名補完開始
" 空行ならインデント調整
" それ以外はTab
function! s:tab_key () abort
  if pumvisible ()
    return "\<C-n>"
  else
    let [prev, post] = s:getline ()
    if prev =~# '\k$'
      if dein#tap ('coc.nvim')
        return coc#refresh ()
      else
        return "\<C-n>"
      endif
    elseif prev =~# '/$'
      return "\<C-x>\<C-f>"
    elseif prev ==# '' && post ==# '' && &cinkeys =~# '\V!^F' && (&cindent || &indentexpr !=# '')
      return "\<C-f>\<C-d>\<C-t>"
    else
      return "\<Tab>"
    endif
  endif
endfunction


" CR
" カーソルが{}の間ならいい感じに改行
" カーソルが``の間なら```にして改行
" それ以外は改行
function! s:cr_key () abort
  if pumvisible ()
    return "\<C-y>"
  else
    let [prev, post] = s:getline ()
    if s:is_in_empty_parentheses (prev, post)
      return "\<CR>\<Up>\<End>\<CR>"
    elseif prev =~# '''$' && post =~# '^'''
      return "''\<CR>''\<Up>\<End>\<CR>"
    elseif prev =~# '"$' && post =~# '^"'
      return "\"\"\<CR>\"\"\<Up>\<End>\<CR>"
    elseif prev =~# '`$' && post =~# '^`'
      return "``\<CR>``\<Up>\<End>\<CR>"
    else
      return "\<CR>"
    endif
  endif
endfunction


" Backspace Key
function! s:backspace_key () abort
  let [prev, post] = s:getline ()
  if s:is_in_empty_parentheses (prev, post) || s:is_in_empty_quotation (prev, post) || s:is_in_empty_parenthes_with_space (prev, post)
    return "\<BS>\<Del>"
  else
    return "\<BS>"
  endif
endfunction

" Delete Key
function! s:delete_key () abort
  let [prev, post] = s:getline ()
  if s:is_in_empty_parentheses (prev, post) || s:is_in_empty_quotation (prev, post) || s:is_in_empty_parenthes_with_space (prev, post)
    return "\<BS>\<Del>"
  else
    return "\<Del>"
  endif
endfunction


" Slash Key
" 直前が*または\だった場合、そのまま/
" < だった場合、/を入力した後オムニ補完開始
" それ以外: /を入力した後ファイル名補完開始
function! s:slash_key () abort
  let [prev, post] = s:getline ()
  if prev =~# '[/*\\]$'
    return "/"
  elseif prev =~# '<$'
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
function! s:home_key () abort
  let [prev, post] = s:getline ()
  if prev =~# '^\s\+$'
    return "0"
  else
    return "^"
  endif
endfunction


" Space Key
" カーソルが空括弧の間にあった場合に2個挿入
function! s:space_key () abort
  let [prev, post] = s:getline ()
  if s:is_in_empty_parentheses (prev, post)
    return "\<Space>\<Space>\<Left>"
  else
    return "\<Space>"
  endif
endfunction


" show vim help
function! s:show_documentation () abort
  if (index (['vim', 'help'], &filetype) >= 0)
    execute 'help ' . expand ('<cword>')
  else
    call CocAction ('doHover')
  endif
endfunction

function! s:toggle_netrw () abort
  let exists_netrw = 0
  for i in range (1, bufnr ('$'))
    if getbufvar (i, '&filetype') == 'netrw'
      execute 'bwipeout ' . i
      let exists_netrw = 1
      break
    endif
  endfor
  if !exists_netrw
    topleft vertical new
    vertical resize 30
    Explore
    setlocal winfixwidth
    wincmd p
  endif
endfunction

augroup reset-parentheses-completion-stack
  autocmd!
  autocmd InsertEnter * let b:parentheses_completion_stack = 0
augroup END
