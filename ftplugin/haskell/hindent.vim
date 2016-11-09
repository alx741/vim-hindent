function! s:Hindent()
    let l:winview = winsaveview()

    if !exists("g:hindent_indent_size")
        let g:hindent_indent_size = 2
    endif

    if !executable("hindent")
        echomsg "Hindent not found in $PATH, did you installed it? (stack install hindent)"
        return
    endif

    silent! silent execute "!hindent < %"
    execute 'redraw!'

    if v:shell_error
        echomsg "Hindent: Parsing error"
    else
        silent! execute "%!hindent --indent-size " . g:hindent_indent_size
    endif

    call winrestview(l:winview)
endfunction

augroup hindent
  autocmd!
  autocmd BufWritePost *.hs call s:Hindent()
augroup END
