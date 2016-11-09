function! s:Hindent()
    let l:winview = winsaveview()

    if !executable("hindent")
        echomsg "Hindent not found in $PATH, did you installed it? (stack install hindent)"
        return
    endif

    silent! silent execute "!hindent < %"
    execute 'redraw!'

    if v:shell_error
        echomsg "Hindent: Parsing error"
    else
        silent! execute "%!hindent"
    endif

    call winrestview(l:winview)

endfunction

augroup hindent
  autocmd!
  autocmd BufWritePost *.hs call s:Hindent()
augroup END
