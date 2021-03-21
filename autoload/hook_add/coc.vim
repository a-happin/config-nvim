scriptencoding utf-8

function! hook_add#coc#hook_add () abort
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
endfunction

