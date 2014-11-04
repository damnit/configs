DOTVIM = $$HOME/.vim
AUTOLOAD = $$HOME/.vim/autoload
BUNDLE = $$HOME/.vim/bundle
SKELETONS = $$HOME/.vim/skeletons
BUNDLES = $(shell ls $(BUNDLE))
DATE = `date +'%Y-%m-%d'`
VIMPLUGS = $(shell cat vimplugins.txt)
DOTFILES = .vimrc .gvimrc .bashrc .dir_colors .screenrc .gitignore_global

.PHONY: status

status:
	@echo this is a todo

folders:
	@echo creating dirs if not already done
	mkdir -p $(DOTVIM)/{autoload,bundle,skeletons}

dotfiles:
	@echo copying dotfiles
	@$(foreach DOTFILE, $(DOTFILES), cp $$PWD/$(DOTFILE) $$HOME;)

gitcompletion:
	@echo getting bash completion for git
	git config --global core.autocrlf input
	wget https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -O /opt/scripts/git-completion.bash
	chmod +x /opt/scripts/git-completion.bash

pathogen:
	@echo installing pathogen
	wget https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim -O $(AUTOLOAD)/pathogen.vim

vimplugins: folders pathogen
	@echo Setting up plugins in $(BUNDLE)
	@$(foreach REPO, $(VIMPLUGS), git clone $(REPO) $(BUNDLE)/$(shell echo $(REPO) | sed 's#.*/##');)

install: dotfiles gitcompletion vimplugins
	@echo installation successful

update: dotfiles
	@echo updating repos copying dotfiles
	@$(foreach PLUGIN, $(BUNDLES), echo pulling $(PLUGIN)... && git --git-dir=$(BUNDLE)/$(PLUGIN)/.git pull;)
	@echo update successful

vimbackup:
	@echo doing a backup job on your .vim stuff
	tar czf /tmp/$(DATE).dotvim.tar.gz $$HOME/.vimrc $(DOTVIM)
