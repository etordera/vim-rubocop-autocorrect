" Run rubocop auto-correct on visually selected lines
" Last Change:	2020 July 5
" Maintainer:	Enric Tordera <etordera@gmail.com>
" License:	This file is placed in the public domain.

if exists("g:loaded_rubocop_autocorrect")
  finish
endif
let g:loaded_rubocop_autocorrect = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:get_visual_selection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return lines
endfunction

function s:rubocop_cmdline(filename)
  let l:cmd_line = "rubocop "
  if filereadable('.rubocop.yml')
    let l:cmd_line .= "--config .rubocop.yml "
  endif
  let l:cmd_line .= "--auto-correct "
  let l:cmd_line .= a:filename
  return l:cmd_line
endfunction

function! s:autocorrect(content)
  let l:tmp_file = tempname()
  call writefile(a:content, l:tmp_file)
  let l:rubocop_cmd = s:rubocop_cmdline(l:tmp_file)
  echo l:rubocop_cmd
  call system(l:rubocop_cmd)
  let l:output = join(readfile(l:tmp_file), "\n") . "\n"

  return l:output
endfunction

function! s:main()
  let @x = s:autocorrect(s:get_visual_selection())
  normal gvd
  normal "xP
  silent normal `[=`]
endfunction

xnoremap <Plug>RubocopAutocorrect :call <SID>main()<cr>
if !hasmapto('<Plug>RubocopAutocorrect')
  xmap <leader>b <Plug>RubocopAutocorrect
endif

let &cpo = s:save_cpo
unlet s:save_cpo
