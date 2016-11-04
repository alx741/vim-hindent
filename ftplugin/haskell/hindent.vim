function! s:Hindent()
    exec "norm mz"
    let l:winview = winsaveview()

    if !executable("hindent")
        echom "Hindent not found in $PATH, did you installed it? (stack install hindent)"
        return
    endif

    silent! silent exec "!cat % | hindent"
    exec ':redraw!'

    if v:shell_error
        echom "Hindent: Parsing error"
    else
        silent! exec "%!hindent"
    endif

    exec "norm `z"
    call winrestview(l:winview)

endfunction

augroup hindent
  autocmd!
  autocmd BufWritePost *.hs call s:Hindent()
augroup END
