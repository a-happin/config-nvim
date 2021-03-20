scriptencoding=utf-8

function! s:tabpage_label(n) abort
  let highlight = a:n is tabpagenr () ? '%#TabLineSel#' : '%#TabLine#'
  let tabnumber = '%' . a:n . 'T'
  let bufs = tabpagebuflist (a:n)
  let current_buffer = bufs[tabpagewinnr (a:n) - 1]
  let filename = fnamemodify (bufname (current_buffer), ':t')
  if filename ==# ''
    let filename = '[No Name]'
  endif
  let modified = ''
  for b in bufs
    if getbufvar (b, '&modified')
      let modified = ' *'
    endif
  endfor
  return highlight . tabnumber . ' ' . filename . modified . ' %T%#TabLineFill#'
endfunction

function! tabline#make() abort
  let titles = map (range (1, tabpagenr ('$')), 's:tabpage_label(v:val)')
  let tabpages = join (titles, '|') . '%#TabLineFill#'
  let close_button = '%#TabLine#%' . tabpagenr () . 'X x %X'
  return tabpages . '%=' . close_button
endfunction
