" Type :so % to refresh .vimrc after making changes
" most setttings taken from:
" https://github.com/colbycheeze/dotfiles/blob/master/vimrc

" use vim settings
set nocompatible

" leader
let mapleader=","


set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler
set laststatus=2        "Always display status line
set autowrite           "Automatically :write before running commands
set showcmd             "display incomplete command

" Trigger autoread when changing buffers or coming back to vim in terminal
au FocusGained,BufEnter * :silent! !

set guifont=Inconsolata\ for\ Powerline:h24
set cursorline
set visualbell
set wildmenu
set wildmode=list:longest,full

"Allow usage of mouse in iTerm
set ttyfast
set mouse=a

"Make searching better
set ignorecase
set smartcase
set hlsearch "temporarily turn of highlighting with :nohlsearch

"Make it obvious where 100 characters is
set textwidth=100
set formatoptions=qrn1
set wrapmargin=0
set colorcolumn=+1

"open new split to right and bottom
" set splitbelow
set splitright

" auto resize vim splits to active split
set winwidth=104
set winheight=5
set winminheight=5
set winheight=999

" HTML Editing
set matchpairs+=<:>
let g:html_indent_tags = 'li\|p' "Treat <li> and <p> tags like block tags

"Scrolling
set scrolloff=8 "start scrolling 8 lines away from margin

"Toggle relative numbering, and set to absolute on loss of focus or insert mode
set rnu
function! ToggleNumbersOn()
    set nu!
    set rnu
endfunction
function! ToggleRelativeOn()
    set rnu!
    set nu
endfunction
autocmd FocusLost * call ToggleRelativeOn()
autocmd FocusGained * call ToggleRelativeOn()
autocmd InsertEnter * call ToggleRelativeOn()
autocmd InsertLeave * call ToggleRelativeOn()

"Use enter to create new lines w/o entering insert mode
nnoremap <CR> o<Esc>
"Below is to fix issues with the ABOVE mappings in quickfix window
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

" Navigate properly when lines are wrapped
nnoremap j gj
nnoremap k gk

" Always use vertical diffs
 set diffopt+=vertical

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
    syntax on
endif

   " Load up all of our plugins
if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

filetype plugin indent on

""" SYSTEM CLIPBOARD COPY & PASTE SUPPORT
set pastetoggle=<F2> "F2 before pasting to preserve indentation
"Copy paste to/from clipboard
vnoremap <C-c> "*y
map <silent><Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
map <silent><Leader><S-p> :set paste<CR>O<esc>"*]p:set nopaste<cr>"

"Map Ctrl + S to save in any mode
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
" Also map leader + s
map <leader>s <C-S>

"tabs to spaces
set tabstop=4
set shiftwidth=4
set expandtab

"required for vimwiki
syntax on

"pathogen
execute pathogen#infect()

"auto reload vimrc when changes are made
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
