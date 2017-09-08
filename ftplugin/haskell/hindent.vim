if !exists("g:hindent_on_save")
    let g:hindent_on_save = 1
endif


function! hindent#HindentEnable()
    let g:hindent_on_save = 1
endfunction
function! hindent#HindentDisable()
    let g:hindent_on_save = 0
endfunction
function! hindent#HindentToggle()
    let g:hindent_on_save = !g:hindent_on_save
endfunction


function! hindent#Hindent()
    let l:winview = winsaveview()

    if !executable("hindent")
        echomsg "Hindent not found in $PATH, did you installed it?
                    \ (stack install hindent)"
        return
    endif

    " Write the buffer to hindent, rather than having it use the
    " file on disk, because that file might not have been created yet!
    silent! w !hindent > /dev/null 2>&1

    if v:shell_error
        echohl WarningMsg
        echo "Hindent: Parsing error\n"
        echohl None
    else
        let l:indent_opt = ""
        if exists("g:hindent_indent_size")
          let l:indent_opt = " --indent-size " . g:hindent_indent_size
        endif

        let l:line_length_opt = ""
        if exists("g:hindent_line_length")
          let l:line_length_opt = " --line-length " . g:hindent_line_length
        endif

        silent! exe "undojoin"
        silent! exe "keepjumps %!hindent" . l:indent_opt . l:line_length_opt
    endif

    call winrestview(l:winview)
endfunction

function! hindent#HindentOnSave()
    if g:hindent_on_save == 1
        call hindent#Hindent()
    endif
endfunction


augroup hindent
    autocmd!
    autocmd BufWritePre *.hs call hindent#HindentOnSave()
augroup END


command! Hindent exe "call hindent#Hindent()"
command! HindentEnable exe "call hindent#HindentEnable()"
command! HindentDisable exe "call hindent#HindentDisable()"
command! HindentToggle exe "call hindent#HindentToggle()"
