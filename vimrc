" vimrc
" Author: sprinfall@gmail.com

"-------------------------------------------------------------------------------
" Encoding, Font, etc.

" Normally 'encoding' will be equal to your current locale.
" You can detect the locale via v:lang, e.g.,
"     if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
" and export LANG=... in ~/.bashrc to set the locale, e.g.,
"     export LANG=zh_CN.utf8
" You don't have to set it.
set fileencodings=utf-8,ucs-bom,gbk,gb2312,big5,latin1

if has("gui_running")
    if has("gui_gtk")
        set guifont=Ubuntu\ Mono\ Regular\ 14
    elseif has("gui_macvim")
        " TODO Verify
        set guifont=Andale\ Mono:h13,Courier\ New:h13
    elseif has("gui_win32")
        set guifont=DejaVu_Sans_Mono:h11:cDEFAULT,Courier_New:h11:cDEFAULT
        " Need to download 'GB18030 Support Package' from MS.com for SimSun-18030.
        " Make sure 'encoding' is "utf-8" and "guifontset" is empty or invalid. (except GTK+ 2)
        "set guifontwide=SimSun-18030,Arial_Unicode_MS

        set guioptions-=m  " No menu
    endif

    " Prefer console style UI.
    set guioptions-=e  " Use console style tab
    set guioptions-=T  " No toolbar
endif

" NOTE: (2017-02-07)
" If set shellslash, jedi-vim will be broken.
" See https://github.com/davidhalter/jedi-vim/issues/447 (commented by bimlas)
" if has("win32")
    " Expand file path using / instead of \ on Windows. See expand().
    " set shellslash
" endif

" for chinese
set formatoptions+=mM

"set listchars=trail:-

let mapleader = ","
let g:mapleader = ","

" &ft is empty for csv files, set to text.
au BufRead,BufNewFile *.csv setfiletype text

"-------------------------------------------------------------------------------
" Vundle

let enable_ycm = 1

filetype off

"if has("win32")
"    set rtp+=~/vimfiles/bundle/Vundle.vim
"else
    set rtp+=~/.vim/bundle/Vundle.vim
"endif
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-scripts/a.vim'
Plugin 'godlygeek/tabular'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'hrp/EnhancedCommentify'
"Plugin 'msanders/snipmate.vim'
"Plugin 'tpope/vim-fugitive'

Plugin 'Yggdroot/indentLine'
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 0
let g:indentLine_char = '|'

" Parentheses enhancements.
Plugin 'kien/rainbow_parentheses.vim'
let g:rbpt_colorpairs = [
    \ ['brown', 'RoyalBlue3'],
    \ ['Darkblue', 'SeaGreen3'],
    \ ['darkgray', 'DarkOrchid3'],
    \ ['darkgreen', 'firebrick3'],
    \ ['darkcyan', 'RoyalBlue3'],
    \ ['darkred', 'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown', 'firebrick3'],
    \ ['gray', 'RoyalBlue3'],
    \ ['black', 'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue', 'firebrick3'],
    \ ['darkgreen', 'RoyalBlue3'],
    \ ['darkcyan', 'SeaGreen3'],
    \ ['darkred', 'DarkOrchid3'],
    \ ['red', 'firebrick3'],
    \ ]
let g:rbpt_max = 40
let g:rbpt_loadcmd_toggle = 0

" Markdown
Plugin 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1
" TODO: conceal
" let g:vim_markdown_conceal = 0
" set conceallevel=0

" C++
Plugin 'vim-scripts/STL-improved'

" Rust
Plugin 'rust-lang/rust.vim'

" NOTE:
" For auto-complete, YCM is prefered to vim-racer.
" Actually, I can't make vim-racer work on Windows because of the incorrect
" value of col('.').

" Python
Plugin 'hdima/python-syntax'
let python_highlight_all = 1

if enable_ycm == 0
    " Auto-completion plugin for Python based on jedi (pip install jedi).
    Plugin 'davidhalter/jedi-vim'
endif

Plugin 'Glench/Vim-Jinja2-Syntax'

" Go
Plugin 'fatih/vim-go'
" Plugin 'Blackrush/vim-gocode'

