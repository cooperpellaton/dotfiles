set nocompatible              " be iMproved, required
filetype off                  " required

" Set the swapfile.
set swapfile
set dir=~/.swap-files

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Include fzf in the runtime path for loading plugin.
set rtp+=~/.fzf

" Plugins are listed below.
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'itchyny/lightline.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'kien/ctrlp.vim'
Plugin 'morhetz/gruvbox'
Plugin 'w0rp/ale'
Plugin 'airblade/vim-gitgutter'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'dracula/vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'DoxygenToolkit.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'godlygeek/tabular'
Plugin 'Yggdroot/indentLine'
Plugin 'joshdick/onedark.vim'
Plugin 'rakr/vim-one'
Plugin 'junegunn/fzf.vim'
Plugin 'tommcdo/vim-lion'
Plugin 'wellle/targets.vim'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'rhysd/clever-f.vim'
Plugin 'chaoren/vim-wordmotion'
Plugin 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plugin 'tmsvg/pear-tree'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-endwise'
Plugin 'ncm2/float-preview.nvim'
Plug 'Shougo/echodoc.vim'
if has('nvim')
  Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plugin 'Shougo/deoplete.nvim'
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
" Automatically close the Deoplete preview window after completion
" (https://github.com/Shougo/deoplete.nvim/issues/115)
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

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

" Colorscheme config.
" Config for grubox.
" Uncomment below if colorscheme should be Gruvbox.
"colorscheme gruvbox
" Uncomment below if Colorscheme should be Dracula
"color dracula
" Config for onedark
"let onedark_terminal_italics = 1
"colorscheme onedark
" Uncomment below for vim-one color scheme.
colorscheme one
let g:one_allow_italics = 1
set background=dark

" lightline config.
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }

" Autolaunch VIm with NERDTree enabled.
autocmd VimEnter * NERDTree
let g:NERDTreeUpdateOnCursorHold = 0
let g:NERDTreeUpdateOnWrite      = 0

" NERDTree Commenter Settings
filetype plugin on
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

let g:lion_squeeze_spaces = 1
let g:clever_f_across_no_line    = 1
let g:clever_f_fix_key_direction = 1
let g:clever_f_timeout_ms        = 3000
nmap cw ce

let g:pear_tree_repeatable_expand = 0
let g:pear_tree_smart_backspace   = 1
let g:pear_tree_smart_closers     = 1
let g:pear_tree_smart_openers     = 1

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
