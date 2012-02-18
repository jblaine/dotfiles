" --------------------------- Basic Sane Settings -----------------------
" Use VIM mode, not old vi mode
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
" Always show the status line
set laststatus=2

" ------------------------ Status Line ------------------------------------
:set statusline=%f          " Path to the file
:set statusline+=\ -\       " Separator
:set statusline+=FileType:  " Label
:set statusline+=%y         " Filetype of the file
:set statusline+=%=       " Switch to the right side
:set statusline+=%4l        " Current line
:set statusline+=/          " Separator
:set statusline+=%-40L        " Total lines

" ------------------------ gvim-Specific Settings -------------------------
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Lucida\ Console\ 12
  else
    set guifont=Lucida_Console:h12:cDEFAULT
  endif
endif

" --------------------------- Coloring -----------------------------------
" Enable syntax highlighting
syntax enable
" Highlight text past 80 columns
highlight OverLength ctermbg=red ctermfg=white
match OverLength /\%81v.\+/

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
