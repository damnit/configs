#!/bin/bash
mkdir -p ~/.vim/{autoload,bundle} && cd ~/.vim/autoload
echo "getting pathogen"
wget https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
cd ~/.vim/bundle/
echo "installing plugins..."
git clone https://github.com/Lokaltog/vim-powerline.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/vim-scripts/ctags.vim.git
git clone https://github.com/ervandew/supertab.git
git clone https://github.com/jezcope/vim-align.git
git clone git://github.com/tpope/vim-surround.git
git clone https://github.com/vim-scripts/The-NERD-Commenter.git
git clone https://github.com/vim-scripts/pythoncomplete.git
git clone https://github.com/scrooloose/syntastic.git
git clone https://github.com/tpope/vim-markdown.git
git clone https://github.com/majutsushi/tagbar.git
git clone https://github.com/kien/ctrlp.vim.git
git clone https://github.com/groenewege/vim-less.git
git clone https://github.com/klen/python-mode.git
echo "done :)"
