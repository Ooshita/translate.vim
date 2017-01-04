" File: translate.vim
" Author:   Noriaki Oshita <noriaki_oshita@whispon.com>
" Last Change:	2017 January 5
" WebPage: http://whispon.com

if exists('g:loaded_translate_vim')
  finish
endif

let g:loaded_sentiment_vim = 0
let s:save_cpo = &cpo
set cpo&vim

"Get an accdess token. Specify the location of the access_token file.
let s:configfile = join(readfile('/Users/noriakioshita/.config/nvim/plugin/.translate.vim'))

function! s:load_settings()
  let s:settings = s:configfile
endfunction

function! s:gettext()
  "Get the all line text
  let lines = getline(1,line("$"))
  let s:outputfile = '/Users/noriakioshita/.config/nvim/plugin/getline.txt'
  execute "redir! > " . s:outputfile
  for i in lines
    if i == lines[0] 
      silent! echon i
    else
      silent! echo i
    endif
  endfor
  redir END 
endfunction

function! s:Translate()
  call s:load_settings()
  call s:gettext()
  let translate_text = "'" . join(readfile(s:outputfile)) . "'"
  let url ='https://translation.googleapis.com/language/translate/v2'
  let res = webapi#http#post(url, '{''q'': ' . translate_text . ', ''source'': ''ja'',''target'': ''en'', ''format'': ''text''}', {'Authorization': 'Bearer ' . s:settings,'Content-Type': 'application/json'})
  echo res
endfunction

command! Translate :call s:Translate()
let &cpo = s:save_cpo
unlet s:save_cpo
