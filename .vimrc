" for testing different rgb mappings for colors
"let rgb_file = "~/.vim/rgb.txt"

" don't worry about trying to stick to vi/ex conventions
set nocompatible

" This is for the Syntastic plugin, we need to set it before it loads
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

" load all the vim bundles I've installed
call pathogen#runtime_append_all_bundles() 

" Enable syntax hilighting and set colour scheme
syntax on
colorscheme wombat256mod

" for MacVim
set transparency=8
set guioptions=aAce

" Syntax hilight based on filetype, which is autmatically determined.
filetype off
filetype on
filetype plugin on
filetype indent on

" Enable syntax folding for blocks and comments.
set foldmethod=syntax
set foldminlines=3
set foldlevel=1

" indentation configuration
set cindent
set smartindent
set autoindent
" list of keys that will cause reindenting of the current line in insert mode
" this used to cause issues with my comma key, but I think its fixed now :)
"set cinkeys=\{,\},:,0#,!,!^F
"set cinkeys=0{,0},0),0#,!<Tab>,;,:,o,O,e
"set indentkeys=!<Tab>,o,O

" Convert tabs to spaces, use 2 spaces in place of tabs.
set expandtab
set tabstop=2
set shiftwidth=2

" The current buffer can be put to the background without writing to disk;
" When a background buffer becomes current again marks and undo-history are
" remembered.
" This also means files are still "open" in vim when you :q them.
set hidden

" Open new windows on the bottom or right instead of the top and left. 
set splitbelow
set splitright

" Make the command and search history frickin' huge
set history=1000

" File name tab completion functions like bash, it gives you a list of
" options instead of automatically filling in the first possible match.
set wildmenu
" It will however, with this option, complete up to the first character of
" ambiguity.
set wildmode=list:longest

" Show line numbers
set number

" Don't beep, blink instead
set visualbell

" Make clipbord work on OS X. This makes copy/paste operations trivial between
" vim and other applications since they all use the same clipboard now.
set clipboard=unnamed
" visual select automatically copies to X11's selection ("middle click") buffer
set go+=a

" scrolls the buffer before you reach the last line of the window
set scrolloff=3

" text search options
set hlsearch
set incsearch
set ignorecase 
set smartcase

" for exhuberant CTags support
set tags=./tags;/

" makes vim treat question marks as part of a word in ruby
au BufRead *.rb,*.rake,*.rhtml,<ruby>  set isk=?,@,48-57,_,192-255

" sets backspace key functions, allows it to backspace over end of line
" characters, start of line, and indentation
set backspace=indent,eol,start

" enable mouse in console
set mousemodel=extend
set mouse=a

" my own personal keybindings/shortcuts
" for rails.vim
map <leader>r <Esc>:R
map <leader>rm <Esc>:Rmodel<CR>
map <leader>rc <Esc>:Rcontroller<CR>
" for fuzzyfinder
map <leader>ff <Esc>:FufFile<CR>
map <leader>fb <Esc>:FufBuffer<CR>
map <leader>ft <Esc>:FufTag<CR>
map <leader>fq <Esc>:FufQuickfix<CR>
map <leader>fd <Esc>:FufDir<CR>
" for gundo
map <leader>g <Esc>:GundoToggle<CR>
" runs diff against the current buffer and the file on disk
map <leader>d <Esc>:w !diff % -<CR>
" search hilighting control, enables and disable intelligently and toggles
"nnoremap / :set hlsearch<CR>/
"nnoremap ? :set hlsearch<CR>?
"nnoremap n :set hlsearch<CR>n
"nnoremap N :set hlsearch<CR>N
"nnoremap <CR> :noh<CR><CR>
nnoremap <leader>/ :set hlsearch!<CR>

" tab goes into insert mode from normal mode and jumps to the first
" nonwhitespace character.
nmap <Tab> i<Tab><Esc>^

" tab navigation like firefox
:nmap <C-S-tab> :tabprevious<cr>
:nmap <C-tab> :tabnext<cr>
:map <C-S-tab> :tabprevious<cr>
:map <C-tab> :tabnext<cr>
:imap <C-S-tab> <ESC>:tabprevious<cr>i
:imap <C-tab> <ESC>:tabnext<cr>i
:nmap <C-t> :tabnew<cr>
:imap <C-t> <ESC>:tabnew<cr> 

