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

" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

" remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" plugin
call plug#begin('~/.vim/plugged')
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif

Plug 'ycm-core/YouCompleteMe'
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/grep.vim'
Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-surround'

" themes
Plug 'alligator/accent.vim'
Plug 'davidosomething/vim-colors-meh'
Plug 'ayu-theme/ayu-vim'
Plug 'nikolvs/vim-sunbather'
Plug 'owickstrom/vim-colors-paramount'
Plug 'rose-pine/vim', { 'as': 'rose-pine' }
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

" status line
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'

" vim session
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

" async vim
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" html
Plug 'hail2u/vim-css3-syntax'
Plug 'gko/vim-coloresque'
Plug 'tpope/vim-haml'
Plug 'mattn/emmet-vim'

" javascript
Plug 'jelera/vim-javascript-syntax'

" python
Plug 'davidhalter/jedi-vim'
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}

" go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" zig
Plug 'ziglang/zig.vim'

" icons
Plug 'ryanoasis/vim-devicons'

call plug#end()

" reenable some settings after plug
filetype plugin indent on

" color and themes
if !has('gui_running')
    set t_Co=255
endif
set termguicolors
set background=dark

let g:lightline = {
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'readonly', 'filename', 'modified' ],
  \   ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'fileicon'] ]
  \ },
  \ 'component_function': {
  \   'fileicon': 'WebDevIconsGetFileTypeSymbol',
  \ }
\ }

" ayu
let ayucolor="dark"
" colorscheme ayu

" accent
let g:accent_darken = 1
" colorscheme accent

" meh
let g:meh_pandoc_enabled = 1
" colorscheme meh

" sunbather
let g:pencil_terminal_italics = 1
" colorscheme sunbather

" paramount
" colorscheme paramount

" rosepine
" let g:disable_bg = 1
" let g:disable_float_bg = 1
colorscheme rosepine
let g:lightline.colorscheme = 'rosepine'

" " catppuccin
" colorscheme catppuccin_mocha
" let g:lightline.colorscheme = 'catppuccin_mocha'

" terminal
if $TERM == "xterm-kitty"
  let &t_ut=''
endif

function! Execute(cmd)
  execute 'terminal ' . a:cmd
endfunction

nnoremap <leader>r :call Execute(input('Command: ', '', 'shellcmd'))<CR>

" ycm
nmap gd :YcmCompleter GoToDefinition<CR>
nmap gD :YcmCompleter GoToDeclaration<CR>

" ale
let g:ale_linters = {}

" fzf
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__,.zig-cache
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>
nmap <leader>y :History<CR>
nmap <leader>Y :History:<CR>

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

" NERDTree
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['node_modules','\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/
nnoremap <silent> <leader>t :NERDTreeTabsToggle<cr>

" grep.vim
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'
nnoremap <silent> <leader>f :Rgrep<CR>

" html
autocmd Filetype html setlocal ts=2 sw=2 expandtab

" javascript
let g:javascript_enable_domhtmlcss = 1
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript setl tabstop=4|setl shiftwidth=4|setl expandtab softtabstop=4
augroup END

" python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "0"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#smart_auto_mappings = 0
let python_highlight_all = 1
:call extend(g:ale_linters, {'python': ['flake8'], })

" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

if executable('cmake-language-server')
  au User lsp_setup call lsp#register_server({
  \ 'name': 'cmake',
  \ 'cmd': {server_info->['cmake-language-server']},
  \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'build/'))},
  \ 'whitelist': ['cmake'],
  \ 'initialization_options': {
  \   'buildDirectory': 'build',
  \ }
  \})
endif

" c/cpp
autocmd FileType c,cpp setlocal commentstring=//\ %s
let g:cpp_function_highlight = 1
let g:cpp_attributes_highlight = 1
let g:cpp_member_highlight = 1
let g:cpp_type_name_highlight = 1
let g:cpp_operator_highlight = 1
let g:cpp_simple_highlight = 1

" zig
if executable('zls')
  au User lsp_setup call lsp#register_server({
  \ 'name': 'zls',
  \ 'cmd': ['zls'],
  \ 'allowlist': ['zls'],
  \})
endif

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = ''
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#left_sep     = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep                        = '▶'
let g:airline_left_alt_sep                    = '»'
let g:airline_right_sep                       = '◀'
let g:airline_right_alt_sep                   = '«'
let g:airline#extensions#branch#prefix        = '⤴' "➔, ➥, ⎇
let g:airline#extensions#readonly#symbol      = '⊘'
let g:airline#extensions#linecolumn#prefix    = '¶'
let g:airline#extensions#paste#symbol         = 'ρ'
let g:airline_symbols.linenr                  = '␊'
let g:airline_symbols.branch                  = '⎇'
let g:airline_symbols.paste                   = 'ρ'
let g:airline_symbols.paste                   = 'Þ'
let g:airline_symbols.paste                   = '∥'
let g:airline_symbols.whitespace              = 'Ξ'
