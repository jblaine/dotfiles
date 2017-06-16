set nocompatible

if has("gui_running")
  set guifont=Menlo_for_Powerline:h12
  " set guifont=Source_Code_Pro_for_Powerline:h12
  " set guifont=DejaVu_Sans_Mono_for_Powerline:h12
  set lines=44 columns=120 linespace=0
  set encoding=utf-8
endif

" vundle boilerplate
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-syntastic/syntastic'
" Plugin 'xolox/vim-misc'
Plugin 'ctrlpvim/ctrlp.vim'

" ----- Working with Git ----------------------------------------------
Plugin 'tpope/vim-fugitive'

" ----- Other text editing features -----------------------------------
Plugin 'Raimondi/delimitMate'

" ----- man pages, tmux -----------------------------------------------
" Plugin 'jez/vim-superman'
" Plugin 'christoomey/vim-tmux-navigator'

" ----- Syntax plugins ------------------------------------------------
" Plugin 'jez/vim-c0'
" Plugin 'jez/vim-ispc'
" Plugin 'kchmck/vim-coffee-script'

" ---- Extras/Advanced plugins ----------------------------------------
" Highlight and strip trailing whitespace
"Plugin 'ntpeters/vim-better-whitespace'
" Easily surround chunks of text
"Plugin 'tpope/vim-surround'
" Align CSV files at commas, align Markdown tables, and more
"Plugin 'godlygeek/tabular'
" Automaticall insert the closing HTML tag
"Plugin 'HTML-AutoCloseTag'
" Make tmux look like vim-airline (read README for extra instructions)
"Plugin 'edkolev/tmuxline.vim'
" All the other syntax plugins I use
"Plugin 'ekalinin/Dockerfile.vim'
"Plugin 'digitaltoad/vim-jade'
"Plugin 'tpope/vim-liquid'
"Plugin 'cakebaker/scss-syntax.vim'
call vundle#end()
filetype plugin indent on

set mouse=a

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
set backspace=indent,eol,start      " allow rational backspacing in insert mode
set comments=b:#                    " Most of my files use # for comments
" Don't highlight search results
set nohlsearch
set ruler
set number
set showcmd

" We need this for plugins like Syntastic
" which put symbols in the sign column.
hi clear SignColumn

autocmd FileType ruby,eruby set filetype=ruby.eruby.chef

" ------------------------ Status Line ------------------------------------
" set statusline=%f          " Path to the file
" set statusline+=\ -\       " Separator
" set statusline+=FileType:  " Label
" set statusline+=%y         " Filetype of the file
" set statusline+=%=         " Switch to the right side
" set statusline+=\row:      " Label
" set statusline+=%4l        " Current line
" set statusline+=/          " Separator
" set statusline+=%L         " Total lines
" set statusline+=\ col:     " Label
" set statusline+=%-3c      " Column
" Always show the status line
" set laststatus=2

" ----- Plugin-Specific Settings --------------------------------------

" ----- altercation/vim-colors-solarized settings -----
colorscheme solarized
" Toggle this to "light" for light colorscheme
set background=dark
" Uncomment the next line if your terminal is not configured for solarized
"let g:solarized_termcolors=256

" ----- bling/vim-airline settings -----
" Always show statusbar
set laststatus=2

" Fancy arrow symbols, requires a patched font
" To install a patched font, run over to
"     https://github.com/abertsch/Menlo-for-Powerline
" download all the .ttf files, double-click on them and click "Install"
" Finally, uncomment the next line
let g:airline_powerline_fonts = 1
" Show PASTE if in paste mode
let g:airline_detect_paste=1
" Show airline for tabs too
let g:airline#extensions#tabline#enabled=1
" Use the solarized theme for the Airline status bar
let g:airline_theme='solarized'

" ----- jistr/vim-nerdtree-tabs -----
" Open/close NERDTree Tabs with \t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
" To have NERDTree always open on startup
let g:nerdtree_tabs_open_on_console_startup = 0
let g:nerdtree_tabs_open_on_gui_startup = 0

" ----- scrooloose/syntastic settings -----
let g:syntastic_aggregate_errors = 1
let g:syntastic_error_symbol = '?'
let g:syntastic_warning_symbol = "?"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" ----- Raimondi/delimitMate settings -----
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END
