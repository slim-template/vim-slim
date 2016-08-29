function! s:DetectSlimLang()
  if getline(1) == "doctype html"
    setlocal filetype=slim
  else
    setfiletype slim
  endif
endfunction

autocmd BufNewFile,BufRead *.slim call s:DetectSlimLang()
