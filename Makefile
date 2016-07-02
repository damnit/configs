DOTVIM = $$HOME/.vim
DOTI3 = $$HOME/.i3
USER_FONTS = $$HOME/.local/share/fonts
ME = $(shell git config --global --get user.name)
MAIL = $(shell git config --global --get user.email)
AUTOLOAD = $$HOME/.vim/autoload
BUNDLE = $$HOME/.vim/bundle
TEMPLATES = $$HOME/.vim/templates
BUNDLES = $(shell ls $(BUNDLE))
VIMPLUGS = $(shell cat vimplugins.txt)
DOTFILES = .vimrc .bashrc .dir_colors .tmux.conf .gitignore_global .jscsrc

.PHONY: status

status:
	@echo TODOS:
	@echo - fix tmux visual line mode behaviour in docker
	@echo - also install completion scripts to source in bashrc

folders:
	@echo creating dirs if not already done
	mkdir -p $(AUTOLOAD) $(BUNDLE) $(TEMPLATES) $(DOTI3) $(USER_FONTS)

dotfiles: folders
	@echo copying dotfiles
	@$(foreach DOTFILE, $(DOTFILES), cp $$PWD/$(DOTFILE) $$HOME;)
	@cp $$PWD/.vim/templates/* $(TEMPLATES)
	@cp $$PWD/.i3/config $(HOME)/.i3/config
	@echo replacing user.name with $(ME) in .vimrc
	@sed -i 's/user.name/$(ME)/' $(HOME)/.vimrc
	@echo replacing user.email with $(MAIL) in .vimrc
	@sed -i 's/user.email/$(MAIL)/' $(HOME)/.vimrc

plugins: folders
	@echo Setting up / updating plugins in $(BUNDLE)
	@$(foreach REPO, $(VIMPLUGS), \
		if test -d $(BUNDLE)/$(shell echo $(REPO) | sed 's#.*/##' | sed 's/\(.*\).git/\1/'); \
		then echo $(REPO); cd $(BUNDLE)/$(shell echo $(REPO) | sed 's#.*/##' | sed 's/\(.*\).git/\1/'); git pull; \
		else cd $(BUNDLE); git clone --depth=1 $(REPO) $(shell echo $(REPO) | sed 's#.*/##' | sed 's/\(.*\).git/\1/');\
		fi;)

remove-plugins: folders
	@echo checking for plugins to be removed...
	@$(foreach DIR, $(shell ls -1 $(BUNDLE)), \
		if [ $(shell grep $(DIR) vimplugins.txt &> /dev/null; echo $$?) -ne 0 ]; \
		then echo "DELETING $(DIR) as it is not in vimplugins.txt anymore"; rm -rf $(BUNDLE)/$(DIR);\
		fi;)

install: dotfiles fonts pathogen vimproc plugins
	@echo installation successful

update: fonts remove-plugins vimproc plugins
	@echo update successful

fonts: folders
	@if test -d $(HOME)/.local/share/fonts/envy; then echo "envy installed"; else git clone https://gist.github.com/9038570.git $(HOME)/.local/share/fonts/envy; fi
	@if test -d $(HOME)/.local/share/fonts/RobotoMono; then echo "RobotoMono installed"; else git clone https://gist.github.com/damnit/57b979311788b14762181242daea7052 $(HOME)/.local/share/fonts/RobotoMono; fi
	@fc-cache

pathogen: folders
	@echo installing pathogen
	@wget https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim -O $(AUTOLOAD)/pathogen.vim

vimproc: folders
	@echo Installing vimproc
	@if test -d $(BUNDLE)/vimproc.vim; then cd $(BUNDLE)/vimproc.vim/ ; git pull; else git --git-dir=$(BUNDLE)/ clone https://github.com/Shougo/vimproc.vim.git $(BUNDLE)/vimproc.vim; fi;
	@echo running compile target to build the binaries
	@cd $(BUNDLE)/vimproc.vim ; $(MAKE)

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

