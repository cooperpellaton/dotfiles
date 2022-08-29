call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'ervandew/supertab'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'
Plug 'chaoren/vim-wordmotion'
Plug 'tpope/vim-endwise'
Plug 'ncm2/float-preview.nvim'
Plug 'Shougo/echodoc.vim'
Plug 'majutsushi/tagbar'
Plug 'psliwka/vim-smoothie'

" All of your Plugs must be added before the following line
call plug#end()            " required

"""""""""""
" GENERAL "
"""""""""""
set clipboard=unnamed
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
syntax on
if !has('gui_running')
  set t_Co=256
endif
" Fix backspace so that it works normally
set backspace=indent,eol,start
" Show existing tab with 2 spaces width
set tabstop=2
" Copy indent from current line when starting a new line.
set autoindent
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" On pressing tab, insert 2 spaces
set expandtab
" Turn case sensitive search off and smartcase search on
set ignorecase
set smartcase
" Fold based on syntax
set foldmethod=syntax
" Don't fold files by default
set nofoldenable
" Don't show the current mode on the last line (status line displays the current mode)
set noshowmode
" Limit the completion menu to 10 entries
set pumheight=10
" pres // to stop highlighting results
nmap <silent> // :nohlsearch<CR>

""""""""""
" VISUAL "
""""""""""
" lightline config.
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

"""""""""""
" Echodoc "
"""""""""""
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
" To use a custom highlight for the float window,
" change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu

"""""""""""""""
" Indent Line "
"""""""""""""""
" Change the characters recursively 
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

"""""""""""""""""
" WINDOW CONFIG "
"""""""""""""""""
" quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
