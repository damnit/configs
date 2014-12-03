"     _                       _ _
"  __| | __ _ _ __ ___  _ __ (_) |_
" / _` |/ _` | '_ ` _ \| '_ \| | __|
"| (_| | (_| | | | | | | | | | | |_
" \__,_|\__,_|_| |_| |_|_| |_|_|\__|
"
" Use Vim settings, rather than Vi settings.
" This must be first because it changes other options
set clipboard=unnamedplus
set nocompatible

" Use comma instead of backslash
let mapleader=","
let maplocalleader=","

" Load Pathogen # all plugins out of .vim/autoload
call pathogen#infect()

call pathogen#helptags()
filetype plugin on
filetype plugin indent on

" =============
" VI COMPATIBLE
" =============
set tabstop=4 			" 4 spaces for tabs
set shiftwidth=4 		" number of spaces for each indent step
set textwidth=80
set autoindent			" indent of current line when starting a new one
set showmatch			" briefly jump into a matching bracket
set number	    		" show line numbers
set nolist		    	" please don't show white spaces characters and tabs

" ============
" VIM SPECIFIC
" ============
syntax on
colorscheme desert
set expandtab 			" expands tabs to spaces
set softtabstop=4 		" 4 spaces for tabs
set visualbell			" and don't beep
set autoread			" read changed files
set incsearch			" jump to searchterm
set numberwidth=1		" width for numbers
set nowrap			    " no line wrapping
set showtabline=2		" always show tab bar
set scrolloff=3			" keep more content
set wildmenu			" tab completion for files/buffers act like bash
set wildmode=longest,list	" emacs-style tab completion when selecting
set hlsearch 			" highlight a search term
set ignorecase 			" case sensitive search
set smartcase			" only case sensitive if upper characters
set mousehide			" hide mouse pointer while typing
set nobackup			" shit wreck swap files
set noswapfile          " shit wreck swap files
set nofoldenable

" =================
" Keyboard mappings
" =================

map <C-T> :tabnew<CR>

" write changes to a file like :w<ret>
nmap <f2> :w <cr>

" close the buffer like :bdel<ret>
nmap <f4> :bdel <cr>

" previous buffer
nmap <f5> :bp <cr>

" next buffer
nmap <f6> :bn <cr>

" move in split windows with ctrl key
nmap <C-Up> <Up>
nmap <C-Down> <Down>
nmap <C-Right> <Right>
nmap <C-Left> <Left>

" clear search buffer when hitting return
:nnoremap <cr> :nohlsearch<cr>/<bs>

" highligths all from import statements
com! FindLastImport :execute'normal G<cr>' | :execute':normal ?^\(from\|import\)\><cr>'
map <leader>fi :FindLastImport<cr>

" binding for tagbar
nmap <F12> :TagbarToggle<CR>

" ==============
" Plugin configs
" ==============

" nerdtree plugin
map <silent><c-tab> :NERDTreeToggle <cr>
nnoremap <silent> <c-f> :call FindInNERTTree() <cr>
let g:NERDTreeMapActivateNode="<cr>"
let g:NERDTreeMapOpenSplit="<s-cr>"
let g:NERDTreeIgnore=['\.pyc$', '\.pyo$', '\~$', '\.aux$', '\.toc$', '\.lof$', '\.idx$']
let g:NERDTreeChDirMode=2

" supertab plugin
" https://github.com/ervandew/supertab
let g:SuperTabDefaultCompletionType='context'
let g:SuperTabDefaultCompletionType="<c-x><c-p>"

" python syntax file
let python_highlight_all=1
let python_slow_sync=1

" syntastic html tidy
let g:syntastic_html_tidy_exec='/usr/bin/tidy'
let g:syntastic_html_tidy_ignore_errors=['<input> proprietary attribute "role"']

" pylint plugin
let g:pylint_onwrite=0
let g:pylint_cwindow=1
let g:pylint_show_rate=1

" control-p
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|pyc|pyo)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }


" ===============
" custom commands
" ===============
:command Bigfont set guifont=Monospace\ 14
:command Fontnormal set guifont=Monospace\ 10

:command Pjson %!python -m json.tool

" ============
" autocommands
" ============

if has("autocmd") && !exists("autocommands_loaded")
  let autocommands_loaded=1

  " Enable file type detection.
  filetype plugin indent on

  " jump to the last cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd FileType javascript set ts=4 sw=4
  autocmd FileType html set ts=2 sw=2 expandtab
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  autocmd FileType javascript set omnifunc=javascriptcomplete#Complete

  autocmd BufNewFile,BufRead error.log setfiletype apachelogs
  autocmd BufNewFile,BufRead access.log setfiletype apachelogs
  autocmd BufNewFile,BufRead *.moin setfiletype tracwiki

  "vim to load default skeletons on open
  autocmd BufNewFile *.py 0r ~/.vim/skeletons/skeleton.py
  autocmd BufNewFile *.md 0r ~/.vim/skeletons/skeleton.md
  autocmd BufNewFile *.js 0r ~/.vim/skeletons/skeleton.js
  autocmd BufNewFile *.html 0r ~/.vim/skeletons/skeleton.html

  " abbrevations
  autocmd FileType python abbr kpdb import pdb; pdb.set_trace()
  autocmd FileType python abbr kipdb from ipdb import set_trace; set_trace()
  autocmd FileType python abbr iemb from IPython import embed; embed()

  " VIM footers
  autocmd FileType css abbr vfoo /* vim: set ft=css ts=4 sw=4 expandtab : */
  autocmd FileType javascript abbr vfoo /* vim: set ft=javascript ts=4 sw=4 expandtab : */
  autocmd FileType js abbr vfoo /* vim: set ft=javascript ts=4 sw=4 expandtab : */
  autocmd FileType rst abbr vfoo .. vim: set ft=rst ts=4 sw=4 expandtab tw=80 :
  autocmd FileType moin abbr vfoo .. vim: set ft=moin ts=2 sw=4 expandtab tw=80 :
  autocmd FileType python abbr vfoo # vim: set ft=python ts=4 sw=4 expandtab :
  autocmd FileType markdown abbr vfoo <!-- vim: set ft=markdown ts=2 sw=4 expandtab tw=80 : -->
  autocmd FileType xml abbr vfoo <!-- vim: set ft=xml ts=2 sw=2 expandtab : -->
  autocmd FileType html abbr vfoo <!-- vim: set ft=html ts=2 sw=2 expandtab : -->
  autocmd FileType changelog abbr vfoo vim: set ft=changelog ts=4 sw=4 expandtab :
  autocmd FileType cfg abbr vfoo # vim: set ft=cfg ts=4 sw=4 expandtab :
  autocmd FileType config abbr vfoo # vim: set ft=config ts=4 sw=4 expandtab :

endif
