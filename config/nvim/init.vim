"""""""" nvim.init
set nocompatible
filetype off

"""" vim plug
call plug#begin('~/.config/nvim/plugged')
" general vim shit
Plug 'Konfekt/vim-CtrlXA'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" syntax highlighting / colorschemes
Plug 'morhetz/gruvbox'
Plug 'vim-syntastic/syntastic'
Plug 'sheerun/vim-polyglot'
"" language plugins
" python specific
Plug 'psf/black', { 'branch': 'stable' }
Plug 'nvie/vim-flake8'

call plug#end()
filetype plugin indent on

"""" quality of life
"" lets and sets
let &t_ut='' " tell vim to draw background color
set backupcopy=yes
set encoding=utf-8
set ignorecase
set number
set relativenumber
set ruler
set showcmd
set smartcase
set so=2
set showmatch
set spell
set wildmenu

"" tab settings
set backspace=indent,eol,start
set noexpandtab
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4
set tabstop=4

"" misc
syntax on

" flag unnecessary whitespace
highlight BadWhitespace ctermbg=red
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s\+$/

"""" plugin settings
"" coc settings
set cmdheight=2 " coc.nvim: more space for displaying messages
set hidden " coc.nvim
set nobackup " coc.nvim
set nowritebackup " coc.nvim
"if has("patch-8.1.1564") " coc.nvim: gives another space in number column
"	set signcolumn=number
"else
"	set signcolumn=yes
"endif
set shortmess+=c " coc.nvim
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
set updatetime=300 " coc.nvim


"" syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"""" language settings
"" bash
autocmd FileType bash setlocal shiftwidth=2 softtabstop=2 expandtab

"" i3 config
aug i3_ft_detection
	au!
	au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

"" python
" black
autocmd BufWritePre *.py execute ':Black'
" syntax highlighting
let g:python_highlight_all = 1
" PEP-8 indentation
au BufNewFile,BufRead *.py
	\ set textwidth=88
	\ | set expandtab
	\ | set autoindent
	\ | set fileformat=unix

"""" mappings
"" coc.nvim
" use tab for trigger completion
inoremap <silent><expr><TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction

" use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" make <CR> auto-select the first completion item and \
" notify coc.nvim to format on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
							\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" use '[g' and ']g' to navigate diagnostics
" ':CocDiagnostics' for all in current buffer
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" use 'K' to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('cword')
	endif
endfunction

" add ':Format' command to format current buffer
command! -nargs=0 Format :call CocAction('format')

" add ':Fold' command to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

"" for everywhere
" map 'jk' to escape
imap jk <Esc>
" map <F4> to toggle search highlighting
nnoremap <F4> :set hlsearch! hlsearch?<CR>

"" for my todo list :3
" mark item as done
let @d="ddGpf\<Space>;rX"
nnoremap d<C-D> @dA<C-R>=strftime(" <%Y-%m-%d>")<CR><Esc>''
" mark item as undone
let @u="ddggpfXr\<Space>"
nnoremap u<C-U> @uf<hD0
" new inactive item
let @n="O- [ ] "
" new active item
let @a="@n<!--a-->\<Esc>Bi"

"""" colorscheme
if (has("termguicolors"))
	set termguicolors
endif
set background=dark
autocmd vimenter * colorscheme gruvbox
