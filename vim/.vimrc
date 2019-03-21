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

" Plugins are listed below.
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'chriskempson/base16-vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'valloric/youcompleteme'
Plugin 'kien/ctrlp.vim'
Plugin 'morhetz/gruvbox'
Plugin 'w0rp/ale'
Plugin 'airblade/vim-gitgutter'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'dracula/vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'DoxygenToolkit.vim'
Plugin 'tpope/vim-sleuth'
Plugin 'Yggdroot/indentLine'
Plugin 'joshdick/onedark.vim'

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
set number
set wrap
set autoread
syntax on

" Colorscheme config.
" Config for grubox.
" Uncomment below if colorscheme should be Gruvbox.
"colorscheme gruvbox
"set background=dark    " Setting dark mode
" Uncomment below if Colorscheme should be Dracula
"set syntax = on
"color dracula
" Config for onedark
let onedark_terminal_italics = 1
colorscheme onedark
set background=dark 	" Only heathens use lightmode.

" This populates the powerline fonts directory.
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
	  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" Autolaunch VIm with NERDTree enabled.
autocmd VimEnter * NERDTree

" NERDTree Commenter Settings
filetype plugin on
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
