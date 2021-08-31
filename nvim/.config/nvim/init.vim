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
Plug 'scrooloose/nerdtree'
Plug 'ervandew/supertab'
Plug 'itchyny/lightline.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf.vim'
Plug 'chaoren/vim-wordmotion'
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-endwise'
Plug 'ncm2/float-preview.nvim'
Plug 'Shougo/echodoc.vim'
Plug 'majutsushi/tagbar'
Plug 'psliwka/vim-smoothie'
Plug 'mbbill/undotree'
Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }

" Themes
Plug 'NLKNguyen/papercolor-theme'

" Language Plugs
Plug 'chrisbra/csv.vim'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'elzr/vim-json'
Plug 'rust-lang/rust.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'hashivim/vim-terraform'
Plug 'dag/vim-fish'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
" Automatically close the Deoplete preview window after completion
" (https://github.com/Shougo/deoplete.nvim/issues/115)
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

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

" Persists undos between vim sessions.
if has("persistent_undo")
  set undodir="~/.undodir"
  set undofile
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

" Disable previews for completions
set completeopt-=preview

" Limit the completion menu to 10 entries
set pumheight=10

""""""""""
" VISUAL "
""""""""""
highlight Comment cterm=italic gui=italic
set bg=dark
colorscheme PaperColor

" lightline config.
let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
"
" Define a function which returns a string with the count of a specific type of LanguageClient-Neovim diagnostic
" This function gets its results from quickfix
" `type` is a string that is either `'W'` (warning) or `'E'` (error)
function! s:LCNV_count_type(type)
  let current_buf_number = bufnr('%')
  let qflist = getqflist()
  let current_buf_diagnostics = filter(qflist, {index, dict -> dict['bufnr'] == current_buf_number && dict['type'] == a:type})
  let count = len(current_buf_diagnostics)
  return count > 0 && g:LanguageClient_loaded ? a:type . ': ' . count : ''
endfunction

" Define a function for the LanguageClient-Neovim warning count
function! LCNV_warning_count()
  return s:LCNV_count_type('W')
endfunction

" Define a function for the LanguageClient-Neovim error count
function! LCNV_error_count()
  return s:LCNV_count_type('E')
endfunction

""""""""""""""
" Automation "
""""""""""""""

" Automatically quit Vim if quickfix is the last open window
autocmd BufEnter * call MyLastWindow()
function! MyLastWindow()
  " if the window is quickfix go on
  if &buftype=="quickfix"
    " if this window is last on screen quit without warning
    if winbufnr(2) == -1
      quit!
    endif
  endif
endfunction

" NERDTREE SETTINGS
"autocmd VimEnter * NERDTree
let NERDTreeShowHidden                    = 1
let g:NERDTreeGitStatusUpdateOnCursorHold = 0
let g:NERDTreeGitStatusUpdateOnWrite      = 0
let g:NERDTreeDirArrowExpandable          = "▷"
let g:NERDTreeDirArrowCollapsible         = "◢"

" NERDTree Commenter Settings
filetype plugin on
let g:NERDCompactSexyComs         = 1
let g:NERDCommentEmptyLines       = 1
let g:NERDTrimTrailingWhitespace  = 1

" Add a space for all comments
let NERDSpaceDelims = 1
let g:NERDToggleCheckAllLines = 1

let g:lion_squeeze_spaces        = 1
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

" Autoreload NERDTree on file save.
"autocmd CursorHold,CursorHoldI * call NERDTreeFocus() | call g:NERDTree.ForCurrentTab().getRoot().refresh() | call g:NERDTree.ForCurrentTab().render() | wincmd w

" Tagbar Settings
nnoremap <silent> <F9> :TagbarToggle<CR>

"""""""""""""""""""""""""
" LanguageClient-Neovim "
"""""""""""""""""""""""""

let g:LanguageClient_autoStart = 1

let g:LanguageClient_loggingFile = expand('~/.cache/nvim/LanguageClient.log')

" Enable debugging
let g:LanguageClient_loggingLevel = 'DEBUG'

" Setup individual Language Servers from $PATH
let g:LanguageClient_serverCommands = {
      \   'python': ['/usr/local/bin/pyls'],
      \   'javascript': ['javascript-typescript-stdio'],
      \   'typescript': ['javascript-typescript-stdio'],
      \   'typescript.tsx': ['javascript-typescript-stdio'],
      \   'json': ['vscode-json-languageserver', '--stdio'],
      \   'rust': ['rustup', 'run', 'stable', 'rls'],
      \ }

" Disable diagnostic signs in the signcolumn
" Do this because Gitgutter is more important in the signcolumn and virtual text means we don't need these signs
let g:LanguageClient_diagnosticsSignsMax = 0

" Set the location for LCNV to load settings from
"let g:LanguageClient_settingsPath = '~/.config/nvim/lcnv-settings.json'

" Use the LanguageClient-Neovim key bindings in appropriate file buffers only to avoid breaking normal functionality
function s:SetLCNVKeyBindings()
  nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType python,typescript,typescript.tsx,json,rust call s:SetLCNVKeyBindings()
augroup END

" Echo an arbitrary warning message
function! EchoWarning(msg)
  echohl WarningMsg
  echo a:msg
  echohl None
endfunction

" Check if a tsconfig.json file can be found by recursively searching up parent directories (until the root directory). Print a warning if one is not found
function VerifyTypeScriptTSXConfigExists()
  let currentDirectoryPath = getcwd()
  if empty(findfile(glob("tsconfig.json"), currentDirectoryPath.';'))
    call EchoWarning("You are opening a TSX file but no tsconfig.json could be found. TSX language server support requires a tsconfig.json file which specifies that TSX should be enabled.")
  endif
endfunction()


augroup LSPVerifyTSXConfig
  autocmd!
  " The unsilent part needed in order to echo messages with a FileType autocmd (https://gitter.im/neovim/neovim?at=5db6863be886fb5aa20b6808)
  autocmd FileType typescript.tsx unsilent call VerifyTypeScriptTSXConfigExists()
augroup END

""""""""""""
" Vim JSON "
""""""""""""

" Disable Vim JSON warnings. We want to delegate these to the language server instead
let g:vim_json_warnings = 0

" Disable concealment of quotes in JSON files. Otherwise, the IndentLine plugin doesn't work, and that's more valuable
let g:vim_json_syntax_conceal = 0

"""""""""""""""
" Indent Line "
"""""""""""""""

" Change the characters recursively 
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" Use solarized base01 color for indent line characters
let g:indentLine_color_term = 240


"""""""
" ALE "
"""""""
let g:ale_linters = {
\   'javascript': ['standard'],
\}
let g:ale_fixers = {'javascript': ['standard'], 'html': ['prettier']}

""""""""""
" CTRL-P "
"""""""""
" Include fzf in the runtime path for loading plugin.
set rtp+=/usr/local/opt/fzf

nnoremap <C-p> :Files<Cr>

" Shortcut to FZF :Files with <leader>f
nnoremap <leader>f :Files<cr>

" Shortcut to FZF :Buffers with <leader>b
nnoremap <leader>b :Buffers<cr>

" Shortcut to FZF :Lines with <leader>l
nnoremap <leader>l :Lines<cr>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using Vim function
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

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

" UNDOTREE
nnoremap <F8> :UndotreeToggle<cr>

" pres // to stop highlighting results
nmap <silent> // :nohlsearch<CR>
