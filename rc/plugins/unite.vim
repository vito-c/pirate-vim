" Information {
"--------------------------------------------------------------------------------
" vim: set sw=4 ts=4 sts=4 et tw=90 foldmarker={,} foldmethod=marker :
"  
" By: Vito C.
" }
echo "plugins unite"
let g:unite_source_file_rec_max_cache_files = 250
let g:unite_source_history_yank_enable = 1
let g:unite_source_buffer_time_format=""

"call unite#custom#source('file,file/new,buffer,file_rec,file_rec/git',
"            \ 'matchers', ['converter_abbr_word','matcher_fuzzy'])
"call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <leader>oo :<C-u>Unite -start-insert -toggle -no-split file_rec/git:--cached:--others:--exclude-standard<CR>
nnoremap <leader>l :<C-u>Unite -start-insert -toggle -no-split buffer:-<CR>
nnoremap <leader>t :<C-u>Unite -start-insert -toggle -no-split buffer:t<CR>
if has('nvim')
    nnoremap <leader>of :<C-u>Unite -start-insert -toggle -no-split file_rec/neovim:!<CR>
else
    nnoremap <leader>of :<C-u>Unite -start-insert -toggle -no-split file_rec/async:!<CR>
endif
"nnoremap <leader>l :<C-u>Unite -start-insert -toggle -auto-preview -no-split -winheight=15 -immediately buffer<CR>
if executable('ag')
    " Use ag in unite grep source.
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
                \ '-i --vimgrep --hidden --ignore ' .
                \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
endif
