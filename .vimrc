execute pathogen#infect()

" Do not store stupid persistent undo files
if has('persistent_undo')
  set noundofile
endif

" Enable syntax highlighting
syntax enable
" Highlight text past 80 columns
" highlight OverLength ctermbg=red ctermfg=white
" match OverLength /\%81v.\+/

" Shift operations set to 2 spaces
set shiftwidth=2
" Preserve indention level from the previous line
set smartindent
set autoindent
" No stupid outdent for scripting comments...
inoremap # X<C-H>#
" And no stupid shift-resistance either...
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

:filetype plugin on

autocmd FileType ruby,eruby set filetype=ruby.eruby.chef

" ------------------------ Status Line ------------------------------------
" set statusline=%f          " Path to the file
" set statusline+=\ -\       " Separator
" set statusline+=FileType:  " Label
" set statusline+=%y         " Filetype of the file
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" set statusline+=%=         " Switch to the right side
" set statusline+=\row:      " Label
" set statusline+=%4l        " Current line
" set statusline+=/          " Separator
" set statusline+=%L         " Total lines
" set statusline+=\ col:     " Label
" set statusline+=%-3c      " Column
" Always show the status line
set laststatus=2

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
      \ },
      \ 'component_function': {
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
                  \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
                  \ ('' != fname ? fname : '[No Name]') .
                  \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.rb,*.pl,*.py,*.sh call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

" mode information is displayed in lightline now, so this is redundant
set noshowmode

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.tar,*.tar.gz
let g:ctrlp_custom_ignore = '\v[\/]\.(git|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|svn)$',
  \ 'file': '\v\.(so|dll)$',
  \ }
