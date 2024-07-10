" curl -fLo ~/.vimrc https://raw.githubusercontent.com/aufam/configs/main/.vimrc

" common settings
set number
set relativenumber
set wrap!
set mouse=a
set autoread
let mapleader=','
syntax on

" indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set scrolloff=8
set expandtab
set autoindent
set backspace=indent,eol,start
set list
set listchars=tab:▶︎\ ,trail:●

" enable highlight search pattern
set hlsearch
set incsearch
set hidden
set ignorecase
set smartcase
set wildmenu
nnoremap <silent> <leader><space> :noh<cr>

" maintain visual mode after shifting > and <
vmap < <gv
vmap > >gv

" move lines up/down using shift K/shift J
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" status line
set modeline
set modelines=10
set title
set titleold="Terminal"
set titlestring=%F
set laststatus=2
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
nnoremap n nzzzv
nnoremap N Nzzzv
if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" copy paste cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif
noremap YY "+y<CR>
noremap  "+gP<CR>
noremap XX "+x<CR>

" buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>
noremap <leader>c :bd<CR>

" abbreviations and commands
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
command! FixWhitespace :%s/\s\+$//e

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
Plug 'prabirshrestha/vim-lsp'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ayu-theme/ayu-vim'

call plug#end()

" color and themes
if !has('gui_running')
    set t_Co=255
endif
set termguicolors
let ayucolor="dark"
colorscheme ayu

" comment string for c/cpp
autocmd FileType c,cpp setlocal commentstring=//\ %s

