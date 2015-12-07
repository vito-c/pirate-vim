" Header {{{
"--------------------------------------------------------------------------------
" vim: set sw=4 ts=4 sts=4 et tw=90  foldmethod=marker :
"
" By: Vito C.
" }}}

let g:fzf_layout = { 'up': '~40%' }
nnoremap <leader>l :BuffSwitch<CR>
nnoremap <leader>fa :GitCFiles<CR>
nnoremap <leader>ff :GitCFiles<CR>

function! s:fzf(opts, extra)
    let extra  = copy(get(a:extra, 0, {}))
    let eopts  = has_key(extra, 'options') ? remove(extra, 'options') : ''
    let merged = extend(copy(a:opts), extra)
    let merged.options = join(filter([get(merged, 'options', ''), eopts], '!empty(v:val)'))
    return fzf#run(merged)
endfunction

function! s:warn(message)
    echohl WarningMsg
    echom a:message
    echohl None
endfunction

" ------------------------------------------------------------------
" Git
" ------------------------------------------------------------------

function! rc#plugins#fzf#gitfiles(...) " {{{
    let cmd = 'git ls-tree --name-only -r HEAD'
    let root = systemlist('git rev-parse --show-toplevel')[0]
    if v:shell_error
        let root = getcwd()
        let cmd = 'for dir in *; do ' . " {{{
                    \ 'if git -C $dir rev-parse --show-toplevel > /dev/null 2>&1; then ' .
                        \ 'git -C $dir ls-tree --name-only -r HEAD | sed "s,^,' . root .'/$dir/,g"; ' .
                    \ 'fi; ' .
                    \ 'done' " }}}
        echom cmd
    endif
    call s:fzf(fzf#vim#wrap({
            \ 'source':  cmd,
            \ 'dir':     root,
            \ 'options': '-m --prompt "GitFiles> "'
            \}), a:000)
endfunction " }}}

" ------------------------------------------------------------------
" Buffers
" ------------------------------------------------------------------
" function! s:colorize( color, str, ... ) " {{{
"     let colors = items( {'black': 30, 'red': 31, 'green': 32, 'yellow': 33, 'blue': 34,
"                 \ 'magenta': 35, 'cyan': 36})
"     let color = get()
"     return s:ansi(a:str, ".s:a.", get(a:, 1, 0))
" endfunction " }}}

if v:version >= 704 " {{{
  function! s:function(name)
    return function(a:name)
  endfunction
else
  function! s:function(name)
    " By Ingo Karkat
    return function(substitute(a:name, '^s:', matchstr(expand('<sfile>'), '<SNR>\d\+_\zefunction$'), ''))
  endfunction
endif " }}}

function! s:ansi(str, col, bold)
  return printf("\x1b[%s%sm%s\x1b[m", a:col, a:bold ? ';1' : '', a:str)
endfunction
for [s:c, s:a] in items({'black': 30, 'red': 31, 'green': 32, 'yellow': 33, 'blue': 34, 'magenta': 35, 'cyan': 36})
  execute "function! s:".s:c."(str, ...)\n"
        \ "  return s:ansi(a:str, ".s:a.", get(a:, 1, 0))\n"
        \ "endfunction"
endfor

function! s:buflisted()
  return filter(range(1, bufnr('$')), 'buflisted(v:val)')
endfunction
function! s:strip(str)
  return substitute(a:str, '^\s*\|\s*$', '', 'g')
endfunction
let s:default_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

function! s:bufopen(lines)
  if len(a:lines) < 2
    return
  endif
  let cmd = get(get(g:, 'fzf_action', s:default_action), a:lines[0], '')
  if !empty(cmd)
    execute 'silent' cmd
  endif
  execute 'buffer' matchstr(a:lines[1], '\[\zs[0-9]*\ze\]')
endfunction

function! s:format_buffer(b)
  let name = bufname(a:b)
  let name = empty(name) ? '[No Name]' : name
  let flag = a:b == bufnr('')  ? s:blue('%') :
          \ (a:b == bufnr('#') ? s:magenta('#') : ' ')
  let modified = getbufvar(a:b, '&modified') ? s:red(' [+]') : ''
  let readonly = getbufvar(a:b, '&modifiable') ? '' : s:green(' [RO]')
  let extra = join(filter([modified, readonly], '!empty(v:val)'), '')
  return s:strip(printf("[%s] %s\t%s\t%s", s:yellow(a:b), flag, name, extra))
endfunction

function! rc#plugins#fzf#buffers(...) " {{{
  let bufs = map(s:buflisted(), 's:format_buffer(v:val)')
  call s:fzf(fzf#vim#wrap({
  \ 'source':  bufs,
  \ 'sink*':   s:function('s:bufopen'),
  \ 'options': '+m -x --tiebreak=index --ansi -d "\t" -n 2,1..2 --prompt="Buf> "',
  \}), a:000)
endfunction " }}}

" ------------------------------------------------------------------
" Helpers
" ------------------------------------------------------------------
function! s:w(bang)
  return a:bang ? {} : copy(get(g:, 'fzf_layout', g:fzf#vim#default_layout))
endfunction
command! -bang GitCFiles call rc#plugins#fzf#gitfiles(s:w(<bang>0))
command! -bang BuffSwitch call rc#plugins#fzf#buffers(s:w(<bang>0))
