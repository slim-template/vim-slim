autocmd BufNewFile,BufRead *.slim set filetype=slim

function! s:DetectSlimLang()
    if getline(1) =~ '^#!.*\<slim\>'
        set filetype=slim
    endif
endfunction

autocmd BufNewFile,BufRead * call s:DetectSlimLang()
