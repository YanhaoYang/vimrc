set nocompatible               " be iMproved
set background=dark            " Assume a dark background
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
Bundle 'tomtom/tlib_vim'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'scrooloose/nerdtree'
Bundle 'spf13/vim-colors'
Bundle 'altercation/vim-colors-solarized'
Bundle 'flazz/vim-colorschemes'
Bundle 'Yggdroot/indentLine'

Bundle 'tpope/vim-surround'
Bundle 'AutoClose'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'vim-scripts/QuickName'

Bundle 'ervandew/supertab'
Bundle 'garbas/vim-snipmate'
Bundle 'YanhaoYang/snipmate-snippets'
" Source support_function.vim to support snipmate-snippets.
if filereadable(expand("~/.vim/bundle/snipmate-snippets/snippets/support_functions.vim"))
  source ~/.vim/bundle/snipmate-snippets/snippets/support_functions.vim
endif

Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'

Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'vim-coffee-script'

Bundle 'leshill/vim-json'
Bundle 'groenewege/vim-less'
Bundle 'taxilian/vim-web-indent'
Bundle 'greyblake/vim-preview'
Bundle 'godlygeek/tabular'

filetype on
filetype plugin indent on   " Automatically detect file types.
syntax on                   " syntax highlighting

"The default leader is '\', but many people prefer ',' as it's in a standard
"location
let mapleader = ','

nnoremap <silent> <C-f> :NERDTreeFind<CR>
map <C-q> :q<CR>
set wrap
set showbreak=...
set spell                       " spell checking on
set hidden                      " allow buffer switching without saving

" UI

set showmode                    " display the current mode

if has('cmdline_info')
  set ruler                   " show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
  set showcmd                 " show partial commands in status line and
  " selected characters/lines in visual mode
endif

if has('statusline')
  set laststatus=2

  " Broken down into easily includeable segments
  set statusline=%<%f\    " Filename
  set statusline+=%w%h%m%r " Options
  set statusline+=\ [%{&ff}/%Y]            " filetype
  set statusline+=%{fugitive#statusline()} "  Git Hotness
  "set statusline+=\ [%{getcwd()}]          " current dir
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" Remove trailing whitespaces and ^M chars
""autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml,ruby,eruby autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
autocmd BufWritePre * :%s/\s\+$//e

set backspace=indent,eol,start  " backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set showmatch                   " show matching brackets/parenthesis
set incsearch                   " find as you type search
set hlsearch                    " highlight search terms
set winminheight=0              " windows can be 0 line high
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when uc present
set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
set scrolljump=5                " lines to scroll when cursor leaves screen
set scrolloff=3                 " minimum lines to keep above and below cursor
set foldenable                  " auto fold code
set foldmethod=indent
set foldcolumn=2
set foldlevel=1
set list
set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace

set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set wildignore=*.o,*.obj,*~     "stuff to ignore when tab completing
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
  if &filetype !~ 'commit\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
      exe "normal! g`\""
      normal! zz
    endif
  end
endfunction

nmap <leader>b :cal QNameInit(1)<CR>:~

set autowrite
augroup AutoWrite
  autocmd! BufLeave * :update
augroup END

let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['ruby'] = 'ruby,ruby-rails,ruby-rspec,ruby-factorygirl'

" NerdTree {
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTree<CR>
nmap <leader>nt :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.DS_Store']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=0
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
" }

" ctrlp {
let g:ctrlp_working_path_mode = 2
nnoremap <silent> <D-t> :CtrlP<CR>
nnoremap <silent> <D-r> :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\.git$\|\.hg$\|\.svn$',
      \ 'file': '\.exe$\|\.so$\|\.dll$' }
"}
" indent_guides {
if !exists('g:spf13_no_indent_guides_autocolor')
  let g:indent_guides_auto_colors = 1
else
  " for some colorscheme ,autocolor will not work,like 'desert','ir_black'.
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#212121   ctermbg=3
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#404040 ctermbg=4
endif
set ts=4 sw=4 et
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
" }

" GUI Settings {
" GVIM- (here instead of .gvimrc)
if has('gui_running')
  set guioptions-=T           " remove the toolbar
  set lines=40                " 40 lines of text instead of 24,
  if has("gui_gtk2")
    set guifont=Andale\ Mono\ Regular\ 16,Menlo\ Regular\ 15,Consolas\ Regular\ 16,Courier\ New\ Regular\ 18
  else
    set guifont=Andale\ Mono\ Regular:h16,Menlo\ Regular:h15,Consolas\ Regular:h16,Courier\ New\ Regular:h18
  endif
  if has('gui_macvim')
    set transparency=5          " Make the window slightly transparent
  endif
else
  if &term == 'xterm' || &term == 'screen'
    set t_Co=256                 " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
  endif
  "set term=builtin_ansi       " Make arrow and other keys work
endif
" }

"colorscheme koehler
"colorscheme ir_black
colorscheme desert2
"colorscheme herald

function! InitializeDirectories()
  let separator = "."
  let parent = $HOME
  let prefix = '.vim'
  let dir_list = {
        \ 'backup': 'backupdir',
        \ 'views': 'viewdir',
        \ 'swap': 'directory' }

  if has('persistent_undo')
    let dir_list['undo'] = 'undodir'
  endif

  for [dirname, settingname] in items(dir_list)
    let directory = parent . '/' . prefix . dirname . "/"
    if exists("*mkdir")
      if !isdirectory(directory)
        call mkdir(directory)
      endif
    endif
    if !isdirectory(directory)
      echo "Warning: Unable to create backup directory: " . directory
      echo "Try: mkdir -p " . directory
    else
      let directory = substitute(directory, " ", "\\\\ ", "g")
      exec "set " . settingname . "=" . directory
    endif
  endfor
endfunction
call InitializeDirectories()

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1
"set clipboard+=unnamed

set autoindent                  " indent at the same level of the previous line
set shiftwidth=2                " use indents of 4 spaces
set expandtab                   " tabs are spaces, not tabs
set tabstop=2                   " an indentation every four columns
set softtabstop=2               " let backspace delete indent
set pastetoggle=<F8>       " pastetoggle (sane indentation on pastes)

au BufNewFile,BufRead Gemfile*			set filetype=ruby
au BufNewFile,BufRead Gemfile*.lock			set filetype=

au BufNewFile,BufRead *.rdoc			set filetype=rdoc
au BufNewFile,BufRead *.textile   set filetype=textile
au BufNewFile,BufRead *.{md,mkdn,markdown} set filetype=markdown

set grepprg=vimgr
map <leader>p :Preview<CR>
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn="80,100,".join(range(120,999),",")

" fix crontab: temp file must be edited in place
set backupskip=/tmp/*,/private/tmp/*
