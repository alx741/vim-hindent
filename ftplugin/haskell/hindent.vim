if !exists("g:hindent_indent_size")
    let g:hindent_indent_size = 2
endif

if !exists("g:hindent_line_length")
    let g:hindent_line_length = 100
endif

if !exists("g:hindent_on_save")
    let g:hindent_on_save = 1
endif


command! Hindent exe "call hindent#Hindent()"


function! hindent#Hindent()
    let l:winview = winsaveview()

    if !executable("hindent")
        echomsg "Hindent not found in $PATH, did you installed it?
                    \ (stack install hindent)"
        return
    endif

    silent! silent exe "keepjumps !hindent < % > /dev/null 2>&1"
    exe 'redraw!'

    if v:shell_error
        echomsg "Hindent: Parsing error"
    else
        silent! exe "undojoin"
        silent! exe "keepjumps %!hindent" .
                    \ " --indent-size " . g:hindent_indent_size .
                    \ " --line-length " . g:hindent_line_length
    endif

    call winrestview(l:winview)
endfunction


if exists("g:hindent_on_save") && g:hindent_on_save == 1
    augroup hindent
        autocmd!
        autocmd BufWritePost *.hs call hindent#Hindent()
    augroup END
endif
