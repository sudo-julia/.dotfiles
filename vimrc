set nocompatible              " required
filetype off                  " required

" set the runtime path to include vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" set vundle to manage self
Plugin 'gmarik/Vundle.vim'

" add plugins here
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'hdima/python-syntax'
Plugin 'arzg/vim-sh'
Plugin 'junegunn/fzf'
Plugin 'tpope/vim-speeddating'
Plugin 'Konfekt/vim-CtrlXA'
Plugin 'JuliaEditorSupport/julia-vim'

" plugins must be added before the following line
call vundle#end()            " required

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
    \ | set textwidth=79
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
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" set leader key to space
let mapleader = ","

" basic quality of life improvements
set number
set relativenumber
set ignorecase
set smartcase
set ruler
set wildmenu
set so=2
imap jk <Esc>

" make code look pretty
let python_highlight_all=1
syntax on
nnoremap <F4> set hlsearch! hlsearch?<CR>

" macros for marking items in todo list
let @d="ddGprX''"
nnoremap d<C-D> @d
let @u="ddggPr*"
nnoremap u<C-U> @u

autocmd FileType bash setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType text setlocal spell
autocmd FileType markdown setlocal spell

" gruvbox settings
"let g:gruvbox_ is syntax
autocmd vimenter * colorscheme gruvbox
set background=dark
