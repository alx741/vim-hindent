function! s:Hindent()
    exec "norm mz"
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
endfunction

augroup hindent
  autocmd!
  autocmd BufWritePost *.hs call s:Hindent()
augroup END