" Ruby
Plugin 'vim-ruby/vim-ruby'

" HTML
Plugin 'mattn/emmet-vim'  " Zen coding

" Auto-close html/xml tags.
Plugin 'docunext/closetag.vim'
let g:closetag_html_style=1

" JS
Plugin 'wookiehangover/jshint.vim'
Plugin 'moll/vim-node'

if enable_ycm != 0
    Plugin 'Valloric/YouCompleteMe'
	Plugin 'rdnetto/YCM-Generator'
endif

" Async Lint Engine
Plugin 'w0rp/ale'

" Auto-complete brackets.
Plugin 'Raimondi/delimitMate'
" For Python docstring.
au FileType python let b:delimitMate_nesting_quotes = ['"']

if enable_ycm == 0
    " Supertab is obsoleted by YCM.
    Plugin 'ervandew/supertab'
endif

" Color schemes

Plugin 'altercation/vim-colors-solarized'
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"

Plugin 'tomasr/molokai'
set background=dark
set t_Co=256

call vundle#end()

" Enable file type detection.
" Use the default filetype settings. Also load indent files to automatically
" do language-dependent indenting ('cindent' for C, C++, Java, C# files).
filetype plugin indent on

" Plugin options

" tagbar
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
    \ 'p:package',
    \ 'i:imports:1',
    \ 'c:constants',
    \ 'v:variables',
    \ 't:types',
    \ 'n:interfaces',
    \ 'w:fields',
    \ 'e:embedded',
    \ 'm:methods',
    \ 'r:constructor',
    \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
    \ 't' : 'ctype',
    \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
    \ 'ctype' : 't',
    \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }

nmap <F2> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>

let g:EnhCommentifyRespectIndent = 'Yes'
let g:EnhCommentifyPretty = 'Yes'

" No 'preview'.
set completeopt=menuone,longest

" vim-go
let g:go_fmt_autosave = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <leader>ds <Plug>(go-def-split)
au FileType go nmap <leader>dv <Plug>(go-def-vertical)

au FileType go nmap <leader>i <Plug>(go-info)
au FileType go nmap <leader>s <Plug>(go-implements)

if enable_ycm == 0
    " jedi-vim
    "let g:jedi#force_py_version = 3
    "let g:jedi#auto_vim_configuration = 0
    let g:jedi#popup_on_dot = 1
    let g:jedi#popup_select_first = 1
    " Default <Ctrl-Space> conflicts with Chinese input method program.
    let g:jedi#completions_command = "<C-N>"
    let g:jedi#use_splits_not_buffers = "bottom"
    let g:jedi#rename_command = "<leader>r"
    let g:jedi#documentation_command = "K"
endif

if enable_ycm != 0
    " YouCompleteMe
    let g:ycm_error_symbol = '>>'
    let g:ycm_warning_symbol = '>*'
    nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
    nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
    nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
    nmap <F4> :YcmDiags<CR>
endif

"-------------------------------------------------------------------------------
" General

set nocompatible
set history=400

set nobackup
set nowritebackup
set noswapfile

" Persistent undo serializes to a file named '.<filename>.un~'.
" That's a little anoying.
"if v:version >= 730
"    set undofile " .
"endif

nmap <leader>w :w!<CR>
nmap <leader>f :find<CR>

if has("win32")
    set ffs=dos,unix,mac
else
    set ffs=unix,mac,dos
endif

" Remove the Windows ^M
noremap <leader>m :%s/<C-V><C-M>//ge<CR>

" Restore cursor to file position in previous editing session.
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Automatically save and restore views for files.
" NOTE: Using * instead of ?* causes error.
"au BufWinLeave ?* mkview
"au BufWinEnter ?* silent loadview

" Display dynamic information in tooltip based on where the mouse is pointing.
if has("balloon_eval")
    set ballooneval
endif

"-------------------------------------------------------------------------------
" Format (indent, tabs, wrap, etc.)

" Will be overruled by 'indentexpr' if it's not empty.
" You can also try smartindent, autoindent.
set cindent

