set nocompatible              " required
filetype off                  " required

" set the runtime path to include vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'nvie/vim-flake8'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'Konfekt/vim-CtrlXA'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-speeddating'
Plugin 'ycm-core/YouCompleteMe'

" plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on

" settings for polyglot
"" i3config.vim
aug i3_ft_detection
	au!
	au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

"" python-syntax
let g:python_highlight_all=1

" settings for syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" settings for indentLine
let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" add ctrlxa to speeddating
nmap <Plug>SpeedDatingFallbackUp   <Plug>(CtrlXA-CtrlA)
nmap <Plug>SpeedDatingFallbackDown <Plug>(CtrlXA-CtrlX)

" flag unnecessary white space
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

let &t_ut=''

" proper PEP-8 indentation
au BufNewFile,BufRead *.py 
    \ set tabstop=4
    \ | set softtabstop=4
    \ | set shiftwidth=4
    \ | set textwidth=88
    \ | set expandtab
    \ | set autoindent
    \ | set fileformat=unix

" tab lengths
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

" some tab settings
set showmatch
set smarttab 
set smartindent
"set autoindent
set backspace=indent,eol,start

" autoclose window after completion
let g:ycm_autoclose_preview_window_after_completion=1

" clangd support in ycm-core
let g:ycm_clangd_binary_path = "/usr/bin/clangd"

" map 'g' to define when paired with leader key
let mapleader = ","
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" basic quality of life improvements
set encoding=utf-8
set ignorecase
set number
set relativenumber
set ruler
set showcmd
set smartcase
set so=2
set spell
set wildmenu
syntax on

" mappings
imap jk <Esc>
nmap <CR> :FZF<CR>
nnoremap <F4> set hlsearch! hlsearch?<CR>
nnoremap <F9> :Black<CR>

"" macros for marking items in todo list
" mark item as done
let @d="ddGprX"
nnoremap d<C-D> @dA<C-R>=strftime(" <%Y-%m-%d>")<CR><Esc>''
" unmark item as done
let @u="ddggPr*"
nnoremap u<C-U> @uf<hD0
" new active item
let @a="O! "
" new inactive item
let @n="O* "

autocmd FileType bash setlocal shiftwidth=4 softtabstop=4 expandtab
"autocmd BufWritePre *.py execute ':Black'

" gruvbox settings
autocmd vimenter * colorscheme gruvbox

set background=dark
