if has("gui_running")
  "set guioptions-=T
  set guioptions+=c
  set lines=50
  set columns=100
endif

"set guifont=Terminus:h12

syntax on
"colorscheme railscasts
colorscheme vibrantink

"set directory=~/.vim/backup
"set backupdir=~/.vim/backup
set nobackup
set nowritebackup
set history=50
set showcmd
" Always display the status line
set laststatus=2

" Don't use Ex mode, use Q for formatting
map Q gq

set fileformat=unix

set nocompatible
set nowrap
set number
set hlsearch
set wildmenu
set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set expandtab

" Use Objective-C syntax highlighting on *.m and *.h file types.
au BufNewFile,BufRead *.m,*.h set ft=objc

" Show relative paths in bufExplorer
let g:bufExplorerShowRelativePath=1

" Make NERD Commentor stop complaining about unknown file types.
let g:NERDShutUp = 1

" Don't let NERD Tree hijack Netrw
let g:NERDTreeHijackNetrw = 0

let mapleader = ","

map <Leader>b :BufExplorer<CR>
map <Leader>e :Ex<CR>
map <Leader>s :Scratch<CR>
map <Leader>t :FuzzyFinderTextMate<CR>
map <Leader>n :NERDTree<CR>

"Drongo add
" Enable loading filetype and indentation plugins
filetype plugin on
filetype indent on
if has("folding")
  set foldenable
  set foldmethod=syntax
  set foldlevel=1
  set foldnestmax=2
  set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\'.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
endif

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Keep 50 lines of command line history
set history=50

" Autoclose folds, when moving out of them
set foldclose=all

" Open all folds
set foldenable

"
" " \ is the leader character
let mapleader = "\\"
"
" Edit the README_FOR_APP (makes :R commands work)
map <Leader>R :e doc/README_FOR_APP<CR>

"der shortcuts for Rails commands
map <Leader>m :Rmodel 
map <Leader>c :Rcontroller 
map <Leader>v :Rview 
map <Leader>u :Runittest 
map <Leader>f :Rfunctionaltest 
map <Leader>tm :RTmodel 
map <Leader>tc :RTcontroller 
map <Leader>tv :RTview 
map <Leader>tu :RTunittest 
map <Leader>tf :RTfunctionaltest 
map <Leader>sm :RSmodel 
map <Leader>sc :RScontroller 
map <Leader>sv :RSview 
map <Leader>su :RSunittest 
map <Leader>sf :RSfunctionaltest 

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Maps autocomplete to tab
imap <Tab> <C-N>

" Hide search highlighting
map <Leader>h :set invhls <CR>

set foldmethod=marker
"set foldmethod=indent

" Turn off any bells
set novisualbell
set t_vb=   

" Enable mouse
set mouse=a
set mousemodel=popup

function SMap(key, action, ...)
    let modes = " vi"
    if (a:0 > 0)
        let modes = a:{1}
    endif
    if (match(modes, '\Ii') != -1)
        execute 'imap ' . a:key . ' <Esc>' . a:action
    endif
    if (match(modes, '\Nn') != -1)
        execute 'nmap ' . a:key . ' <Esc>' . a:action
    endif
    if (match(modes, ' ') != -1)
        execute 'map ' . a:key . ' <Esc>' . a:action
    endif
    if (match(modes, '\Vv') != -1)
        execute 'vmap ' . a:key . ' <Esc>' . a:action
    endif
endfunction

" Make shift-insert work like in Xterm
imap <S-Insert> <MiddleMouse>

" Status line format
set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P 

" Search & replace the word under the cursor
nmap ; :%s/\<<c-r>=expand("<cword>")<cr>\>/



" F2 to quick save
call SMap("<F2>", ":w<cr>")

" F4 - Project toogle
call SMap("<silent><F4>", "<Plug>ToggleProject")

" C-T - new tab
call SMap("<C-t>", ":tabnew<cr>")

" Open tag under cursor in new tab
map <C-W>] <C-W>]:tab split<CR>gT:q<CR>gt 

" Tab autocompletion
function InsertTabWrapper()
     let col = col('.') - 1
     if !col || getline('.')[col - 1] !~ '\k'
         return "\<tab>"
     else
         return "\<c-p>"
     endif
endfunction

imap <tab> <c-r>=InsertTabWrapper()<cr>

set complete=""
set complete+=.
set complete+=k
set complete+=b
set completeopt-=preview
set completeopt+=longest

map <Leader>tl :call MoveTabLeft()<CR>
map <Leader>tr :call MoveTabRight()<CR>

" Useful newline bindings for normal mode
map <S-Enter> O<Esc>
map <CR> o<Esc>

" Encoding menu
set wildmenu
set wcm=<Tab> 
menu Encoding.&koi8-r :e ++enc=koi8-r<CR>
menu Encoding.&windows-1251 :e ++enc=cp1251<CR>
menu Encoding.&cp866 :e ++enc=cp866<CR>
menu Encoding.&utf-8 :e ++enc=utf8 <CR>

" For 'view' mode
if &readonly == 1
        set nonumber
        set nofoldenable
        set foldcolumn=10

        nmap <F10> :qa<cr>
        nmap <Space> <PageDown>
endif

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu
set wildmode=list:longest,list:full
set complete=.,t

" case only matters with mixed case expressions
set ignorecase
set smartcase
"
" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

highlight TooLongLine term=reverse ctermfg=Yellow ctermbg=Red
match TooLongLine /.\%>81v/

