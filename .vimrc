""" Vim Configuration
set nocompatible " Behave like vim, not vi

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" let Vundle manage Vundle, required.
Bundle 'gmarik/vundle'

" Plugins:
Bundle 'altercation/vim-colors-solarized'
Bundle 'godlygeek/tabular'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/powerline'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/vitality.vim'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'motus/pig.vim'

filetype plugin on " Enable filetype plugins
filetype indent on " Enable filetype specific indent rules
syntax on " Enable syntax highlighting

"" Set up Leader
let mapleader = "\<Space>"
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :wq<CR>
nnoremap <Leader>q :wq<CR>
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"" Watches for changes in vim configs and automatically refreshes your .vimrc
augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

"" Sounds
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"" Buffer behaviour
set hidden " Allow changed buffers to be in back ground

"" System copy / paste
set clipboard=unnamed

"" Expected backspace behaviour
set backspace=indent,eol,start

"" Lines
set number " Display line numbers
set nowrap " turn off line wrapping

"" Indentation
set shiftwidth=2 " Number of spaces for each tab in autoindent (<< and >>)
set softtabstop=2 " Number of columns inserted by tab key
set expandtab " Use spaces instead of tabs
set tabstop=2 " Number of spaces for each tab.  Affect how text is displayed
set autoindent " Copy indent from current line when starting a new line
set smarttab " Set tab width to shiftwidth on start of line tab insert

"" Searching
set incsearch " Find matches while still typeing
set hlsearch " Highlight matches by default
set ignorecase " Ignore case on searches...
set smartcase " unless searching for a capital

"" Comand Line
set wildmode=list:longest " Complete longest common string, then list (similar to bash)
set wildmenu
set wildignore=*.o,*.obj,*.class

"" Remappings
" yank from cursor to EOL with Y, consistent with C and D
noremap Y y$
" Toggle search highlighting
nnoremap <Leader>hs :nohlsearch<CR>

"" Movement
set scrolloff=5 " set vertical scroll space around cursor
set sidescrolloff=7 " set horizontal scroll space around cursor
set sidescroll=1 " scroll horizontally by 1 column at a time
set virtualedit=block " Let cursor move past last char in visual block mode
set showmatch " Briefly jump to a parent when it's balanced...
set matchtime=2 " for only .2 seconds
set nostartofline " Don't jump to start of line with movements

"" Files
set autoread " Automatically read changed files
au BufReadCmd   *.jar,*.war,*.ear,*.sar,*.rar        call zip#Browse(expand("<amatch>"))

"" Theme
let g:solarized_termcolors=256
set background=dark
colorscheme solarized
set guifont=Inconsolata\ for\ Powerline:h16 "Font
set t_Co=256 " Tell terminal to use 256 colors
set title " Turn on title bar support

"" Mouse settings
set mouse=a " Enable mouse
set ttymouse=xterm2 " Use mouse scrolling in terminal window

""" Plugin Configuration

"" Powerline
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set noshowmode

"" Tagbar
nmap <Leader>t :TagbarToggle<CR>

""" Autocommands
if has("autocmd")
  augroup vimrcEx
  "jump to last cursor position when opening a file
  ""dont do it when writing a commit log entry
  autocmd BufReadPost * call SetCursorPosition()
  function! SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
      if line("'\"") > 0 && line("'\"") <= line("$")
        exe "normal! g`\""
        normal! zz
      endif
    end
  endfunction

  augroup END
endif
