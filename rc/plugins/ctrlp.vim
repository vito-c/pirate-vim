"ctrl-p
let g:ctrlp_by_filename = 1
let g:ctrlp_max_files = 2500000
let g:ctrlp_user_command=['.git', 'cd %s && git ls-files -co --exclude-standard', 'find %s -type f']
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/](\.(git|hg|svn|metadata|idea|settings)|target|vendor|vendors|node_modules)$',
            \ 'file': '\v\.(min.js|cache|class|exe|so|dll|php|exe|gitignore|jar|meta|dll|png|anim|unity|jpg|wav|prefab|fbx|asset|mp3|tga|psd|mat|atf|csproj|sln|svg|unity3d|mdb|dll|tiff|gif)$',
            \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
            \ }
