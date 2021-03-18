scriptencoding utf-8

augroup encrypt
  autocmd!
  autocmd BufReadPre *.encrypted setlocal buftype=acwrite
  autocmd BufReadCmd *.encrypted call DecryptRead()
  autocmd BufWriteCmd *.encrypted call EncryptWrite()
augroup END

function! DecryptRead() abort
  try
    call inputsave()
    redraw | let password = inputsecret('enter decryption password: ')
  finally
    call inputrestore()
    redraw
  endtry
  execute '%!openssl aes-256-cbc -d -iter 100 -k ' . password . ' -in ' . bufname()
endfunction

function! EncryptWrite() abort
  try
    call inputsave()
    redraw | let password = inputsecret('enter encryption password: ')
    redraw | let password2 = inputsecret('Verifying - enter encryption password: ')
  finally
    call inputrestore()
    redraw
  endtry
  if password ==# password2
    execute 'write !openssl aes-256-cbc -e -iter 100 -k ' . password . ' -out ' . bufname()
    set nomodified
  else
    echomsg 'password doesn''t match'
  endif
endfunction
