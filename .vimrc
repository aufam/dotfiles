set number
set relativenumber
set spell
set wrap!
set mouse=a
syntax on

" indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set scrolloff=8
set expandtab
set autoindent

" enable highlight search pattern
set hlsearch
set incsearch

" enable smart case sensitivity
set ignorecase
set smartcase

" status line
set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" some highlights
set cursorline
highlight Cursoreline cterm=bold ctermbg=black
highlight SpellBad cterm=underline ctermbg=NONE

" show the matching part
set showmatch

" move lines up/down using shift K/shift J
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" enable color themes
if !has('gui_running')
    set t_Co=255
endif

set termguicolors

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
Plug 'prabirshrestha/vim-lsp'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'gruvbox-community/gruvbox'
Plug 'crusoexia/vim-monokai'

call plug#end()

colorscheme gruvbox

autocmd FileType c,cpp setlocal commentstring=//\ %s
