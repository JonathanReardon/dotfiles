"""""""""""""""""""""""""""""""""""""""""""""""""""""
" -> vim plugged for plugin management
"""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')           " list plugins after this line

Plug 'donRaphaco/neotex', {'for': 'tex'}    " asynchronous latex compilation
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'preservim/nerdcommenter'
Plug 'scrooloose/syntastic'                 " code syntax checking
Plug 'Shougo/deoplete.nvim'                 " asynchronous code completion
Plug 'brooth/far.vim'                       " find and replace
"Plug 'roxma/nvim-completion-manager'
Plug 'ap/vim-css-color'                     " color highlighting
Plug 'itchyny/lightline.vim'                
Plug 'vim-scripts/indentpython.vim'
Plug 'junegunn/goyo.vim'                    " distraction-free writing
Plug 'vim-utils/vim-man'                    " grep man pages
Plug 'zchee/deoplete-go'                    " Go-lang completion
Plug 'zchee/deoplete-jedi'                  " multi-lang completion
Plug 'vifm/vifm.vim'                        " file manager
Plug 'jalvesaq/Nvim-R'                      " R support
Plug 'jalvesaq/R-Vim-runtime'		    " for python syntax highlighting in Plug '
Plug 'fatih/vim-go'			    " Go development plugin

call plug#end()

set number
set laststatus=2                            " always show statusline (for lightline)
set noerrorbells
set tabstop=4 softtabstop=4                 " 1 tab == 4 spaces
set shiftwidth=4                            " single tab as indent
set expandtab                               " spaces instead of tabs
set smartindent                             " auto-indent with new line
set nu                                      " show line numbers
set nowrap                                  " long line
set smartcase                               " use case if caps are used
set noswapfile
set incsearch                               " incremental search, starts at first character
set encoding=utf-8
set background=dark
set t_Co=256                                " use 256 colors (if terminal supports)
set mouse=nicr                              " mouse scrolling
set mouse=a                                 " alacritty/neovim compatibility

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" -> lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'component': {
    \   'charvaluehex': '0x%B'
    \ },
    \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" -> neotex
"""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neotex_enabled = 1
let g:neotex_delay = 1000                   " document update interval 
let g:tex_flavor = 'latex'                  " prevents issues

syntax on                                   " syntax highlighting
let g:rmd_syn_langs = ["r", "python"]       " python syntax highlight in Rmd 
autocmd BufWritePost ~/.bashrc !source
