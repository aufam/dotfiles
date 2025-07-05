" curl -fLo ~/.vimrc https://raw.githubusercontent.com/aufam/configs/main/.vimrc

" common settings
set number
set relativenumber
set wrap!
set mouse=a
set scrolloff=10
set autoread
set cursorline
let mapleader=' '
syntax enable

" encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

" indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set backspace=indent,eol,start
set list
set listchars=tab:\ \ ,trail:-

" highlight and search
set hlsearch
set incsearch
set hidden
set ignorecase
set smartcase
set wildmenu
nnoremap <silent> <leader><space> :noh<cr>
nnoremap n nzzzv
nnoremap N Nzzzv

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
set statusline=%{mode()}\ \|\ %F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
set noshowmode

" copy paste cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif
noremap <leader>p "_dP
noremap YY "+y<CR>
noremap XX "+x<CR>

" buffer nav
noremap <leader>q :bp<CR>
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

set termguicolors
set background=dark
