" Tabs
set tabstop=4 softtabstop=4 shiftwidth=4
set smarttab expandtab

set timeout ttimeout         " separate mapping and keycode timeouts
set timeoutlen=500           " mapping timeout 500ms  (adjust for preference)
set ttimeoutlen=20           " keycode timeout 20ms

" Allow for local (project-specific) vimrcs
set exrc secure

" Improved Visual-Block mode
set virtualedit+=block
set virtualedit+=onemore

set omnifunc=syntaxcomplete#Complete
set complete=.,w,b,u,t,i,k
set path+=.,**

" Wildmenu
set wildmenu
set wildmode=list:longest,full
" set wildmode=longest:full,full 

" Wildmenu ignore vcs, and zipped files
set wildignore=*.swp,*.bak
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=tags
set wildignore+=*.tar.*

" Wildmenu ignore case when completing
set wildignorecase

" General/Aesthetic
set nowrap
"set cursorline
set lazyredraw
set scrolloff=8 
set cmdheight=2
set visualbell
set updatetime=50
set showcmd

" Matching parens
set showmatch
set matchtime=3

" Enable mouse
set mouse=a

" System clipboard integration
set clipboard+=unnamedplus

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c 
set history=10000

" " Autoresize splits
" set winwidth=79
" set winheight=50

if has('macunix') || has('unix')
" Undodir + Backups
    if has('nvim')
        set undodir=~/.config/nvim/undodir
    else
        set undodir=~/.vim/undodir
    endif
endif

set undofile
set nobackup nowritebackup

" Hybrid line numbers
set number relativenumber

" Searching
set hlsearch incsearch
set ignorecase smartcase
if exists('&inccommand')
    set inccommand=split
endif

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Smooth scrolling
nnoremap <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
nnoremap <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>

augroup vimrc-remember-cursor-position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
