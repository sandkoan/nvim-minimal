" {{
" The four dimensions of editing 
" https://gist.github.com/deoxys314/255d483688ff103b63c75a66715bf9bf

let s:second = 1
let s:minute = 60 * s:second
let s:hour = 60 * s:minute
let s:day = 24 * s:hour
let s:week = 7 * s:day
let s:month = 30 * s:day
let s:year = 365 * s:day

function! s:get_undo_time(undo_dict) abort
    let l:idx = a:undo_dict.seq_cur
    for l:entry in a:undo_dict.entries
        if l:entry.seq == l:idx
            return l:entry.time
        endif
    endfor
    return localtime()
endfunction

function! StatusTimeLine() abort
    let l:undo_dict = undotree()
    if l:undo_dict.seq_cur == l:undo_dict.seq_last | return 'Present' | endif

    let l:delta_t = localtime() - s:get_undo_time(l:undo_dict)
    if l:delta_t > s:year
        return 'More than a year ago'
    elseif l:delta_t > s:month 
        return 'More than a month ago'
    elseif l:delta_t > s:week
        let l:n_weeks = l:delta_t / s:week
        let l:plural = l:n_weeks > 1
        return 'More than ' . l:n_weeks . ' week' . (l:plural ? 's' : '') . ' ago'
    elseif l:delta_t > s:day
        let l:n_days = l:delta_t / s:day
        let l:plural = l:n_days > 1
        return l:n_days . ' day' . (l:plural ? 's' : '') . ' ago'
    elseif l:delta_t > s:hour
        let l:n_hours = l:delta_t / s:hour
        let l:plural = l:n_hours > 1
        return l:n_hours . ' hour' . (l:plural ? 's' : '') . ' ago'
    elseif l:delta_t > s:minute
        let l:n_minutes = l:delta_t / s:minute
        let l:plural = l:n_minutes > 1
        return l:n_minutes . ' minute' . (l:plural ? 's' : '') . ' ago'
    elseif l:delta_t > s:second
        return 'Seconds ago'
    else
        return 'ERROR: Delta T: ' . l:delta_t
    endif
endfunction

" Inspired by https://gist.github.com/ahmedelgabri/b9127dfe36ba86f4496c8c28eb65ef2b

" Statusline & Tabline/Buffer line
" Dynamically getting the fg/bg colors from the current colorscheme, returns hex which is enough for me to use in Neovim
" Needs to figure out how to return cterm values too
let fgcolor=synIDattr(synIDtrans(hlID("Normal")), "fg", "gui")
let bgcolor=synIDattr(synIDtrans(hlID("Normal")), "bg", "gui")

" Tabline/Buffer line
set showtabline=2
set tabline="%1T"

" Statusline

let s:status_fourth_dim = get(g:, 'statusline_fourth_dimension', 0)

let g:currentmode={
            \ 'n'  : 'N ',
            \ 'no' : 'N·Operator Pending ',
            \ 'v'  : 'V ',
            \ 'V'  : 'V·Line ',
            \ '' : 'V·Block ',
            \ 's'  : 'Select ',
            \ 'S'  : 'S·Line ',
            \ '' : 'S·Block ',
            \ 'i'  : 'I ',
            \ 'R'  : 'R ',
            \ 'Rv' : 'V·Replace ',
            \ 'c'  : 'Command ',
            \ 'cv' : 'Vim Ex ',
            \ 'ce' : 'Ex ',
            \ 'r'  : 'Prompt ',
            \ 'rm' : 'More ',
            \ 'r?' : 'Confirm ',
            \ '!'  : 'Shell ',
            \ 't'  : 'Terminal '
            \}

highlight User1 cterm=None gui=None ctermfg=007 guifg=fgcolor
highlight User2 cterm=None gui=None ctermfg=008 guifg=bgcolor
highlight User3 cterm=None gui=None ctermfg=008 guifg=bgcolor
highlight User4 cterm=None gui=None ctermfg=008 guifg=bgcolor
highlight User5 cterm=None gui=None ctermfg=008 guifg=bgcolor
highlight User7 cterm=None gui=None ctermfg=008 guifg=bgcolor
highlight User8 cterm=None gui=None ctermfg=008 guifg=bgcolor
highlight User9 cterm=None gui=None ctermfg=007 guifg=fgcolor

" Automatically change the statusline color depending on mode
function! ChangeStatuslineColor()
    if (mode() =~# '\v(n|no)')
        exe 'hi! StatusLine ctermfg=008 guifg=fgcolor gui=None cterm=None'
    elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·Block' || get(g:currentmode, mode(), '') ==# 't')
        exe 'hi! StatusLine ctermfg=005 guifg=#82CC6A gui=None cterm=None'
    elseif (mode() ==# 'i')
        exe 'hi! StatusLine ctermfg=004 guifg=#6CBCE8 gui=None cterm=None'
    else
        exe 'hi! StatusLine ctermfg=006 guifg=#ECBE7B gui=None cterm=None'
    endif

    return ''
endfunction

" Find out current buffer's size and output it.
function! FileSize()
    let bytes = getfsize(expand('%:p'))
    if (bytes >= 1024)
        let kbytes = bytes / 1024
    endif
    if (exists('kbytes') && kbytes >= 1000)
        let mbytes = kbytes / 1000
    endif

    if bytes <= 0
        return '0'
    endif

    if (exists('mbytes'))
        return mbytes . ' MB '
    elseif (exists('kbytes'))
        return kbytes . ' KB '
    else
        return bytes . ' B '
    endif
endfunction

function! ReadOnly()
    if &readonly || !&modifiable
        return ''
    else
        return ''
    endif
endfunction

function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
    let l:branchname = GitBranch()
    if strlen(l:branchname) > 0
        return ' '.l:branchname
    else
        return ''
    endif
endfunction

" if has('nvim-0.5')
    " function! LspStatus() abort
        " if luaeval('#vim.lsp.buf_get_clients() > 0')
            " return luaeval("require('lsp-status').status()")
        " endif
        " return ''
    " endfunction
" endif

set laststatus=2
set statusline=
set statusline+=%{ChangeStatuslineColor()}               " Changing the statusline color
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}   " Current mode
set statusline+=%8*\ [%n]                                " buffernr
set statusline+=%8*\ %{StatuslineGit()}                  " Git Branch name
set statusline+=%8*\ %<%F\ %{ReadOnly()}\ %m\ %w\        " File+path
set statusline+=%=
set statusline+=%#warningmsg#                            " Warning messages
" if has('nvim-0.5')
    " set statusline+=%{LspStatus()}                           " Nvim Lsp Info
" endif
set statusline+=%*
set statusline+=%9*\ %=                                  " Space
set statusline+=%8*\ %y\                                 " FileType
set statusline+=%8*\ %-3(%{FileSize()}%)                 " File size
set statusline+=%0*\%3p%%\ \ %l:\ %3c\                  " Rownumber, total (%)

if s:status_fourth_dim == '1'
    set statusline+=\ z:%{foldlevel(line('.'))}              " Fold level of current line
    set statusline+=\ t:%{StatusTimeLine()}           " Time level
endif
" }}


