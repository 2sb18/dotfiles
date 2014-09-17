" got a bunch of stuff from Steve Losh's vimrc
"
"
" Ideal Coding Setup -------------------------------------- {{{

" Autoformatting - autoformat
" Autocompiling - syntastic
" Autocomplete - Super Tab
" Unit Testing - Dispatch. raco for racket
" Tagging - ctags, autotag, and autoproto (maybe Super Tab)
" Debugging - vdebug for some stuff (PHP)
" Linting (optional) - syntastic + linting program
" Versioning - Fugitive for Git and Lawercium for Mercurial

" Global searching/replacing - Greplace
"
" }}}   
" things to learn/fix in vim ------------------------------ {{{
" - install the plugin alternate
" - install Cscope
" - Ack!!!!
" - find a better changelist plugin, one that works across files
" }}}
" OS ------------------------------------------------------ {{{

" makes incompatible with vi, which has lots of bugs
" has to happen before other settings
set nocompatible
filetype off

if has("win32") || has("win16")
  let s:is_windows=1
  let s:term_command='cmd'
else
  let s:is_windows=0
  let s:term_command='bash'
endif
" }}}
" Vundle - ------------------------------------------------ {{{
"


if s:is_windows
  set runtimepath+=$HOME\vimfiles\bundle\vundle
  call vundle#begin('~\vimfiles\bundle')
else
  set runtimepath+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
endif

" Must haves

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'bling/vim-airline'
Bundle 'scrooloose/nerdtree'
" gotta switch back to scrooloose/syntastic after I've done my thing
Bundle '2sb18/syntastic'
Bundle 'tomtom/tcomment_vim'
Bundle 'Chiel92/vim-autoformat'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'sjl/gundo.vim'
Bundle 'ervandew/supertab'
Bundle 'vim-scripts/matchit.zip'
Bundle 'vim-scripts/bufkill.vim'
Bundle 'tpope/vim-fugitive'
" global search and replace
Bundle 'skwp/greplace.vim'
" full path fuzzy file, buffer, mru, tag, ... finder for vim
Bundle 'kien/ctrlp.vim'

" not working well for me. should have more manual
" control over tagging
" Bundle 'vim-scripts/AutoTag'


" Language specific
Bundle 'maksimr/vim-jsbeautify'
Bundle 'vim-scripts/Conque-GDB'


" ack -
" autoproto
" bufkill
" conque_2.3
" ctrlp
" greplace
" lawrencium
" rainbow_parentheses
" slimv
" syntastic
" tagbar - Vim plugin that displays tags in a window, ordered by scope http://majutsushi.github.com/tagbar/
" vdebug
" vim-classpath
" vim-clojure
" vim-dispatch
" vim-fireplace
" vim-fugitive
" vim-racket

" a - alternate files quickly .c --> .h

call vundle#end()
filetype plugin indent on

" }}}
" Environments (GUI, Console, Fonts ) --------------------- {{{

if s:is_windows
  set guifont=DejaVu_Sans_Mono_for_Powerline:h11:cANSI
else 
  set gfn=Droid\ Sans\ Mono\ for\ Powerline\ 11
endif

colorscheme molokai

" make comments brighter
hi Comment guifg=#C8C8C8

augroup CursorColours
  au!
  au WinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

syntax on

highlight Cursor guifg=black guibg=green
highlight iCursor guifg=black guibg=magenta
" highlight CursorLine guibg=#111111 
highlight CursorLine guibg=#36291C
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0

" make it so all swap files go to temp directory

" the ! on the silent silences errors, this error being
" that the temp directory already exists
silent! execute '!mkdir "'.$HOME.'/temp"'
set backupdir=$HOME/temp//
set directory=$HOME/temp//
set undodir=$HOME/temp//

" enable rainbow parenthesis
" don't know what this is used for
" let g:lisp_rainbow = 1

" }}}
" Basic Options ------------------------------------------- {{{

