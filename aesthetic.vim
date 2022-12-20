" Aesthetic

augroup LuaHighlight
	autocmd!
	autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

"set termguicolors

" Conceal char
set conceallevel=2

" Vertical line at 80 characters
" set colorcolumn=80 

" colorscheme nord

" Differentiate whitespaces
set list
set listchars=space:·,tab:›\ ,extends:›,precedes:‹,nbsp:·,trail:·
" set listchars+=eol:↓
highlight WhiteSpaceBol guifg=NONE
highlight WhiteSpaceMol guifg=NONE
match WhiteSpaceMol / /
2match WhiteSpaceBol /^ \+/

" Underline matching parentheses
" highlight MatchParen guifg=NONE guibg=NONE gui=underline cterm=underline

" Change matching parentheses color to red
highlight MatchParen guifg=#ff6c6b

" Transparent Background
if !exists('g:GtkGuiLoaded')
    highlight Normal guibg=NONE ctermbg=NONE
else
    call rpcnotify(1, 'Gui', 'Font', 'JetBrainsMono Nerd Font 14')
    " NGTransparency .5 .5
endif