" t0: no indent for function return type declaration.
" g0: no indent for C++ scope declarations ('public:' 'private:' etc.)
" :0: no indent for labels of switch().
set cinoptions=t0,g0,:0

" NOTE: After expand tab, type "C-v tab" to get the unexpanded tab.
" If you have a file that contains tabs then you can convert them to spaces by typing :retab.
" :retab replaces a tab with &tabstop/ts number of spaces.
" For tabstop: default 8. Better not to change it.

"set smarttab

" For c, cfg, cmake, go, python, sql, vim, etc.
set expandtab | set ts=4 | set sw=4

au FileType cpp,html,lua,javascript,nsis,objc,ruby set expandtab | set ts=2 | set sw=2
au FileType htmldjango set expandtab | set ts=2 | set sw=2
au FileType make set noexpandtab | set ts=8 | set sw=8

" textwidth is useful to formating comments.
" set textwidth=80

" linebreak makes sense only when wrap is on & list is off(nolist)
set linebreak

" Highlight the specified column(s), but it makes redrawing slower.
" set colorcolumn=+1

set nowrap
au FileType ant,html,markdown,xml,text set wrap

set breakindent

"-------------------------------------------------------------------------------
" Color Scheme

if &t_Co > 2 || has("gui_running")
    set background=dark
    syntax enable
    colorscheme desert
    au BufEnter * :syntax sync fromstart
endif

"-------------------------------------------------------------------------------
" Folding (TODO)

" set foldenable
" set foldlevel=3
" set foldcolumn=3
" set foldmethod=indent

"let g:xml_syntax_folding=1
" ISSUE: JavaScript syntax folding doesn't work event you open it by setting
" javaScript_fold.
"let javaScript_fold=1

"syntax sync fromstart
"au FileType c,cpp,java,xml set foldmethod=syntax
"au FileType python set foldmethod=indent

"-------------------------------------------------------------------------------
" User Interface

" Enable mouse even for terminals.
if has("mouse") | set mouse=a | endif

set showcmd " show (partial) command in the last line of the screen.
set showmode " TODO
set so=7 " number of lines to curor when moving vertically
" Show candidates in the statusline when using TAB to complete.
set wildmenu
set wildmode="list:longest"
set ruler
set cmdheight=2

" You may also want to try 'relativenumber'.
set number

set lazyredraw
set hidden " switch buffers without saving
" allow backspacing over everything in insert mode
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" The 'magic' option is on by default, but that isn't enough.
" I find 'very magic' is what I want and it makes pattern really easy to use.
" So, always insert a '\v' before the pattern to search to get 'very magic'.
" Here is a find-replace example from 'http://briancarper.net/blog/448/':
"   without magic:
"       :%s/^\%(foo\)\{1,3}\(.\+\)bar$/\1/
"   with very magic:
"       :%s/\v^%(foo){1,3}(.+)bar$/\1/
" :h /\v or :h magic
nnoremap / /\v
vnoremap / /\v

set ignorecase " always ignore since we have smartcase.
set smartcase
set incsearch
set gdefault " :%s/foo/bar/ -> :%s/foo/bar/g
set hlsearch
map <silent> <leader><CR> :noh<CR>
" <tab> is a lot easier to type than %.
nnoremap <tab> %
vnoremap <tab> %

set errorbells
set novisualbell

"set cursorline " highlight current line (make redrawing slower)
set showmatch " bracets
set matchtime=1 " 1/10 second to blink

set laststatus=2 " always show statusline