" so that K uses :h instead of man
set keywordprg=  
" don't show intro message
set shortmess+=I 
set modelines=0
" use 2 spaces for tab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set shiftround
set expandtab
set encoding=utf-8
set scrolloff=5
set autoindent
set showmode
set showcmd
set hidden
set nolist
" set listchars=tab:▸\ ,extends:❯,precedes:❮
set showbreak=↪
set splitbelow
set splitright
" tab completion on the command-line
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
" T gets rid of menu buttons
" t gets rid of tearoff menu items
set guioptions-=t
set guioptions-=T
set guioptions-=r
set guioptions-=L

" line numbers that are relative
set relativenumber
set undofile
set undoreload=10000
set gdefault
" tame searching/moving
" magic regexs, so they are like normal
nnoremap / /\v
vnoremap / /\v
set hlsearch

set ignorecase
" if any letters are capitalized in a search,
" then search is case-sensitive
set smartcase
set incsearch
set showmatch

set wrap
" only wrap at a character in teh 'breakat' option
set linebreak
" vim doesn't insert newline characters to break lines 
set textwidth=0
set wrapmargin=0
set formatoptions=qrn1l
" vim 7.3 doesn't seem to like j
if !s:is_windows
  set formatoptions+=j
endif
" }}}
" Convenience Mappings ------------------------------------ {{{

" Non-Leader Mappings {{{ 
" gj moves down screen lines instead of file lines
nnoremap j gj
nnoremap k gk

inoremap jk <esc>
"
" Select entire buffer
" need the g_ to select all of the last line
nnoremap vaa ggVGg_
" indent all
nnoremap vad ggVGg_d
nnoremap vai :let b:save_cursor = getpos(".")<cr>ggVG=:call setpos('.', b:save_cursor)<cr>

" for searching
nnoremap n nzz
nnoremap N Nzz

nnoremap H 0
vnoremap H 0
nnoremap L $
vnoremap L $
" 
" used for inserting one character
" getchar() gets a character from the user input, nr2char turns that character
" into a string
nnoremap s :exe "normal i".nr2char(getchar())."\e"<CR>
nnoremap <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
nnoremap <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>

" make it easy to add lines above and below current line
nnoremap <C-j> O<Esc>j<C-e>
" put space below the current line
nnoremap <C-k> o<Esc>k


" make it easier to move around in insert mode
inoremap <c-h> <left>
inoremap <c-l> <right>
inoremap <c-j> <down>
inoremap <c-k> <up>

" get rid of n_ctrl-z mapping
inoremap <c-z> <c-o>zz

" open up a new tab with a ctrl-w thing
nnoremap <c-w>t :tabnew<cr>

