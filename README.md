# CONFIG FILES #
Generic config files placed in **~**.
Install pyflakes/pylint to make syntastic work with python :)

## CONTENTS ##
- **.vimrc** and **.vim** folder with snapshot of plugins
- **.bashrc** for a nice bash experience
- **.Xdefaults** does some urxvt config stuff
- **.dir_colors** showing some nice colors in bash
- Makefile
- some other shim

## USAGE ##
`make install` does all the installation stuff

## CHANGES ##

### 2015-12-31
* fixed Make targets
* setting correct $TERM
* added rust.vim

### 2015-06-18
* hackfixed Makefile to also copy i3 config
* removed some ugly plugins
* added i3 config

### 2015-03-03
* reworked **PROMPT COMMAND** in .bashrc
* added several plugins
* added .Xdefaults, .Xmodmap

### 2014-11-18
* added tracwiki to vimplugins, in vimrc
* issued some git clone magic where some files and folders are cloned into
  configs folder locally

### 2014-11-04
* added **.dir_colors**
* updated and cleaned .vimrc and plugins
* added **Makefile** for building and updating DOTVIM stuff
* reading vim plugins from text file in **Makefile**

### 2013-11-10
* initial setup.sh
* added .gitignore
* .vimrc in gui - change font
* added python-mode in getvimplugins.sh

### 2011-07-11
* Some awesome colors added in .bashrc prompt
* Showing the py virtualenv you are working in
