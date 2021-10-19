" Workaround some broken plugins which set guicursor indiscriminately.
" :autocmd OptionSet guicursor noautocmd set guicursor=

set nocompatible              " be iMproved, required
filetype off                  " required
set clipboard=unnamed

" Set the swapfile.
set swapfile
set dir=~/.swap-files

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Plugs are listed below.
Plug 'xolox/vim-misc'
Plug 'tpope/vim-fugitive'
Plug 'ervandew/supertab'
Plug 'itchyny/lightline.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/fzf.vim'
Plug 'chaoren/vim-wordmotion'
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-endwise'
Plug 'ncm2/float-preview.nvim'
Plug 'Shougo/echodoc.vim'
Plug 'majutsushi/tagbar'
Plug 'psliwka/vim-smoothie'
Plug 'mbbill/undotree'

" Themes
Plug 'altercation/vim-colors-solarized'

" All of your Plugs must be added before the following line
call plug#end()            " required

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Some defaults for VIm.
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
set wrap
set autoread
syntax on

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

" Don't show the current mode on the last line
" This is not needed as the status line displays the current mode
set noshowmode

" Limit the completion menu to 10 entries
set pumheight=10

""""""""""
" VISUAL "
""""""""""
highlight Comment cterm=italic gui=italic
colorscheme solarized

" lightline config.
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
"

"""""""""""
" Echodoc "
"""""""""""

" Use neovim's floating text for documentation
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
" To use a custom highlight for the float window, change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu

"""""""""""""""""
" Float Preview "
"""""""""""""""""

" Don't dock the preview window to the bottom of the window
let g:float_preview#docked = 1

" Tagbar Settings
nnoremap <silent> <F9> :TagbarToggle<CR>

"""""""""""""""
" Indent Line "
"""""""""""""""

" Change the characters recursively 
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" Use solarized base01 color for indent line characters
let g:indentLine_color_term = 240

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

" pres // to stop highlighting results
nmap <silent> // :nohlsearch<CR>
