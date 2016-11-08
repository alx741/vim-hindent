function! s:Hindent()
    "set dummy mark to save cursor position
    execute "norm mz"
    let l:winview = winsaveview()

    if !executable("hindent")
        echomsg "Hindent not found in $PATH, did you installed it? (stack install hindent)"
        return
    endif

    silent! silent execute "!hindent < %"
    execute 'redraw!'

    if v:shell_error
        echom "Hindent: Parsing error"
    else
        silent! execute "%!hindent"
    endif

    " jump back to previous position
    execute "norm `z"
    " rm dummy mark
    execute "delmarks z"
    call winrestview(l:winview)

endfunction

augroup hindent
  autocmd!
  autocmd BufWritePost *.hs call s:Hindent()
augroup END
