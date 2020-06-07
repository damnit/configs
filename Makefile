DOTI3 = $$HOME/.i3
LOCAL_SHARE = $$HOME/.local/share
USER_FONTS = $$HOME/.local/share/fonts
DOT_NVIM = $$HOME/.config/nvim
AUTOLOAD = $$HOME/.config/nvim/autoload
BUNDLE = $$HOME/.config/nvim/bundle
BUNDLES = $(shell ls $(BUNDLE))
VIMPLUGS = $(shell cat vimplugins.txt)
DOTFILES = .bashrc .dir_colors .tmux.conf .gitignore_global .jscsrc
ME = $(shell git config --global --get user.name)
MAIL = $(shell git config --global --get user.email)

.PHONY: status

status:
	@echo TODOS:
	@echo - fix tmux visual line mode behaviour in docker

folders:
	@echo creating dirs if not already done
	mkdir -p $(AUTOLOAD) $(BUNDLE) $(DOT_NVIM)
	mkdir -p $(DOTI3) $(LOCAL_SHARE) $(USER_FONTS)

dotfiles: folders
	@echo copying dotfiles
	@$(foreach DOTFILE, $(DOTFILES), cp $$PWD/$(DOTFILE) $$HOME;)
	@cp -r $$PWD/.config/nvim/* $(DOT_NVIM)
	@cp $$PWD/.i3/config $(HOME)/.i3/config
	@echo replacing user.name with $(ME) in init.vim
	@sed -i 's/user.name/$(ME)/' $(HOME)/.config/nvim/init.vim
	@echo replacing user.email with $(MAIL) in init.vim
	@sed -i 's/user.email/$(MAIL)/' $(HOME)/.config/nvim/init.vim

plugins: folders
	@echo Setting up / updating plugins in $(BUNDLE)
	@$(foreach REPO, $(VIMPLUGS), \
		if test -d $(BUNDLE)/$(shell echo $(REPO) | sed 's#.*/##' | sed 's/\(.*\).git/\1/'); \
		then echo $(REPO); cd $(BUNDLE)/$(shell echo $(REPO) | sed 's#.*/##' | sed 's/\(.*\).git/\1/'); git checkout * && git pull; \
		else cd $(BUNDLE); git clone --depth=1 $(REPO) $(shell echo $(REPO) | sed 's#.*/##' | sed 's/\(.*\).git/\1/');\
		fi;)

remove-plugins: folders
	@echo checking for plugins to be removed...
	@$(foreach DIR, $(shell ls -1 $(BUNDLE)), \
		if [ $(shell grep $(DIR) vimplugins.txt &> /dev/null; echo $$?) -ne 0 ]; \
		then echo "DELETING $(DIR) as it is not in vimplugins.txt anymore"; rm -rf $(BUNDLE)/$(DIR);\
		fi;)

install: dotfiles pathogen plugins gitcompletion
	@echo installation successful

update: remove-plugins plugins gitcompletion
	@echo update successful

fonts: folders
	@if test -d $(HOME)/.local/share/fonts/envy; then echo "envy installed"; else git clone https://gist.github.com/9038570.git $(HOME)/.local/share/fonts/envy; fi
	@if test -d $(HOME)/.local/share/fonts/RobotoMono; then echo "RobotoMono installed"; else git clone https://gist.github.com/damnit/57b979311788b14762181242daea7052 $(HOME)/.local/share/fonts/RobotoMono; fi
	@fc-cache

pathogen: folders
	@echo installing pathogen
	@wget https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim -O $(AUTOLOAD)/pathogen.vim

gitcompletion:
	@echo curling for git completion and bash stuff
	@wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O $(HOME)/.local/share/git-prompt.sh
	@wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O $(HOME)/.local/share/git-completion.bash

poetry:
	@echo installing poetry
	curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
	$(HOME)/.poetry/bin/poetry completions bash > $(HOME)/.local/share/poetry-completion.bash

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