" get rid of :clo mapping while I learn ctrl-w c
" nnoremap :clo <nop>
"
" move around easier
nnoremap } }zz
nnoremap { {zz
nnoremap ( (zz
nnoremap ) )zz

" "Uppercase word" mapping.
"
" This mapping allows you to press <c-u> in insert mode to convert the current
" word to uppercase.  It's handy when you're writing names of constants and
" don't want to use Capslock.
"
" To use it you type the name of the constant in lowercase.  While your
" cursor is at the end of the word, press <c-u> to uppercase it, and then
" continue happily on your way:
"
"                            cursor
"                            v
"     max_connections_allowed|
"     <c-u>
"     MAX_CONNECTIONS_ALLOWED|
"                            ^
"                            cursor
"
" It works by exiting out of insert mode, recording the current cursor location
" in the z mark, using gUiw to uppercase inside the current word, moving back to
" the z mark, and entering insert mode again.
"
" Note that this will overwrite the contents of the z mark.  I never use it, but
" if you do you'll probably want to use another mark.
inoremap <C-u> <esc>mzgUiw`za
"

" make it easier to apply the dot command to each line of a selection
xnoremap . :normal .<CR>

" map it easy to run macros on a line-by-line basis over a visual selection
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" }}}
" Leader Mappings {{{

let mapleader = ","

" double tap , to go back through search
nnoremap <leader>; ,
nnoremap <leader>aa :Ack 
nnoremap <leader>aw :Ack <C-r><C-w><cr>
" make current window bigger
nnoremap <leader>bb <c-w>10><c-w>10+
nnoremap <leader>be :BufExplorerVerticalSplit<cr> 
" bf for brackets oFf
nnoremap <leader>bf :let paredit_mode = 0<cr>
" bn for brackets oN
nnoremap <leader>bn :let paredit_mode = 1<cr>
" open ctrlp buffer window
nnoremap <leader>bw :CtrlPBuffer<cr>
nnoremap <leader>cc :Compile<cr>
nnoremap <leader>cg :Debug<cr>
nnoremap <leader>cr :Run<cr>
nnoremap <leader>ct :CTags<cr>
nnoremap <leader>ca :ConqueRacket<cr>
nnoremap <leader>cd :cd %:h<cr>
" nnoremap <leader>cr :ConqueReload<cr>
nnoremap <leader>cs :ConqueStart<cr>
" nnoremap <leader>d :DiffSaved<cr>
nnoremap <leader>d :bp<cr>
" nnoremap <leader>et :tabe $MYVIMRC<cr>
nnoremap <leader>ev :vs $MYVIMRC<cr>
nnoremap <leader>es :w<cr>:let b:vimrc_wd = getcwd()<cr>:so $MYVIMRC<cr>:exe "cd " . b:vimrc_wd<cr>:bd<cr>
" reload vimrc but don't close it
nnoremap <leader>er :w<cr>:let vimrc_wd = getcwd()<cr>:so $MYVIMRC<cr>:exe "cd " . vimrc_wd<cr>
" open an explorer window for the pwd
nnoremap <leader>ex :execute "!start explorer" getcwd()<cr>
" open an explorer window for the bundle directory
" echo fnamemodify($MYVIMRC, ":h") . "\\vimfiles\\bundle"
" nnoremap <leader>ee :execute "!start explorer fnamemodify($MYVIMRC, \":h\") . \"\\vimfiles\\bundle\""
" switching quickly between open buffers
nnoremap <leader>f :bn<cr>
nnoremap <leader>g :GundoToggle<cr>



"for linting
nnoremap <leader>l :cd %:h<cr>:silent !lint.bat<cr>:cf lint_errors.txt<cr>
"
" m for mark. easily create bookmarks in NERDTree
nnoremap <leader>m :exe "Bookmark " . substitute( matchstr( getline("."), '-\=\<.*' ), ' ', '_', '' )<cr>
nnoremap <leader>n :NERDTreeToggle<cr>
" for some reason these gotta be nmaps instead of nnoremaps
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" recently opened files
nnoremap <leader>r :CtrlPMRU<cr>


" replace all words in a file
nnoremap <leader>s :%s/\<<C-r><C-w>\>/
if !s:is_windows
  nnoremap <leader>tm :call VimuxRunCommand("clear;")<cr>
endif
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>x :BD<cr>
nnoremap <leader>z :BD<cr><C-w>c
nnoremap <leader><space> :noh<cr>
" crappy solution but kinda works!
nnoremap <leader>rows :normal i select table_name, table_rows from information_schema.tables where table_schema = (select database());

" }}}

" }}}
" Folding ------------------------------------------------- {{{

set foldmethod=marker
set foldlevelstart=0  "always start editing with all folds closed

nnoremap <space> za
vnoremap <space> za

" "Focus" the current line.  Basically:
"
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line to a little bit (15 lines) above the center of the screen.
" 4. Pulse the cursor line.  My eyes are bad.
"
" This mapping wipes out the z mark, which I never use.
"
" I use :sus for the rare times I want to actually background Vim.
nnoremap <c-z> mzzMzvzz15<c-e>`z:Pulse<cr>

function! MyFoldText() " {{{
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" }}}
" Filetype-specific --------------------------------------- {{{
" PHP {{{
augroup ft_php
  au!
  au FileType php setlocal foldnestmax=1
  au FileType php setlocal foldmethod=indent
  au BufWrite *.php :Autoformat
augroup END

" }}}
" Javascript {{{
augroup ft_javascript
  au!
  au BufWrite *.js :Autoformat
augroup END

let g:formatprg_javascript="js-beautify"
let g:formatprg_args_javascript="--indent-size 2 --file -"


" }}}
" C {{{
augroup ft_c
  au!
  " au FileType c setlocal 
  " au FileType c setlocal foldmethod=indent foldlevel=1 foldclose=all
  " au FileType c setlocal colorcolumn=85
  " if !s:is_windows
    au BufWrite *.c :Autoformat
  " endif

augroup END

" indent 2 spaces
" attach brackets style
" indent classes, switches, namespaces
" pad operators, parenthesis
" keep one line statements
let g:formatprg_c = "astyle"
let g:formatprg_args_c = "--indent=spaces=2 --style=java --indent-classes --indent-switches --indent-namespaces --pad-oper --pad-paren --keep-one-line-statements"

" }}}
" Racket {{{
augroup ft_racket
  au!
  au BufWrite *.rkt :Autoformat
  " au BufWritePost *.rkt :Dispatch raco test %
  " au BufWritePost *.rkt :exe "Dispatch raco test" expand("%:p:8")
  au FileType racket :abbrev <buffer> #langp #lang planet neil/sicp
  au FileType racket setlocal commentstring="; %s"
  au FileType racket :RainbowParenthesesActivate
  au FileType racket :RainbowParenthesesLoadRound
  au FileType racket :RainbowParenthesesLoadSquare
  au FileType racket :RainbowParenthesesLoadBraces
augroup END  
" }}}
" Vim {{{
augroup ft_vim
  au!
  " vim help files have filetype 'help'
  au FileType vim,help setlocal number!
augroup END
" }}}
" HTML {{{
augroup ft_html
  au!
  au FileType html setlocal spell spelllang=en_us
  au BufWrite *.html :Autoformat
augroup END
"
" }}}
" text {{{
augroup ft_text
  au!
  au FileType text setlocal spell spelllang=en_us
augroup END
" }}}
" tags {{{
augroup ft_tags
  au!
  au BufRead,BufNewfile *.mptags setlocal filetype=tags
augroup END
" }}}
" Markdown {{{
augroup ft_markdown
  au!
  au BufRead,BufNewFile *.md setlocal filetype=markdown
augroup END
" }}}
" }}}
" Plugin settings ----------------------------------------- {{{
" NERDTree {{{
let NERDTreeShowBookmarks = 1
let NERDTreeMinimalUI = 1
let NERDChristmasTree = 1
" }}}
" slimv {{{

let g:slimv_preferred = 'mit'

let g:slimv_swank_cmd = '!start mit-scheme --band C:\MIT-Scheme\lib\all.com --library C:\MIT-Scheme\lib --load "C:\Users\SteveB\Documents\My Dropbox\Personal\home\vimfiles\bundle\slimv\slime\contrib\swank-mit-scheme.scm"'  
"let g:slimv_preferred = 'sbcl'
"let g:slimv_swank_cmd = '!start sbcl --load "' . $HOME . '\vimfiles\bundle\slimv\slime\start-swank.lisp"'
let g:slimv_leader = '\'

" }}}
" ctrlp {{{
let g:ctrlp_cache_dir = $TEMP.'/.cache/ctrlp'
let g:ctrlp_match_window = 'max:30'
" }}}
" bufExplorer {{{
let g:bufExplorerShowNoName=1
"let g:bufExplorerShowUnlisted=1
let g:bufExplorerSplitRight=1
let g:bufExplorerFindActive=0        " Do not go to active window.
" }}}
" ConqueTerm {{{
let g:ConqueTerm_ReadUnfocused = 1

function! ConqueWriteAndWait( to_write, search_pattern )
  call g:my_term.writeln( a:to_write )
  let times_left = 1000
  while ( match ( g:my_term.read(100), a:search_pattern ) == -1 ) 
    let times_left = times_left - 1
    if ( times_left == 0 )
      break
    endif
  endwhile
endfunction

function! s:ConqueStart()
  w
  cd %:h
  let g:file_name = expand("%")
  let g:my_term = conque_term#open( s:term_command, ['vs'] )
  " gotta be something better than sleep!
  " don't really want it to hang
  sleep 1
  call ConqueWriteAndWait( 'racket -il xrepl','>' )
  call ConqueWriteAndWait( ',rr "' . g:file_name . '"', '>' )
  call ConqueWriteAndWait( ',en "' . g:file_name . '"', '>' )
endfunction
command! ConqueStart call s:ConqueStart()

function! s:ConqueReload()
  w
  cd %:h
  call ConqueWriteAndWait( ',top', '>' )
  call ConqueWriteAndWait( ',rr "' . g:file_name . '"', '>' )
  call ConqueWriteAndWait( ',en "' . g:file_name . '"', '>' )
endfunction
command! ConqueReload call s:ConqueReload()

function! s:ConqueRacket()
  w
  cd %:h
  let file_name = expand("%")
  let racket_term = conque_term#open( s:term_command, ['vs'] )
  sleep 1
  call racket_term.writeln( 'racket "' . file_name . '"' )
endfunction
command! ConqueRacket call s:ConqueRacket()
" }}}
" syntastic {{{

let g:syntastic_debug = 0
let g:syntastic_aggregate_errors=1
let g:syntastic_c_checkers=['gcc', 'pc_lint']
let g:syntastic_c_compiler_options = '-std=gnu99 -Wall'
let g:syntastic_html_checkers = ['validator']
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_javascript_jsl_conf='"%HOME%\jsl.conf"'
let g:syntastic_javascript_jshint_conf=$HOME.'/.jshintrc'
let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
" let g:syntastic_racket_checkers=['racket']

" }}}
" Airline {{{

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts=1

" }}}
" Pulse Line {{{

function! s:Pulse() " {{{
  redir => old_hi
  silent execute 'hi CursorLine'
  redir END
  let old_hi = split(old_hi, '\n')[0]
  let old_hi = substitute(old_hi, 'xxx', '', '')

  let steps = 8
  let width = 1
  let start = width
  let end = steps * width
  let color = 233

  for i in range(start, end, width)
    execute "hi CursorLine ctermbg=" . (color + i)
    redraw
    sleep 6m
  endfor
  for i in range(end, start, -1 * width)
    execute "hi CursorLine ctermbg=" . (color + i)
    redraw
    sleep 6m
  endfor

  execute 'hi ' . old_hi
endfunction " }}}
command! -nargs=0 Pulse call s:Pulse()
" }}}
" ConqueGdb {{{
    let g:ConqueGdb_Leader = ',,'
" }}}

" REMAPS -------------------------------------------------- {{{

" function defines new function
" ! silently replaces other function
" s: is for functions that are local to a script, whatever that means
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

function! s:Debug()
  w
  cd %:h
  if expand("%:e") == "c"
    ConqueGdbVSplit %:r
  else
    echo "there's no debugger for this shit!"  
  endif
endfunction

" command defines a new command 
" using the ! is necessary cause we often reexecute the vimrc
command! Debug call s:Debug()

function! s:Compile()
  w
  cd %:h
  if expand("%:e") == "c"
    !gcc %:t -o %:r -g
  elseif expand("%:e") == "rkt"
    "!start racket -il xrepl && ,en "%:t" 
    !start cmd "racket "
  else
    echo "there's no compiler for this shit!"  
  endif
endfunction

" command defines a new command 
" using the ! is necessary cause we often reexecute the vimrc
command! Compile call s:Compile()

function! s:Run()
  w
  cd %:h
  " if the extension is c
  if expand("%:e") == "c"
    " %:t is the file name 
    !./%:r
  else
    echo "there's no compiler for this shit!"  
  endif
endfunction

" command defines a new command 
" using the ! is necessary cause we often reexecute the vimrc
command! Run call s:Run()

function! s:CTags()
  w
  if s:is_windows
    !start ctags -R .
  else
    !ctags -R .
  endif
endfunction
command! CTags call s:CTags()


" }}}

" }}}
" Disorganized Crap --------------------------------------- {{{

augroup vimrc_group
  au!
  " save on loss of focus
  " using silent! so that I don't get 
  " error messages for unnamed buffers
  au FocusLost * :silent! wall

  au BufNewFile,BufEnter,BufWritePost *.html,*.js,*.php :inoremap <buffer> $( $("")<left><left>
augroup END

function! PrintCommand(the_command) " {{{
  redir => a:command_value
  execute a:the_command
  redir END
  put =a:command_value
endfunction
" }}}


function! PrintOption(the_option)   " {{{
  redir => a:option_value
  execute "set " . a:the_option . "?"
  redir END
  put =a:option_value
endfunction
" }}}

function! PrintVersion()   " {{{
  new
  redir => a:version_value
  version
  redir END
  put =a:version_value
endfunction
" }}}
"
" }}}
