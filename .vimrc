execute pathogen#infect()

" Enable syntax highlighting
syntax enable
" Highlight text past 80 columns
highlight OverLength ctermbg=red ctermfg=white
match OverLength /\%81v.\+/

" Shift operations set to 4 spaces
set shiftwidth=4
" Preserve indention level from the previous line
set smartindent
set autoindent
"No stupid outdent for scripting comments...
inoremap # X<C-H>#
"And no stupid shift-resistance either...
nnoremap <silent> >> :call ShiftLine()<CR>
function! ShiftLine()
    set nosmartindent
    normal! >>
    set smartindent
endfunction
" Always turn Tab into spaces
set expandtab
" A tab counts for 4 spaces
set tabstop=4
set softtabstop=4
" See :help mapleader
:let mapleader=","
set showmatch                       " Show me matching close braces
set matchpairs+=<:>                 " match < > with the % command, too
set backspace=indent,eol            " allow rational backspacing in insert mode
set comments=b:#                    " Most of my files use # for comments
" Don't highlight search results
set nohlsearch

" ------------------------ Status Line ------------------------------------
set statusline=%f          " Path to the file
set statusline+=\ -\       " Separator
set statusline+=FileType:  " Label
set statusline+=%y         " Filetype of the file
set statusline+=%=         " Switch to the right side
set statusline+=\row:      " Label
set statusline+=%4l        " Current line
set statusline+=/          " Separator
set statusline+=%L         " Total lines
set statusline+=\ col:     " Label
set statusline+=%-3c      " Column
" Always show the status line
set laststatus=2
