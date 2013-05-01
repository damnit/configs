" =====
" VIMRC
" =====

" Use Vim settings, rather than Vi settings.
" This must be first because it changes other options
set nocompatible

" Use comma instead of backslash
let mapleader=","
let maplocalleader=","

" Load Pathogen # all plugins out of .vim/autoload
call pathogen#infect()
filetype plugin indent on

" =============
" VI COMPATIBLE
" =============
set tabstop=4 			" 4 spaces for tabs
set shiftwidth=4 		" number of spaces for each indent step
set autoindent			" indent of current line when starting a new one
set showmatch			" briefly jump into a matching bracket
set number	    		" show line numbers
set nolist		    	" please don't show white spaces characters and tabs

" ============
" VIM SPECIFIC
" ============
syntax on
set expandtab 			" expands tabs to spaces
set softtabstop=4 		" 4 spaces for tabs
set visualbell			" and don't beep
set autoread			" read changed files
set incsearch			" jump to searchterm
set numberwidth=1		" width for numbers
set wrap			    " no line wrapping
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
set textwidth=80        " auto set tw=80
"set lcs=trail: ,extends:>,precedes:<,tab:
"set magic			" regular expression magic

" =================
" Keyboard mappings
" =================

map <C-T> :tabnew<CR>

" open a terminal buffer (ConqueTerm Plugin)
" http://code.google.com/p/conque/
noremap <f1> :ConqueTermSplit bash <cr>

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

" pylint plugin
let g:pylint_onwrite=0
let g:pylint_cwindow=1
let g:pylint_show_rate=1

" control-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|pyc|pyo)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" ============
" Autocommands
" ============

if has("autocmd") && !exists("autocommands_loaded")
  let autocommands_loaded=1

  " Enable file type detection.
  filetype plugin indent on

  " augroup vimrcEx
  " Remove all autocommands for the current group  
  " autocmd!

  " Textwidth 80 characters :-)
  autocmd FileType text setlocal textwidth=80

  " jump to the last cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
  autocmd FileType javascript set ts=4 sw=4
  autocmd FileType html set ts=2 sw=2 expandtab
  autocmd FileType CHANGELOG set ts=4 sw=4 expandtab
  autocmd FileType cfg set ts=4 sw=4 expandtab
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  " autocmd FileType python compiler pylint

  " add cusstom commentstring for nginx
  autocmd FileType nginx let &l:commentstring='#%s'

  autocmd BufNewFile,BufRead *.dtml setfiletype css
  autocmd BufNewFile,BufRead *.pt setfiletype html
  autocmd BufNewFile,BufRead *.zcml setfiletype xml
  autocmd BufNewFile,BufRead *.cpy setfiletype python
  autocmd BufNewFile,BufRead *.rst setfiletype rest
  autocmd BufNewFile,BufRead *.txt setfiletype rest
  autocmd BufNewFile,BufRead *.cfg setfiletype cfg
  autocmd BufNewFile,BufRead error.log setfiletype apachelogs
  autocmd BufNewFile,BufRead access.log setfiletype apachelogs
  autocmd BufNewFile,BufRead *.scala setfiletype scala

  " abbrevations
  autocmd FileType python abbr kpdb import pdb; pdb.set_trace()
  autocmd FileType python abbr kipdb from ipdb import set_trace; set_trace()
  autocmd FileType python abbr iemb from IPython import embed; embed()

  " VIM footers
  autocmd FileType css abbr kvim /* vim: set ft=css ts=4 sw=4 expandtab : */
  autocmd FileType javscript abbr kvim /* vim: set ft=javscript ts=4 sw=4 expandtab : */
  autocmd FileType rst abbr kvim .. vim: set ft=rst ts=4 sw=4 expandtab tw=80 :
  autocmd FileType moin abbr kvim .. vim: set ft=moin ts=2 sw=4 expandtab tw=80 :
  autocmd FileType python abbr kvim # vim: set ft=python ts=4 sw=4 expandtab :
  autocmd FileType xml abbr kvim <!-- vim: set ft=xml ts=2 sw=2 expandtab : -->
  autocmd FileType html abbr kvim <!-- vim: set ft=html ts=2 sw=2 expandtab : -->
  autocmd FileType changelog abbr kvim vim: set ft=changelog ts=4 sw=4 expandtab :
  autocmd FileType cfg abbr kvim # vim: set ft=cfg ts=4 sw=4 expandtab :
  autocmd FileType config abbr kvim # vim: set ft=config ts=4 sw=4 expandtab :

  " load Templates with kmod
  autocmd FileType python abbr kmod :r ~/.vim/skeletons/skeleton.py
  autocmd FileType rst abbr kmod :r ~/.vim/skeletons/skeleton.rst
  autocmd FileType zpt abbr kmod :r ~/.vim/skeletons/skeleton.pt
  autocmd FileType changelog abbr kmod :r ~/.vim/skeletons/skeleton.changelog
  autocmd FileType xml abbr kmod :r ~/.vim/skeletons/skeleton.zcml

  augroup END
endif
