set runtimepath^=/.vim runtimepath+=~/.vim/after

let &packpath = &runtimepath

source ~/.vimrc
set termguicolors
:set guicursor=
" Workaround some broken plugins which set guicursor indiscriminately.
" :autocmd OptionSet guicursor noautocmd set guicursor=

" This fixes the double escape problem in nvim.
set escape-time 0
