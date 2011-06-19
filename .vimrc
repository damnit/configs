" =====
" VIMRC
" =====

" Use Vim settings, rather than Vi settings.
" This must be first because it changes other options
set nocompatible

"" Use comma instead of backslash
let mapleader=","
let maplocalleader=","

"" Load Pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

colorscheme github

" vi compatible
" -------------
set tabstop=4               " 4 spaces for tabs
set shiftwidth=4            " number of spaces use for each step of indent
set autoindent              " copy indent from current line when starting a new line
set showmatch               " briefly jump into a matching bracket
set number                  " show line numbers
set list                    " show white space characters and tabs

" vim specific
" ------------
syntax on
set expandtab               " expand tabs to spaces
set softtabstop=4           " 4 spaces for tabs
set visualbell              " don't beep
set autoread                " automatically re-read changed files
set incsearch               " jump to searchterm
set numberwidth=1           " width for numbers
set nowrap                  " no line wrapping
set showtabline=2           " always show tab bar
set scrolloff=3             " keep more content when scrolling off the end of a buffer
set wildmenu                " make tab completion for files/buffers act like bash
set wildmode=longest,list   " use emacs-style tab completion when selecting files, etc
set hlsearch                " highlight search term
set ignorecase              " case sensitive search
set smartcase               " only case sensitive if they contain upper case characters
set mousehide               " Hide the mouse pointer while typing
set lcs=trail:·,extends:>,precedes:<,tab:»·
"set magic                   " regular expression magic

" =================
" Keyboard Mappings
" =================

" open a terminal buffer (ConqueTerm Plugin)
noremap <f1> :ConqueTermSplit bash <cr>

" write the file
nmap <f2> :w <cr>

" close the buffer
nmap <f4> :bdel <cr>

" previous buffer
nmap <f5> :bp <cr>

" Next Buffer
nmap <f6> :bn <cr>

" move in split windows with ctrl key
nmap <C-Up> <Up>
nmap <C-Down> <Down>
nmap <C-Right> <Right>
nmap <C-Left> <Left>

" go to next / previous tab d for mac, m for pc
map  <M-left>  :tabp <cr>
imap <M-left>  <esc> :tabp <cr> i
map  <M-right> :tabn <cr>
imap <M-right> <esc> :tabn <cr> i

" clear the search buffer when hitting return
:nnoremap <cr> :nohlsearch<cr>/<bs>

" find whitespace
map <leader>ws :%s/ *$//g<cr><c-o><cr>

" highligths all from import statements
com! FindLastImport :execute'normal G<cr>' | :execute':normal ?^\(from\|import\)\><cr>'
map <leader>fi :FindLastImport<cr>

" Map ,e to open files in the same directory as the current file
map <leader>e :e <C-R>=expand("%:h")<cr>/

" ----------------------------------------------------------------------------
" BACKUP
" ----------------------------------------------------------------------------

" backup, swap, views
set backup                       " backups are nice ...
set backupdir=$HOME/.vimbackup// " but not when they clog .
set directory=$HOME/.vimswap//   " Same for swap files
set viewdir=$HOME/.vimviews//    " same for view files

"" Creating directories if they don't exist
silent execute '!mkdir -p $HOME/.vimbackup'
silent execute '!mkdir -p $HOME/.vimswap'
silent execute '!mkdir -p $HOME/.vimviews'
au BufWinLeave * silent! mkview   " make vim save view (state) (folds, cursor, etc)
au BufWinEnter * silent! loadview " make vim load view (state) (folds, cursor, etc)

" ----------------------------------------------------------------------------
" PLUGIN CONFIGS
" ----------------------------------------------------------------------------

"" pyflakes plugin
let g:pyflakes_use_quickfix = 0

"" vimgrep plugin
let Grep_Xargs_Options='-0'
nnoremap <silent> <f3> :Grep <cr>
nnoremap <silent> <s-f3> :Rgrep <cr>

"" nerdtree plugin
map <silent><c-tab> :NERDTreeToggle <cr>
nnoremap <silent> <c-f> :call FindInNERDTree() <cr>
let g:NERDTreeMapActivateNode="<cr>"
let g:NERDTreeMapOpenSplit="<s-cr>"
let g:NERDTreeIgnore=['\.pyc$', '\.pyo$', '\~$']
let g:NERDTreeChDirMode=2

"" supertab plugin
"let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabDefaultCompletionType = "<c-x><c-p>"

"" python syntax file
let python_highlight_all=1
let python_slow_sync=1

"" vcscommand plugin
let g:VCSCommandMapPrefix='<Leader>x'

"" EasyGrep
let g:EasyGrepRecursive=1

"" pylint plugin
let g:pylint_onwrite = 0
let g:pylint_cwindow = 1
let g:pylint_show_rate = 1

" ----------------------------------------------------------------------------
" AUTOCOMMANDS
" ----------------------------------------------------------------------------

if has("autocmd") && !exists("autocommands_loaded")
  let autocommands_loaded=1

  " Enable file type detection.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx

  " Remove ALL autocommands for the current group.
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  "autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd FileType javascript set ts=4 sw=4
  autocmd FileType html set ts=2 sw=2 expandtab
  autocmd FileType CHANGELOG set ts=4 sw=4 expandtab
  autocmd FileType cfg set ts=4 sw=4 expandtab
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  autocmd FileType python compiler pylint

  " add cusstom commentstring for nginx
  autocmd FileType nginx let &l:commentstring='#%s'

  autocmd BufNewFile,BufRead *.dtml setfiletype css
  autocmd BufNewFile,BufRead *.pt setfiletype html
  autocmd BufNewFile,BufRead *.zcml setfiletype xml
  autocmd BufNewFile,BufRead *.cpy setfiletype python
  autocmd BufNewFile,BufRead *.rst setfiletype rest
  autocmd BufNewFile,BufRead *.txt setfiletype rest
  autocmd BufNewFile,BufRead *.cfg setfiletype cfg
  autocmd BufNewFile,BufRead *.kss setfiletype css
  autocmd BufNewFile,BufRead error.log setfiletype apachelogs
  autocmd BufNewFile,BufRead access.log setfiletype apachelogs
  autocmd BufRead,BufNewFile *.vcl setfiletype vcl

  " abbrevations
  autocmd FileType python abbr kpdb import pdb; pdb.set_trace()
  autocmd FileType python abbr kipdb from ipdb import set_trace; set_trace()

  " VIM footers
  autocmd FileType css abbr kvim /* vim: set ft=css ts=4 sw=4 expandtab : */
  autocmd FileType javscript abbr kvim /* vim: set ft=javscript ts=4 sw=4 expandtab : */
  autocmd FileType rst abbr kvim .. vim: set ft=rst ts=4 sw=4 expandtab tw=78 :
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
