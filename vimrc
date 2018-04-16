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
        set guifont=Source\ Code\ Pro\ 13
    elseif has("gui_macvim")
        " TODO Verify
        set guifont=Andale\ Mono:h13,Courier\ New:h13
    elseif has("gui_win32")
        set guifont=DejaVu_Sans_Mono:h11:cDEFAULT,Courier_New:h11:cDEFAULT
        " Need to download 'GB18030 Support Package' from MS.com for
        " SimSun-18030.
        " Make sure 'encoding' is "utf-8" and "guifontset" is empty or invalid.
        " (except GTK+ 2)
        "set guifontwide=SimSun-18030,Arial_Unicode_MS

        set guioptions-=m  " No menu
    endif

    " Prefer console style UI.
    set guioptions-=e  " Use console style tab
    set guioptions-=T  " No toolbar
endif

" For Chinese
set formatoptions+=mM

let mapleader = ","
let g:mapleader = ","

" &ft is empty for csv files, set to text.
au BufRead,BufNewFile *.csv setfiletype text

"-------------------------------------------------------------------------------
" Vundle

let enable_ycm = 1

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-scripts/a.vim'
Plugin 'godlygeek/tabular'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'hrp/EnhancedCommentify'

Plugin 'vim-airline/vim-airline'
" NOTE: Airline has been supported by 'gruvbox' color scheme.
" Plugin 'vim-airline/vim-airline-themes'

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
let g:vim_markdown_conceal = 0
set conceallevel=0

" C++
Plugin 'jeaye/color_coded'

" Python
Plugin 'hdima/python-syntax'
let python_highlight_all = 1

" Auto-completion plugin for Python based on jedi.
" Please install jedi with pip.
Plugin 'davidhalter/jedi-vim'

" Auto-close html/xml tags.
Plugin 'docunext/closetag.vim'
let g:closetag_html_style=1

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
Plugin 'morhetz/gruvbox'
" Atom OneDark theme.
Plugin 'joshdick/onedark.vim'
" Plugin 'drewtempelmeyer/palenight.vim'
" Plugin 'ayu-theme/ayu-vim'

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

if enable_ycm != 0
    " Only map GoTo since it's very 'smart'.
    " GotoImprecise is faster.
    nnoremap <leader>g :YcmCompleter GoToImprecise<CR>
    nnoremap <leader>d :YcmCompleter GoTo<CR>
endif

"-------------------------------------------------------------------------------
" General

set background=dark
syntax enable
colorscheme gruvbox
au BufEnter * :syntax sync fromstart

set nocompatible
set history=400

set nobackup
set nowritebackup
set noswapfile

nmap <leader>w :w!<CR>
nmap <leader>f :find<CR>

if has("win32")
    set ffs=dos,unix,mac
else
    set ffs=unix,mac,dos
endif

" Remove the Windows ^M
noremap <leader>m :%s/<C-V><C-M>//ge<CR>

" Automatically save and restore views for files.
" This can restore cursor positions.
" NOTE: Using * instead of ?* causes error.
au BufWinLeave ?* mkview
au VimEnter ?* silent loadview

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
" TODO: Add j1 for properly indenting lambda (jN was new since 7.4).
set cinoptions=t0,g0,:0

" NOTE: After expand tab, type "C-v tab" to get the unexpanded tab.
" If you have a file that contains tabs then you can convert them to spaces by
" typing :retab.
" :retab replaces a tab with &tabstop/ts number of spaces.
" For tabstop: default 8. Better not to change it.

"set smarttab

" TODO
" For c, cfg, cmake, go, python, sql, vim, etc.
set expandtab | set ts=4 | set sw=4
au FileType cpp,html,lua,javascript,nsis,objc,ruby set expandtab | set ts=2 | set sw=2
au FileType htmldjango set expandtab | set ts=2 | set sw=2
au FileType make set noexpandtab | set ts=8 | set sw=8

" Useful for formating comments.
set textwidth=80

" Highlight column after 'textwidth'
set colorcolumn=+1,+20

" linebreak makes sense only when wrap is on & list is off (nolist).
set linebreak
set breakindent

set nowrap
au FileType ant,html,markdown,xml,text set wrap

"-------------------------------------------------------------------------------
" User Interface

" Enable mouse even for terminals.
if has("mouse") | set mouse=a | endif

set showcmd
set scrolloff=7
set wildmenu
set wildmode="list:longest"
set ruler
set cmdheight=2

" You may also want to try 'relativenumber'.
set number

set lazyredraw
set hidden " Switch buffers without saving
" Allow backspacing over everything in insert mode
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

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

" Highlight current line.
" set cursorline

"-------------------------------------------------------------------------------
" Search

set ignorecase " Always ignore since we have smartcase.
set smartcase
set incsearch
set gdefault " :%s/foo/bar/ -> :%s/foo/bar/g
set hlsearch
map <silent> <leader><CR> :noh<CR>

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

set errorbells
set novisualbell

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

" Switch windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Switch buffers with arrow keys
map <right> :bn<CR>
map <left>  :bp<CR>
map <up>    :bf<CR>
map <down>  :bl<CR>

" Abbreviations
iabbrev xname Adam Gu
iabbrev xmail sprinfall@gmail.com
iabbrev xfile <c-r>=expand("%:t")<CR>
if exists("*strftime")
    iabbrev xdate <c-r>=strftime("%Y-%m-%d")<CR>
    iabbrev xtime <c-r>=strftime("%H:%M:%S")<CR>
endif

" Delete trailing white spaces.
func! DeleteTrailingWS()
    exec "normal mz"
    " NOTE: [:%s/ \+$//] works for spaces only.
    %s/\s\+$//ge
    exec "normal `z"
endfunc
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

" Smart mappings on the command line.
" Never used any of them :)
cnoremap $h e ~/
cnoremap $d e ~/Desktop/
cnoremap $j e ./

cnoremap $q <C-\>eDeleteTillSlash()<CR>

cnoremap $c e <C-\>eCurrentFileDir("e")<CR>

cnoremap $tc <C-\>eCurrentFileDir("tabnew")<CR>
cnoremap $th tabnew ~/
cnoremap $td tabnew ~/Desktop/

"-------------------------------------------------------------------------------
" Run (TODO: Consider to use make)

autocmd FileType cpp map <buffer> <leader><space> :!g++ -S %<CR>

autocmd FileType vim map <buffer> <leader><space> :source %<CR>

autocmd FileType lua map <buffer> <leader><space> :!lua %<CR>

autocmd FileType python map <buffer> <leader><space> :!python %<CR>
autocmd FileType python map <buffer> <leader>t :!python -m doctest -v %<CR>
" %:r file name without extension. Help 'expand' for details.
autocmd FileType python map <buffer> <leader>u :!python -m unittest -v %:r<CR>

autocmd FileType javascript map <buffer> <leader><space> :!node %<CR>

autocmd FileType rust map <buffer> <leader><space> :RustRun<CR>

if has('win32')
    " Please add the path of makensis.exe to PATH.
    autocmd FileType nsis map <buffer> <leader><space> :!makensis.exe %<CR>
endif
