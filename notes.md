
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

 ~/.luarocks/share/lua/5.1 needs to be in /usr/local/share/lua/
 ~/.luarocks/lib/lua/5.1 needs to be in /usr/local/lib/lua/

# clone project
git clone https://github.com/sumneko/lua-language-server
cd lua-language-server
git submodule update --init --recursive

cd 3rd/luamake
compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild
