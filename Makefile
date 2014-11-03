DOTVIM = $$HOME/.vim
AUTOLOAD = $$HOME/.vim/autoload
BUNDLE = $$HOME/.vim/bundle
SKELETONS = $$HOME/.vim/skeletons
BUNDLES = $(shell ls $(BUNDLE))
DATE = `date +'%Y-%m-%d'`

.PHONY: status

status:
	@echo This is a todo
	@echo Also cat to read the plugins from file

folders:
	@echo Creating dirs if not already done
	mkdir -p $(DOTVIM)/{autoload,bundle,skeletons}

vimplugins:
	@echo Setting up plugins in $(BUNDLE)
	git clone https://github.com/vim-scripts/ctags.vim.git $(BUNDLE)/ctags
	git clone https://github.com/kien/ctrlp.vim.git $(BUNDLE)/ctrlp 
	git clone https://github.com/scrooloose/nerdtree.git $(BUNDLE)/nerdtree
	git clone https://github.com/klen/python-mode.git $(BUNDLE)/python-mode
	git clone https://github.com/vim-scripts/pythoncomplete.git $(BUNDLE)/pythoncomplete
	git clone https://github.com/msanders/snipmate.vim.git $(BUNDLE)/snipmate
	git clone https://github.com/ervandew/supertab.git $(BUNDLE)/supertab
	git clone https://github.com/scrooloose/syntastic.git $(BUNDLE)/syntastic
	git clone https://github.com/majutsushi/tagbar.git $(BUNDLE)/tagbar
	git clone https://github.com/vim-scripts/The-NERD-Commenter.git $(BUNDLE)/nerdcommenter
	git clone https://github.com/bling/vim-airline.git $(BUNDLE)/airline
	git clone https://github.com/jezcope/vim-align.git $(BUNDLE)/align
	git clone https://github.com/groenewege/vim-less.git $(BUNDLE)/less
	git clone https://github.com/tpope/vim-markdown.git $(BUNDLE)/markdown
	git clone https://github.com/tpope/vim-surround.git $(BUNDLE)/surround

vimrc:
	@echo Copying .vimrc
	@cp $$PWD/.vimrc $$HOME

pathogen:
	@echo Installing pathogen
	wget https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim -O $(AUTOLOAD)/pathogen.vim

build: vimrc folders pathogen vimplugins
	@echo build successful

update: vimrc
	@echo updating repos copying .vimrc
	@$(foreach PLUGIN, $(BUNDLES), echo [GIT PULL] $(PLUGIN) && git --git-dir=$(BUNDLE)/$(PLUGIN)/.git pull;)
	@echo update successful

clean:
	@echo cleaning .vim dir and removing .vimrc
	rm -rf $(DOTVIM) $$HOME/.vimrc

backup:
	@echo doing a backup job on your .vim stuff
	tar czf /tmp/$(DATE).dotvim.tar.gz $$HOME/.vimrc $(DOTVIM)
