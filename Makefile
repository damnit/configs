DOTVIM = $$HOME/.vim
AUTOLOAD = $$HOME/.vim/autoload
BUNDLE = $$HOME/.vim/bundle
SKELETONS = $$HOME/.vim/skeletons
BUNDLES = $(shell ls $(BUNDLE))
DATE = `date +'%Y-%m-%d'`
VIMPLUGS = $(shell cat vimplugins.txt)
DOTFILES = .vimrc .bashrc .dir_colors .screenrc .gitignore_global

.PHONY: status

status:
	@echo TODOS:
	@echo - provide paths and not file names
	@echo - fix this status target
	@echo - fix skeleton initiation

folders:
	@echo creating dirs if not already done
	mkdir -p $(DOTVIM)/{autoload,bundle,skeletons}
	mkdir -p $(HOME)/.i3

dotfiles:
	@echo copying dotfiles
	@$(foreach DOTFILE, $(DOTFILES), cp $$PWD/$(DOTFILE) $$HOME;)
	@cp $$PWD/.vim/skeletons/* $(SKELETONS)
	@cp $$PWD/.i3/config $(HOME)/.i3/config

pathogen:
	@echo installing pathogen
	wget https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim -O $(AUTOLOAD)/pathogen.vim

vimplugins: folders pathogen
	@echo Setting up plugins in $(BUNDLE)
	@$(foreach REPO, $(VIMPLUGS), git clone $(REPO) $(BUNDLE)/$(shell echo $(REPO) | sed 's#.*/##' | sed 's/\(.*\).git/\1/');)

install: dotfiles vimplugins
	@echo installation successful

update: dotfiles
	@echo updating repos copying dotfiles
	@$(foreach PLUGIN, $(BUNDLES), echo pulling $(PLUGIN)... && git --git-dir=$(BUNDLE)/$(PLUGIN)/.git pull;)
	@echo update successful

vimbackup:
	@echo doing a backup job on your .vim stuff
	tar czf /tmp/$(DATE).dotvim.tar.gz $$HOME/.vimrc $(DOTVIM)
