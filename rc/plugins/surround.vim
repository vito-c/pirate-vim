" Customizing vim-surround

augroup surround "{{{
    autocmd!
    autocmd FileType scala let b:surround_45 = "Some(\r)"
augroup END "}}}