" make mouse scrolling work in vim!!!
:map <M-Esc>[62~ <ScrollWheelUp>
:map! <M-Esc>[62~ <ScrollWheelUp>
:map <M-Esc>[63~ <ScrollWheelDown>
:map! <M-Esc>[63~ <ScrollWheelDown>
:map <M-Esc>[64~ <S-ScrollWheelUp>
:map! <M-Esc>[64~ <S-ScrollWheelUp>
:map <M-Esc>[65~ <S-ScrollWheelDown>
:map! <M-Esc>[65~ <S-ScrollWheelDown>

" make keypad work in vim with iTerm on OS X!
:map <Esc>Oq 1
:map <Esc>Or 2
:map <Esc>Os 3
:map <Esc>Ot 4
:map <Esc>Ou 5
:map <Esc>Ov 6
:map <Esc>Ow 7
:map <Esc>Ox 8
:map <Esc>Oy 9
:map <Esc>Op 0
:map <Esc>On .
:map <Esc>OQ /
:map <Esc>OR *
:map <kPlus> +
:map <Esc>OS -
:map! <Esc>Oq 1
:map! <Esc>Or 2
:map! <Esc>Os 3
:map! <Esc>Ot 4
:map! <Esc>Ou 5
:map! <Esc>Ov 6
:map! <Esc>Ow 7
:map! <Esc>Ox 8
:map! <Esc>Oy 9
:map! <Esc>Op 0
:map! <Esc>On .
:map! <Esc>OQ /
:map! <Esc>OR *
:map! <kPlus> +
:map! <Esc>OS -


"ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

" Spell Check with ctrl+T
"map ^S:w!<CR>:!aspell check %<CR>:e! %<CR>
" set the spellcheck language
setlocal spell spelllang=en_us
" disable spellcheck by default since it annoys me
set nospell

" creates a new :Shell command that works like :! but opens the result in a
" new window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  let isfirst = 1
  let words = []
  for word in split(a:cmdline)
    if isfirst
      let isfirst = 0  " don't change first word (shell command)
    else
      if word[0] =~ '\v[%#<]'
        let word = expand(word)
      endif
      let word = shellescape(word, 1)
    endif
    call add(words, word)
  endfor
  let expanded_cmdline = join(words)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:  ' . a:cmdline)
  call setline(2, 'Expanded to:  ' . expanded_cmdline)
  call append(line('$'), substitute(getline(2), '.', '=', 'g'))
  silent execute '$read !'. expanded_cmdline
  1
endfunction


" Display the file name of the current file in the Terminal (xterm/item/&c)
" title.
set title
autocmd BufEnter * let &titlestring = "vim: " . expand("%:p:~")
"autocmd BufEnter * exe "echo '\033'+bufname("%")+'\007'"

" statusline tweaks
set ls=2 " Always show status line
if has('statusline')
  " Status line detail:
  " %f     file path
  " %y     file type between braces (if defined)
  " %([%R%M]%)   read-only, modified and modifiable flags between braces
  " %{'!'[&ff=='default_file_format']}
  "        shows a '!' if the file format is not the platform
  "        default
  " %{'$'[!&list]}  shows a '*' if in list mode
  " %{'~'[&pm=='']} shows a '~' if in patchmode
  " (%{synIDattr(synID(line('.'),col('.'),0),'name')})
  "        only for debug : display the current syntax item name
  " %=     right-align following items
  " #%n    buffer number
  " %l/%L,%c%V   line number, total number of lines, and column number
  function SetStatusLineStyle()
    if &stl == '' || &stl =~ 'synID'
      let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]}%{'~'[&pm=='']}%=%{SyntasticStatuslineFlag()} #%n %l/%L,%c%V "
    else
      let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]} (%{synIDattr(synID(line('.'),col('.'),0),'name')})%=#%n %l/%L,%c%V "
    endif
  endfunc
  " Switch between the normal and vim-debug modes in the status line
  nmap _ds :call SetStatusLineStyle()<CR>
  call SetStatusLineStyle()
  " Window title
  if has('title')
    set titlestring=%t%(\ [%R%M]%)
  endif
endif

" use a user-local vim-specific directory for backups rather than the global
" tmp directory by default
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" lets you navigate logic constructs with the % key
runtime macros/matchit.vim

" For Project.vim
":let g:proj_flags="imstvcg"

" for NERDTree.vim
"set winfixwidth

