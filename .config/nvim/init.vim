"     _                       _ _
"  __| | __ _ _ __ ___  _ __ (_) |_
" / _` |/ _` | '_ ` _ \| '_ \| | __|
"| (_| | (_| | | | | | | | | | | |_
" \__,_|\__,_|_| |_| |_|_| |_|_|\__|
"
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
set autoread              " read changed files
set colorcolumn=80        " color column 80
set expandtab             " expands tabs to spaces
set hlsearch              " highlight a search term
set ignorecase            " case sensitive search
set incsearch             " jump to searchterm
set mousehide             " hide mouse pointer while typing
set nobackup              " shit wreck swap files
set nofoldenable
set noswapfile            " shit wreck swap files
set nowrap                " no line wrapping
set numberwidth=1         " width for numbers
set scrolloff=3           " keep more content
set showtabline=2         " always show tab bar
set smartcase             " only case sensitive if upper characters
set softtabstop=4         " 4 spaces for tabs
set visualbell            " and don't beep
set wildmenu              " tab completion for files/buffers act like bash
set wildmode=longest,list " emacs-style tab completion when selecting
colorscheme kanagawa

set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

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

" clear search buffer when hitting return
:nnoremap <cr> :nohlsearch<cr>/<bs>

" ==============
" Plugin configs
" ==============

" Autoformat
let g:formatters_javascript = ['jscs', 'jsbeautify']

" Unite
nnoremap <silent> <F8> :Unite buffer file_rec/async <cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

" binding for tagbar
nmap <F7> :TagbarToggle<CR>

" nerdtree plugin
nnoremap <F1> :NERDTreeToggle<CR>
let g:NERDTreeMapActivateNode="<cr>"
let g:NERDTreeMapOpenSplit="<s-cr>"
let g:NERDTreeIgnore=['\.pyc$', '\.pyo$', '\~$', '\.aux$', '\.toc$', '\.lof$', '\.idx$']
let g:NERDTreeChDirMode=2

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=3
let g:syntastic_check_on_wq=0
let g:syntastic_python_python_exec='/usr/bin/python3'
let g:syntastic_html_tidy_exec='/usr/bin/tidy'
let g:syntastic_html_tidy_ignore_errors=['<input> proprietary attribute "role"']

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

" airline conf requires aur/ttf-powerline-fonts-git
set laststatus=2
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#bufferline#enabled = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" delimitMate
let b:delimitMate_autoclose = 0

" vim-template
let g:username = 'user.name'
let g:email = 'user.email'
let g:templates_directory = '~/.vim/templates'

" telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

let g:todo_done_filename = 'done.txt'

" ===============
" custom commands
" ===============
:command Bigfont set guifont=Monospace\ 14
:command Fontnormal set guifont=Monospace\ 10

:command Pjson %!python -m json.tool
:command Paste :r! xclip -o

" ================
" make gvim pretty
" ================
if has("gui_running")
  :set guioptions-=m  "remove menu bar
  :set guioptions-=T  "remove toolbar
  :set guioptions-=r  "remove right-hand scroll bar
  :set guioptions-=L  "remove left-hand scroll bar
  :set guifont=Envy\ Code\ R\ for\ Powerline
endif

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
