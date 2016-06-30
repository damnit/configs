DOTVIM = $$HOME/.vim
ME = $(shell git config --global --get user.name)
MAIL = $(shell git config --global --get user.email)
AUTOLOAD = $$HOME/.vim/autoload
BUNDLE = $$HOME/.vim/bundle
TEMPLATES = $$HOME/.vim/templates
BUNDLES = $(shell ls $(BUNDLE))
DATE = `date +'%Y-%m-%d'`
VIMPLUGS = $(shell cat vimplugins.txt)
DOTFILES = .vimrc .bashrc .dir_colors .tmux.conf .gitignore_global .jscsrc

.PHONY: status

status:
	@echo TODOS:
	@echo - fix tmux visual line mode behaviour in docker
	@echo - provide target that only checks out new plugin of vimplugs file
	@echo - also install completion scripts to source in bashrc

clean:
	@echo Cleaning vim plugins folder
	@rm -rf $(BUNDLE)/*

folders:
	@echo creating dirs if not already done
	mkdir -p $(DOTVIM)/{autoload,bundle,templates}
	mkdir -p $(HOME)/.local/share/fonts
	mkdir -p $(HOME)/.i3

dotfiles: folders
	@echo copying dotfiles
	@$(foreach DOTFILE, $(DOTFILES), cp $$PWD/$(DOTFILE) $$HOME;)
	@cp $$PWD/.vim/templates/* $(TEMPLATES)
	@cp $$PWD/.i3/config $(HOME)/.i3/config
	@echo replacing user.name with $(ME) in .vimrc
	@sed -i 's/user.name/$(ME)/' $(HOME)/.vimrc
	@echo replacing user.email with $(MAIL) in .vimrc
	@sed -i 's/user.email/$(MAIL)/' $(HOME)/.vimrc

pathogen:
	@echo installing pathogen
	@wget https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim -O $(AUTOLOAD)/pathogen.vim

vimplugins: clean pathogen
	@echo Setting up plugins in $(BUNDLE)
	@$(foreach REPO, $(VIMPLUGS), cd $(BUNDLE); git clone --depth=1 $(REPO) $(shell echo $(REPO) | sed 's#.*/##' | sed 's/\(.*\).git/\1/');)
	@echo Installing vimproc
	@git --git-dir=$(BUNDLE)/ clone https://github.com/Shougo/vimproc.vim.git $(BUNDLE)/vimproc.vim;
	@echo running compile target to build the binaries
	@$(MAKE) compile

install: dotfiles vimplugins fonts
	@echo installation successful

update: dotfiles
	@echo updating repos copying dotfiles
	@$(foreach PLUGIN, $(BUNDLES), echo pulling $(PLUGIN)... && cd $(BUNDLE)/$(PLUGIN); git pull; cd -;)
	#@$(foreach PLUGIN, $(BUNDLES), echo pulling $(PLUGIN)... && git --git-dir=$(BUNDLE)/$(PLUGIN)/.git pull;)
	@echo running compile target to build the binaries
	@$(MAKE) compile
	@echo update successful

vimbackup:
	@echo doing a backup job on your .vim stuff
	tar czf /tmp/$(DATE).dotvim.tar.gz $$HOME/.vimrc $(DOTVIM)

compile:
	@cd $(BUNDLE)/vimproc.vim ; $(MAKE)

fonts: folders
	@if test -d $(HOME)/.local/share/fonts/envy; then echo "envy installed"; else git clone https://gist.github.com/9038570.git $(HOME)/.local/share/fonts/envy; fi
	@if test -d $(HOME)/.local/share/fonts/RobotoMono; then echo "RobotoMono installed"; else git clone https://gist.github.com/damnit/57b979311788b14762181242daea7052 $(HOME)/.local/share/fonts/RobotoMono; fi
	@fc-cache

bashmarks:
	@git clone https://github.com/huyng/bashmarks.git /tmp/bashmarks
	@cd /tmp/bashmarks; make install; cd -; rm -rf /tmp/bashmarks

dockerize:
	@echo building the container
	@echo getting latest pacman mirrorlist
	@wget -O mirrorlist "https://www.archlinux.org/mirrorlist/?country=DE&protocol=http&ip_version=4"
	@sed -i 's/^#Server/Server/' mirrorlist
	@docker build -t workspace .

run:
	xhost +
	docker run --rm -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$$DISPLAY -v $(HOME):$(HOME) --name=workspace workspace /usr/bin/terminator
	xhost -

