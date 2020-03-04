" Header {{{
"--------------------------------------------------------------------------------
" vim: set sw=4 ts=4 sts=4 et tw=90  foldmethod=marker :
"
" By: Vito C.
" }}}

" TODO: fix broken stuff
" let g:fzf_layout = { 'up': '~40%' }
let g:fzf_layout = { 'window': 'call FloatingFZF()' }
let g:fzf_default_layout = {'down': '~40%'}
function! s:w(bang)
    return a:bang ? {} : copy(get(g:, 'fzf_layout', g:fzf_default_layout))
endfunction

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(20)
  let width = float2nr(120)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 1

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

let g:height = float2nr(&lines * 0.9)
let g:width = float2nr(&columns * 0.95)
let g:preview_width = float2nr(&columns * 0.7)
let g:fzf_buffers_jump = 1
" let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
" let $FZF_DEFAULT_OPTS=" --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4 'if file -i {}|grep -q binary; then file -b {}; else bat --style=changes --color always --line-range :40 {}; fi' --preview-window right:" . g:preview_width
let g:fzf_layout = { 'window': 'call FloatingFZF(' . g:width . ',' . g:height . ')' }
"  call fzf#vim#files('', fzf#vim#with_preview({'options': '--prompt ""'}, 'right:70%'))
"
nnoremap <leader>l :BuffSwitch<CR>
" nnoremap <leader>fs :Rag <C-R>=expand("<cword>")<CR><CR>
" nnoremap <leader>fa :GitCFiles<CR>
" nnoremap <leader>ff :GitCFiles<CR>
nnoremap <leader>ff :call fzf#vim#files('', fzf#vim#with_preview({'options': '--prompt ""'}, 'right:70%'))<CR>

let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

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
" Ag
" ------------------------------------------------------------------


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
        " echom cmd
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
  if len(a:lines) < 1
      return
  endif
  execute 'buffer' matchstr(a:lines[0], '\[\zs[0-9]*\ze\]')
  " let cmd = get(get(g:, 'fzf_action', s:default_action), a:lines[0], '')
  " if !empty(cmd)
  "   execute 'silent' cmd
  " endif
  " execute 'buffer' matchstr(a:lines[1], '\[\zs[0-9]*\ze\]')
endfunction

function! s:format_buffer(buff, fmax, bmax)
  let path = bufname(a:buff)
  let path = empty(path) ? '[No Name]' : path
  let bname = fnamemodify(bufname(path), ':t')

  let flag = a:buff == bufnr('')  ? s:blue('%') :
          \ (a:buff == bufnr('#') ? s:magenta('#') : ' ')

  let modified = getbufvar(a:buff, '&modified') ? s:red(' [+]') : ''
  let readonly = getbufvar(a:buff, '&modifiable') ? '' : s:green(' [RO]')
  let extra = join(filter([modified, readonly], '!empty(v:val)'), '')
  let prefix = s:strip(printf("[%s] %s", s:yellow(a:buff), flag))
  " get the digits of the max buffer number which is log10(num) + 1 then add more padding
  "   * digits: log10(num) + 1
  "   * braces:  + 2
  "   * space then len(flag) space: + 2
  "   ie: '[23] # ' which has a char width of 6
  let npad = str2nr(string(log10(a:bmax))) + 6 + len(flag) + 6
  " TODO: optimize one more space off the padding
  return printf("%-" . npad . "s %-" . a:fmax . "s  %s %s", prefix, bname, path, extra)
endfunction

function! rc#plugins#fzf#buffers(...) " {{{
  let bmax = max(s:buflisted())
  let fmax = max(map(s:buflisted(), "len(fnamemodify(bufname(v:val), ':t'))"))
  let bufs = map(s:buflisted(), 's:format_buffer(v:val, fmax, bmax)')
  " echom "fzf#buffers " . len(bfs)
  call s:fzf(fzf#wrap({
  \ 'source':  bufs,
  \ 'sink*':   s:function('s:bufopen'),
  \ 'options': '+m -x --tiebreak=index --ansi -d "\t" -n 2,1..2 --prompt="Buf> "',
  \}), a:000)
endfunction " }}}

" ------------------------------------------------------------------
" Helpers
" ------------------------------------------------------------------
command! -nargs=* Cag
  \ call fzf#vim#ag(<q-args>, extend({'dir': expand('%:h')}, g:fzf_layout))
command! -nargs=* Rag
  \ call fzf#vim#ag(<q-args>, extend(g:rc#git#groot(), g:fzf_layout))
command! -nargs=* Tag
  \ call fzf#vim#grep("ag --column --nogroup --color".shellescape(<q-args>), 1, <bang>0)'
command! -bang GitCFiles call rc#plugins#fzf#gitfiles(s:w(<bang>0))
command! -bang BuffSwitch call rc#plugins#fzf#buffers(s:w(<bang>0))
