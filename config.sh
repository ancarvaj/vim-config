#!/bin/bash
mkdir -p ~/.dotfiles/vim
mv ~/.vimrc ~/.vimrc.bak
touch ~/.dotfiles/vim/.vimrc
ln -s ~/.dotfiles/vim/.vimrc ~/.vimrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cat << eof > ~/.dotfiles/vim/.vimrc
set belloff=all
set incsearch
set hlsearch
set ignorecase
set nu rnu
set tabstop=4
set shiftwidth=4
set smartindent
set history=1000
set clipboard=unnamedplus
let mapleader = " "
set nobackup
set nowritebackup
set signcolumn=yes

call plug#begin()

	Plug 'ajmwagar/vim-deus'

    Plug 'tribela/vim-transparent'
    Plug 'vim-airline/vim-airline'
    Plug 'ghifarit53/tokyonight-vim'
    Plug 'nordtheme/vim'
    
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'preservim/nerdtree'
    
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'github/copilot.vim'
    
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-commentary'
    Plug 'vim-scripts/indentpython.vim'
call plug#end()

set t_Co=256
set termguicolors

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark

colorscheme tokyonight

let g:deus_termcolors=256

let g:fzf_colors = {
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'bg+':     ['bg', 'Normal'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

function! TransparentBackground()
    highlight Normal guibg=NONE ctermbg=NONE
    highlight NonText guibg=NONE ctermbg=NONE
    highlight NormalNC guibg=NONE ctermbg=NONE
    highlight SignColumn guibg=NONE ctermbg=NONE
    highlight EndOfBuffer guibg=NONE ctermbg=NONE
    highlight Pmenu guibg=NONE ctermbg=NONE
    highlight Terminal guibg=NONE ctermbg=NONE
    
    highlight fzf1 guibg=NONE ctermbg=NONE
    highlight fzf2 guibg=NONE ctermbg=NONE
    highlight fzf3 guibg=NONE ctermbg=NONE
    highlight NormalFloat guibg=NONE ctermbg=NONE
    highlight FloatBorder guibg=NONE ctermbg=NONE
endfunction

autocmd ColorScheme * call TransparentBackground()
call TransparentBackground()

" let $FZF_DEFAULT_OPTS = '--color=bg:-1,bg+:-1,hl:-1,hl+:-1'


nnoremap <C-f> :FZF<CR>
nnoremap <C-x> :NERDTreeToggle<CR>
nnoremap <C-w> <C-w>w
nnoremap <Leader><Leader> :w<CR>
nnoremap <Leader>q :q<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

let g:copilot_no_maps = 1

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

imap <silent><script><expr> <CR> copilot#Accept("\<CR>")
eof

echo 'open vim and run :PlugInstall to install plugins'
