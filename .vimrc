" set smartindent
" execute pathogen#infect()
runtime vimrc
set tabstop=4
set shiftwidth=4
set expandtab
map <F7> mzgg=G`z<CR>
syntax on
filetype on
au BufNewFile,BufRead *.install set filetype=php
au BufNewFile,BufRead *.info set filetype=php
" defscrollback 10000
