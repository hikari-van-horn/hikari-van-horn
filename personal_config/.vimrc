set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'ervandew/supertab'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'tpope/vim-surround'
Plugin 'vimoutliner/vimoutliner'
" plugins for languages
Plugin 'groenewege/vim-less'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" solidity
" Plugin 'tomlion/vim-solidity'

" C/C++
Plugin 'c.vim'
Plugin 'taglist.vim'

" Dash
Plugin 'rizzatti/dash.vim'

" others
Plugin 'tomlion/vim-solidity'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'

call vundle#end()
filetype plugin indent on
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set colorcolumn=101
set number cursorline
set showcmd
filetype indent on
set wildmenu lazyredraw showmatch
set incsearch hlsearch
set foldenable foldlevelstart=10 foldnestmax=10 foldmethod=indent
" make B to the beginning of the line, E to the end of the line
nnoremap B ^
nnoremap E $
nnoremap $ <nop>
nnoremap ^ <nop>


map <F2> :NERDTreeToggle<CR>
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
nmap <C-i> :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif


let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
let NERDTreeIgnore = ['\.pyc$']

let g:ctrlp_working_path_mode = 'w'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Airline
let g:airline_powerline_fonts = 1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_loc_list_height = 4

let g:syntastic_html_tidy_exec = 'tidy'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'

" Taglist
let Tlist_Use_Right_Window=1
