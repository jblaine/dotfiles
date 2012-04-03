" --------------------------- Basic Sane Settings -----------------------
" Don't try to be compatible with old-school vi
set nocompatible
" Shift operations set to 4 spaces
set shiftwidth=4
" Preserve indention level from the previous line
set smartindent
" Auto-wrap once typing past 80 characters
" set textwidth=80
" Always turn Tab into spaces
set expandtab
" A tab counts for 4 spaces
set tabstop=4
set softtabstop=4
" Not so sure about smarttab below
" set smarttab
" See :help mapleader 
:let mapleader=","
set showmatch                       " Show me matching close braces
set matchpairs+=<:>                 " match < > with the % command, too
set backspace=indent,eol            " allow rational backspacing in insert mode
" Commented out until I understand it
" set formatoptions=tcrqn
set comments=b:#                    " Most of my files use # for comments
" Highlight column 80
set colorcolumn=80

" ------------------------ Status Line ------------------------------------
set statusline=%f          " Path to the file
set statusline+=\ -\       " Separator
set statusline+=FileType:  " Label
set statusline+=%y         " Filetype of the file
set statusline+=%=         " Switch to the right side
set statusline+=%4l        " Current line
set statusline+=/          " Separator
set statusline+=%-40L      " Total lines
" Always show the status line
set laststatus=2
" Show me where I am in the file (only useful w/o status line set)
" set ruler
" Show me the vi command in the ruler
" set showcmd

" ------------------------ gvim-Specific Settings -------------------------
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Lucida\ Console\ 12
  else
    set guifont=Lucida_Console:h12:cDEFAULT
  endif
endif

" --------------------------- Coloring -----------------------------------
" It is assumed above that you have set term to a terminal type supporting
" 256 colors, so force it here.  "People" say this should never be required
" if your terminfo crap is correct, but it is required for me when running
" vim under GNU screen
set t_Co=256
" Enable syntax highlighting
syntax enable
" Highlight text past 80 columns
highlight OverLength ctermbg=red ctermfg=white
match OverLength /\%81v.\+/
" colorscheme lucius
colorscheme desert256-jls
"
" Dunno, this seems to be the only thing that leaves my terminal in a
" proper state once I exit vim in 256-color mode when using either
" TERM=putty-256color or TERM=xterm-256color.  Found it mentioned in
" some IRC log after digging through Google results for an hour or more.
set t_ti= t_te=

" ------------------------ Normal Mode mappings --------------------------
" # = insert "#" at col 0, enter normal mode again, go down one line
:nnoremap # I#<esc>j
" Quote the word you're on with double quotes
:nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" ------------------------ Insert Mode mappings --------------------------

" ------------------------ Visual Mode mappings --------------------------

" ------------------------ Insert Mode Abbreviations ---------------------
:iabbrev adn and
:iabbrev waht what
:iabbrev tehn then
