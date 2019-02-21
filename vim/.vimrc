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

set rtp+=~/.vim/bundle/gruvbox/autoload/gruvbox.vim

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

" Some defaults for VIm.
set number
set wrap
set autoread

" Colorscheme config.
" Config for grubox.
colorscheme gruvbox
set background=dark    " Setting dark mode
" Uncomment below if Colorscheme should be Dracula
"set syntax = on
"color dracula

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
