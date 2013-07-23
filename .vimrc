execute pathogen#infect()

" Do not store stupid persistent undo files
if has('persistent_undo')
  set noundofile
endif

" Enable syntax highlighting
syntax enable
" Highlight text past 80 columns
highlight OverLength ctermbg=red ctermfg=white
match OverLength /\%81v.\+/

" Shift operations set to 2 spaces
set shiftwidth=2
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
" A tab counts for 2 spaces
set tabstop=2
set softtabstop=2
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
