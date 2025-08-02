" Leader key
let mapleader = " "

" Line numbers
set number
set relativenumber
set scrolloff=10
set nocursorline

" Tabs and indentation
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set autoindent
set nowrap
set backspace=indent,eol,start

" Show whitespace
set list
set listchars=tab:\ \ ,trail:-

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" UI settings
set title
set titleold=Terminal
set titlestring=%F
set showmatch
set wildmenu
set wildmode=longest:full,full
set path+=**
set completeopt=menuone,noinsert,noselect

" Status line
function! BufferList()
  let l:buflist = []
  for buf in range(1, bufnr('$'))
    if buflisted(buf)
      let name = bufname(buf) !=# '' ? fnamemodify(bufname(buf), ':t') : '[No Name]'
      let is_current = (buf == bufnr('%')) ? '*' : ' '
      let is_modified = getbufvar(buf, '&modified') ? '+' : ''
      call add(l:buflist, printf('%s%d:%s%s', is_current, buf, name, is_modified))
    endif
  endfor
  return join(l:buflist, ' ')
endfunction

function! ModeName()
  return get({
        \ 'n': 'NORMAL',
        \ 'i': 'INSERT',
        \ 'v': 'VISUAL',
        \ 'V': 'V-LINE',
        \ "\<C-v>": 'V-BLOCK',
        \ 'c': 'COMMAND',
        \ 'R': 'REPLACE',
        \ 's': 'SELECT',
        \ }, mode(), 'OTHER')
endfunction

set statusline=%{ModeName()}\ %{BufferList()}\ %=%{&fileencoding}\ %{&fileformat}
set laststatus=2
set ruler
set showmode
set showcmd

" Dafault file encoding
set encoding=utf-8              " Vim's internal encoding
set fileencoding=utf-8          " Default for new files
set fileencodings=utf-8,ucs-bom,latin1 " Order to try when reading files

" Sign column (some Vim builds may ignore this)
set signcolumn=yes

" Clipboard (check if supported)
if has("clipboard")
  set clipboard=unnamed,unnamedplus
endif

" Enable true colors (if terminal supports it)
if has("termguicolors")
  set termguicolors
endif

" Wildignore patterns
set wildignore+=*.o,*.obj,*.pyc,*.class,*.jar

" Highlight custom TODO-like comments
syntax match TodoComment /\v<(TODO|FIXME|NOTE):?/
highlight default link TodoComment Todo

" Return to last edit position when opening a file
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Highlight on yank TODO
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup END

" Set tab width to 2 for some filetypes
autocmd FileType javascript,typescript,json,html,css setlocal tabstop=2 shiftwidth=2

" Auto-resize splits when resizing the window
autocmd VimResized * tabdo wincmd =

" Create directories on save if not exist
function! s:mkdir_on_save()
  let dir = expand('%:p:h')
  if !isdirectory(dir)
    call mkdir(dir, 'p')
  endif
endfunction
autocmd BufWritePre * call <SID>mkdir_on_save()

" Remove trailing whitespace and carriage returns on save
autocmd BufWritePre * %s/\s\+$//e | %s/\r//e

" Visual Mode: Move selected lines up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Visual Mode: Indent and reselect
vnoremap < <gv
vnoremap > >gv

" Normal Mode: Join lines without moving cursor
nnoremap J mzJ`z

" Scroll and center
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Center search results
nnoremap n nzzzv
nnoremap N Nzzzv

" Re-indent paragraph
nnoremap =ap ma=ap'a

" Clear search highlight
nnoremap <silent> <leader><leader> :noh<CR>

" Paste over selection without overwriting unnamed register
nnoremap <leader>p "_dP

" Clipboard: yank/cut (requires +clipboard)
nnoremap YY "+yy
nnoremap XX "+dd
vnoremap <leader>p "_dP
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y

" Quick substitution using word under cursor
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Buffer navigation
nnoremap <S-Tab> :bp<CR>
nnoremap <Tab> :bn<CR>
nnoremap <leader>c :bd<CR>
nnoremap <leader>C :bd!<CR>

" Jump to specific buffer by number
nnoremap <leader>1 :buffer 1<CR>
nnoremap <leader>2 :buffer 2<CR>
nnoremap <leader>3 :buffer 3<CR>
nnoremap <leader>4 :buffer 4<CR>
nnoremap <leader>5 :buffer 5<CR>
nnoremap <leader>6 :buffer 6<CR>
nnoremap <leader>7 :buffer 7<CR>
nnoremap <leader>8 :buffer 8<CR>
nnoremap <leader>9 :buffer 9<CR>

" Trim trailing whitespace and \r (UTF-8 only)
function! TrimWhitespaceIfUTF8()
  if &fileencoding ==# 'utf-8'
    silent! %s/\r//ge
    silent! %s/\s\+$//e
  endif
endfunction
nnoremap <silent> <leader>F :call TrimWhitespaceIfUTF8()<CR>

