scriptencoding utf-8

" 自動保存
function! auto_save#save () abort
  if &modified && !&readonly && &filetype != 'gitcommit' && filewritable (expand ('%'))
    write
  endif
endfunction
