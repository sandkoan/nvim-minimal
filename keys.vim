let mapleader="\<Space>"
let maplocalleader=","

nnoremap <Leader><CR> :so $MYVIMRC<CR>

inoremap jk <Esc>
inoremap kj <Esc>

" Make <C-u> and :wincmd undoable
inoremap <C-u> <C-g>u<C-u>
inoremap :wincmd  <C-g>u<C-w>

" Accidents
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

nnoremap H 0
nnoremap L $

" More sane vertical navigation - respects columns
nnoremap <expr> k      v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j      v:count == 0 ? 'gj' : 'j'
nnoremap <expr> <Up>   v:count == 0 ? "g\<Up>" : "\<Up>"
nnoremap <expr> <Down> v:count == 0 ? "g\<Down>" : "\<Down>"
vnoremap <expr> k      v:count == 0 ? 'gk' : 'k'
vnoremap <expr> j      v:count == 0 ? 'gj' : 'j'
vnoremap <expr> <Up>   v:count == 0 ? "g\<Up>" : "\<Up>"
vnoremap <expr> <Down> v:count == 0 ? "g\<Down>" : "\<Down>"

" Insert new line in normal mode
nnoremap [o o<Esc>
nnoremap [O O<Esc>

" From vim unimpared
nnoremap [a :prev  <CR>
nnoremap ]a :next  <CR>
nnoremap [A :first <CR>
nnoremap ]A :last  <CR>

nnoremap [l :lprev <CR>
nnoremap ]l :lnext <CR>
nnoremap [L :lfirst<CR>
nnoremap ]L :llast <CR>

nnoremap [q :cprev <CR>
nnoremap ]q :cnext <CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast <CR>

" Change text without putting the text into register,
nnoremap c "_c
nnoremap C "_C
nnoremap cc "_cc

" Y consistent with C, D etc.
nnoremap Y y$

" vv selects the whole line, just like dd deletes the whole line
nnoremap vv V

" Vmap for maintain Visual Mode after shifting > and <
vnoremap < <gv
vnoremap > >gv

" Move visual block
nnoremap <M-j> mz:m+<cr>`z 
nnoremap <M-k> mz:m-2<cr>`z 
vnoremap <M-j> :m'>+<cr>`<my`>mzgv`yo`z 
vnoremap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z 

" Split a line into two at the cursor
nnoremap <C-j> ciW<CR><Esc>:if match( @", "^\\s*$") < 0<Bar>exec "norm P-$diw+"<Bar>endif<CR>

" 'cd' towards the directory in which the current file is edited
" but only change the path for the current window
nnoremap <leader>cd :lcd %:h<CR>

" Turn off highlighting after search
nnoremap <Leader>, :nohl<CR>


" Tab through completion pop up menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

function! LocalFileCompletion()
    lcd %:p:h
    return "\<C-x>\<C-f>"
endfunction

" and revert it after the completion is done
autocmd! CompleteDonePre *
      \ if complete_info(["mode"]).mode == "files" |
      \   lcd - |
      \ endif

inoremap <silent> <C-x><C-f> <C-R>=LocalFileCompletion()<CR>

" Cverloaded ctrl space functionality
function! CtrlSpace()
  let l:line_until_cursor = strpart(getline('.'), 0, col('.')-1)
  " Do file name completion if line until cursor is something like this:
  " 'foo bar ../baz/'
  " 'foo bar ../baz/qux'
  " but not if like this:
  " '<tag>content</'
  if l:line_until_cursor =~ '\(<\)\@1<!/\f*$'
    return LocalFileCompletion()
  " Else, call omnicompletion if omnifunc exists
  elseif len(&omnifunc) > 0
    return "\<C-x>\<C-o>"
  else
    return "\<C-n>"
  endif
endfunction
inoremap <silent> <C-Space> <C-R>=CtrlSpace()<CR>

" Remapping C-Space to autocompletion
" inoremap <C-@> <C-Space>
" inoremap <C-Space> <C-P>


" Empty buffer prompt in wildmenu
" set wildcharm=<C-z>
" nnoremap ,e :e *<C-z><S-Tab>
" nnoremap ,f :find *<C-z><S-Tab>

" nnoremap ,e :e **/*<C-z><S-Tab>
" nnoremap ,f :find **/*<C-z><S-Tab>

" Session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" Buffers
set hidden

nnoremap <Leader>bh :bprevious<CR>
nnoremap <Leader>bl :bnext<CR>
nnoremap <Leader>bk :bfirst<CR>
nnoremap <Leader>bj :blast<CR>
nnoremap <Leader>bd :bd<CR>

" nnoremap <leader>bp :buffer <C-z><S-Tab>
" nnoremap <leader>Bp :sbuffer <C-z><S-Tab>

" Flying with buffers
nnoremap <C-b> :ls<CR>:b<Space>

" Windows
" Creating splits
noremap <Leader>ws :<C-u>split<CR>
noremap <Leader>wv :<C-u>vsplit<CR>
" See resize-mode.vim for more maps

" These are convenience leader maps
" Resizing splits
nnoremap <leader>wi :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>w+ :vertical resize +5<CR>
nnoremap <Leader>w- :vertical resize -5<CR>
nnoremap <leader>w= :wincmd =<CR>

" Navigating splits
nnoremap <leader>wh :wincmd h<CR>
nnoremap <leader>wj :wincmd j<CR>
nnoremap <leader>wk :wincmd k<CR>
nnoremap <leader>wl :wincmd l<CR>

" Moving splits
nnoremap <leader>wr :wincmd r<CR>
nnoremap <leader>wH :wincmd H<CR>
nnoremap <leader>wJ :wincmd J<CR>
nnoremap <leader>wK :wincmd K<CR>
nnoremap <leader>wL :wincmd K<CR>

" Tabs
let notabs = 0
nnoremap <leader>th :tabfirst<CR>
nnoremap <leader>tk :tabnext<CR>
nnoremap <leader>tj :tabprev<CR>
nnoremap <leader>tl :tablast<CR>
nnoremap <leader>te :tabedit<Space>
nnoremap <leader>tm :tabmove<Space>
nnoremap <leader>td :tabclose<CR>

" Switch tab positions with Alt + h/l
nnoremap <silent> <A-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-l> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
" Same thing with Alt + arrow keys
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
nnoremap <silent> <F8> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>
cabbrev tabv tab sview +setlocal\ nomodifiable

" Emacs key bindings in Command Mode
" start of line
cnoremap <C-A> <Home>
" back one character
cnoremap <C-B> <Left>
" delete character under cursor
cnoremap <C-D> <Del>
" end of line
cnoremap <C-E> <End>
" forward one character
cnoremap <C-F> <Right>
" recall newer command-line
cnoremap <C-N> <Down>
" recall previous (older) command-line
cnoremap <C-P> <Up>
" back one word
cnoremap <A-C-B> <S-Left>
" forward one word
cnoremap <A-C-F> <S-Right>

command! FixWhitespace :%s/\s\+$//e
