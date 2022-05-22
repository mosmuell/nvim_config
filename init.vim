" enabling copy and paste
set clipboard=unnamedplus

"show line numbers
set number

" colorscheme with light background
set background=dark

" enable using mouse
set mouse=a

hi Pmenu ctermbg=black ctermfg=white
hi Pmenu guibg=#d7e5dc gui=NONE
hi PmenuSel guibg=#b7c7b7 gui=NONE
hi PmenuSbar guibg=#bcbcbc
hi PmenuThumb guibg=#585858
if has('nvim') " Neovim specific commands
	" echo "Loading nvim settings"

	" Changing listchars color
	hi Whitespace ctermfg=DarkGrey

else " Standard vim specific commands
	" echo "Loading vim settings"

	" Changing listchars color
	hi SpecialKey ctermfg=LightGrey

	" copy to clipboard
	xnoremap "+y y:call system("wl-copy", @")<cr>
	nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
	nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p
endif

" show tabs and white spaces
set list
syntax on
set listchars=tab:!·,trail:⎵,nbsp:⎵ " eol:⏎,
set hlsearch

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces (expandtab) or use tab (noexpandtab)
set noexpandtab

" show current filename
set showtabline=2

"""""""""""""""""""
""" VIM PLUGINS """
"""""""""""""""""""

" installing vim-plug (plugin manager for nvim/vim) if not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
			\| PlugInstall --sync | source $MYVIMRC
			\| endif

call plug#begin()
" Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'bfrg/vim-cpp-modern'
Plug 'sheerun/vim-polyglot'

Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown', 'on': 'MarkdownPreview' }
Plug 'christoomey/vim-tmux-navigator'
" Conquer of Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" NERDtree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'

Plug 'preservim/nerdcommenter'

" Colorschemes
Plug 'joshdick/onedark.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'morhetz/gruvbox'
Plug 'sainnhe/everforest'
Plug 'rigellute/rigel'
Plug 'sainnhe/edge'
Plug 'sainnhe/sonokai'

" Vim airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

"""""""""""""""""""
""" Colorscheme """
"""""""""""""""""""

if has('termguicolors')
	set termguicolors
endif

" The configuration options should be placed before `colorscheme sonokai`.
" let g:sonokai_style = 'andromeda'
" let g:sonokai_better_performance = 1
colorscheme codedark

source ~/.config/nvim/coc.vim
source ~/.config/nvim/bclose.vim

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
"
" Disable function highlighting (affects both C and C++ files)
let g:cpp_function_highlight = 1

" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

"""""""""""""""""""
""" Vim Airline """
"""""""""""""""""""

let g:airline_theme = 'codedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1

" Keybindings to change to specific buffers
nmap <silent> <M-1> :b 1<CR>:call SyncTree()<CR>
nmap <silent> <M-2> :b 2<CR>:call SyncTree()<CR>
nmap <silent> <M-3> :b 3<CR>:call SyncTree()<CR>
nmap <silent> <M-4> :b 4<CR>:call SyncTree()<CR>
nmap <silent> <M-5> :b 5<CR>:call SyncTree()<CR>
nmap <silent> <M-6> :b 6<CR>:call SyncTree()<CR>
nmap <silent> <M-7> :b 7<CR>:call SyncTree()<CR>
nmap <silent> <M-8> :b 8<CR>:call SyncTree()<CR>
nmap <silent> <M-9> :b 9<CR>:call SyncTree()<CR>
nmap <silent> <M-0> :b 0<CR>:call SyncTree()<CR>

" Key-mappings to navigate the buffers
noremap <silent> <Tab> :bn<CR>:call SyncTree()<CR> " tab
noremap <silent> <S-Tab> :bp<CR>:call SyncTree()<CR> " Shift + tab
noremap <silent> <M-q> :Bclose<CR>:call SyncTree()<CR> " Alt + q
noremap <silent> <M-S-q> :Bclose!<CR>:call SyncTree()<CR> " Alt + Shift + q

" Git status showing on the statusbar
function! s:update_git_status()
	let g:airline_section_b = "%{get(g:,'coc_git_status')}%{get(b:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}"
endfunction

let g:airline_section_b = "%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}"

autocmd User CocGitStatusChange call s:update_git_status()

""""""""""""""""""""""
""" Nerd Commenter """
""""""""""""""""""""""

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Mapping Ctrl-/ to toggle comments
vmap <C-_> <plug>NERDCommenterToggle
nmap <C-_> <plug>NERDCommenterToggle

"""""""""""""""""""""
""" Fuzzy Finding """
"""""""""""""""""""""

nmap <C-P> :FZF<CR>

""""""""""""""""""""""""""""""""""
""" Vim-Tmux Navigator Binding """
""""""""""""""""""""""""""""""""""

" Custom navigator bindings (as set in tmux)
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>

"""""""""""""""""""""""
""" NERDtree config """
"""""""""""""""""""""""

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Start NERDTree and leave the cursor in it.
" autocmd VimEnter * NERDTree | wincmd p

let g:NERDTreeChDirMode = 1 "CWD is changed when NERDTree is first loaded to the dir it is initialised in
let g:NERDTreeMouseMode = 3 "open any node with single mouse click
nnoremap <C-n> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>

" Make sure vim does not open files and other buffers on NerdTree window
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
let g:plug_window = 'noautocmd vertical topleft new'

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
	return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, we're not in vimdiff and the current file is in the current working
" dir
function! SyncTree()
	if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff && stridx(expand('%:p:h'),getcwd()) >= 0
		NERDTreeFind
		wincmd p
	endif
endfunction

" This looks whether the current file is in the current working directory or
" one of its subfolders.
" " if stridx(expand('%:p:h'),getcwd()) >= 0
" " 	echo "Yes"
" " 	echo expand('%:p:h')
" " 	echo getcwd()
" " else
" " 	echo "nope"
" " 	echo expand('%:p:h')
" " 	echo getcwd()
" " endif

" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()