func! CurDir()
    return substitute(getcwd(), escape($HOME, '\'), "~", "")
endfunc

set laststatus=2 " always show statusline
set statusline=%<%f\ -\ %r%{CurDir()}%h\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\
            \ \ %-16.(%l/%L,%c%V%)\ \ %P
" Always set the cwd to the dir of current buffer.
" Similar to 'Link with Editor' of Package Explorer of Eclipse.
" TODO: This may make it difficult to generate tags/cscope_db.
"au BufEnter * :cd %:p:h

" Highlight unwanted spaces.
" See [http://vim.wikia.com/wiki/Highlight_unwanted_spaces]
" - highlight trailing whitespace in red
" - have this highlighting not appear whilst you are typing in insert mode
" - have the highlighting of whitespace apply when you open new buffers
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches() " for performance

" Spelling check
if has("spell")
    func! SpellOrNot()
        if &spell != 0
            set nospell
        else
            set spell
        endif
    endfunc
    set spelllang=en_us
    map <buffer> <leader>sc :call SpellOrNot()<CR>
    map <leader>sn ]s
    map <leader>sp [s
    map <leader>sa zg
    map <leader>s? z=
endif

" Using the list and listchars options:
func! ListOrNot()
    if &list
        set nolist
    else
        " TODO: :dig
        set list listchars=tab:>-,trail:-,eol:$,extends:>,precedes:<
        "        set list listchars=tab:<-,trail:-,eol:$
    endif
endfunc
map <buffer> <leader>ls :call ListOrNot()<CR>

" Using syntax space errors.
"let c_space_errors = 1
"let java_space_errors = 1

" Visual search

" from an idea by Michael Naumann
func! VisualSearch(direction) range
    let l:saved_reg = @"
    exec "normal! vgvy"
    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'b'
        exec "normal ?" . l:pattern . "^M"
    else
        exec "normal /" . l:pattern . "^M"
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
endfunc

" search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" Switch window
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Switch buffers with arrow keys
map <right> :bn<CR>
map <left>  :bp<CR>
map <up>    :bf<CR>
map <down>  :bl<CR>

"-------------------------------------------------------------------------------
" abbr.

iab xname Adam Gu
iab xmail sprinfall@gmail.com
iab xfile <c-r>=expand("%:t")<CR>

if exists("*strftime")
    " abbr. for date/time
    iab xdate <c-r>=strftime("%Y-%m-%d")<CR>
    iab xtime <c-r>=strftime("%H:%M:%S")<CR>
    " shortcut for date/time
    imap <buffer> <silent> <leader>d <c-r>=strftime("%Y %b %d %X")<CR>
endif

func! DeleteTrailingWS()
    exec "normal mz"
    " NOTE: [:%s/ \+$//] works for spaces only.
    %s/\s\+$//ge
    exec "normal `z"
endfunc

" Delete trailing white spaces on write.
au BufWrite * :call DeleteTrailingWS()
map <leader>W :call DeleteTrailingWS()<CR>

" Remove indenting on empty lines.
map <F3> :%s/\s*$//g<CR>:noh<CR>''<CR>

"-------------------------------------------------------------------------------
" Command Line

func! DeleteTillSlash()
    let g:cmd = getcmdline()
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    if g:cmd == g:cmd_edited
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    endif
    return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc

" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./

cno $q <C-\>eDeleteTillSlash()<CR>

cno $c e <C-\>eCurrentFileDir("e")<CR>

cno $tc <C-\>eCurrentFileDir("tabnew")<CR>
cno $th tabnew ~/
cno $td tabnew ~/Desktop/

"-------------------------------------------------------------------------------
" File Type Specific

autocmd FileType cpp map <buffer> <leader><space> :!g++ -S %<CR>
autocmd FileType cpp map <buffer> <leader>nb :!node-gyp configure build<CR>

autocmd FileType vim map <buffer> <leader><space> :source %<CR>
autocmd FileType lua map <buffer> <leader><space> :!lua %<CR>

autocmd FileType ruby map <buffer> <leader><space> :!ruby %<CR>

autocmd FileType python map <buffer> <leader><space> :!python %<CR>
autocmd FileType python map <buffer> <leader>t :!python -m doctest -v %<CR>
" %:r file name without extension. Help 'expand' for details.
autocmd FileType python map <buffer> <leader>u :!python -m unittest -v %:r<CR>

autocmd FileType javascript map <buffer> <leader><space> :!node %<CR>

if has('win32')
    " Run with 32-bit python.
    command! -nargs=0 Py32 :!C:/Python36-32/python.exe %

    " Please add the path of makensis.exe to PATH.
    autocmd FileType nsis map <buffer> <leader><space> :!makensis.exe %<CR>
endif

autocmd FileType rust map <buffer> <leader><space> :RustRun<CR>

