- install lua 5.1 `pacman -S lua51`
- install luarocks
- install penlight `luarocks --lua-version=5.1 --local  install penlight`
- remove `rm -rf /usr/{share,lib}/lua/5.1`
- link folders:
```
ln -s ~/.luarocks/lib/lua/5.1 /usr/lib/lua/5.1
ln -s ~/.luarocks/share/lua/5.1 /usr/share/lua/5.1
```
- use bootstrap to install packer modules there is a bit of dependency issue
    - tip: do not delete during :PackerInstall
- install lua-language-server via system package manager
    - use LspInfo to debug issues (run language server command locally)

