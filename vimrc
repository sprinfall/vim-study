"-------------------------------------------------------------------------------
" Basic Settings

function! Min(num1, num2)
    return a:num1 < a:num2 ? a:num1 : a:num2
endfunction


let mapleader = ","
let g:mapleader = ","

set nocompatible

set nobackup
set nowritebackup
set noswapfile

nmap <leader>w :w!<CR>

" Remove the Windows ^M
noremap <leader>m :%s/<C-V><C-M>//ge<CR>

" Automatically save and restore views for files.
" Only for restoring cursor position.
set viewoptions=cursor
autocmd BufWinLeave ?* mkview
autocmd VimEnter ?* silent loadview

" Display dynamic information in tooltip based on where the mouse is pointing.
if has("balloon_eval")
    set ballooneval
endif

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

if has("win32")
    set fileformats=dos,unix,mac
else
    set fileformats=unix,mac,dos
endif

" For multi-byte characters, e.g., Chinese.
set formatoptions+=mM

"-------------------------------------------------------------------------------
" Plug

" if empty(glob('~/.vim/autoload/plug.vim'))
"   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

let g:enable_ycm = 1

if has("win32")
    " I don't use YCM (for C++) on Windows.
    let g:enable_ycm = 0

    call plug#begin('~/vimfiles/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

" Color schemes
Plug 'morhetz/gruvbox'
" Plug 'ayu-theme/ayu-vim'
" Plug 'drewtempelmeyer/palenight.vim'  " Based on OneDark, almost the same.
" Plug 'joshdick/onedark.vim'

Plug 'vim-airline/vim-airline'
" NOTE: Airline has been supported by 'gruvbox' color scheme.
" Plug 'vim-airline/vim-airline-themes'

Plug 'Yggdroot/indentLine'
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 0
let g:indentLine_char = '|'

Plug 'terryma/vim-multiple-cursors'

" Async fuzzy finder
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

Plug 'dyng/ctrlsf.vim'

Plug 'godlygeek/tabular'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
nmap <F2> :NERDTreeToggle<CR>

Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

Plug 'tomtom/tcomment_vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" Auto-complete brackets.
Plug 'Raimondi/delimitMate'
" For Python docstring.
autocmd FileType python let b:delimitMate_nesting_quotes = ['"']

" Auto-close html/xml tags.
Plug 'docunext/closetag.vim'
let g:closetag_html_style=1

" Supertab is obsoleted by YCM.
if !g:enable_ycm
    Plug 'ervandew/supertab'
endif

" C++ enhanced highlighting
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }

" Python enhanced highlighting
Plug 'hdima/python-syntax', { 'for': 'python' }
let python_highlight_all = 1

" Markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
set conceallevel=0

" Distraction-free writing.
" Plug 'junegunn/goyo.vim'

Plug 'vim-scripts/a.vim'

" Clang-format
Plug 'rhysd/vim-clang-format', { 'for': 'cpp' }
" Format the current line
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :.ClangFormat<CR>
" Format the selected
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" Async Lint Engine
Plug 'w0rp/ale', { 'for': 'cpp,python' }

" NOTE: Rename file cpplint.py to cpplint if add 'cpplint' linter.
" NOTE: Don't use 'clang' because it cannot read compile_commands.json for the
" correct compiler flags.
let g:ale_linters = {
\   'cpp': ['clangcheck', 'cpplint'],
\   'python': ['autopep8', 'mypy', 'flake8'],
\}

let g:ale_sign_column_always = 1
let g:ale_set_highlights = 1

" Don't lint on enter for loading performance.
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'always'

" Change the format of echo messages.
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

nmap <leader>k <Plug>(ale_previous_wrap)
nmap <leader>j <Plug>(ale_next_wrap)

" https://stackoverflow.com/a/23762720
autocmd FileType python setlocal formatprg=autopep8\ -

" Auto-completion plugin for Python based on jedi.
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
let g:jedi#completions_command = "<C-N>"

if g:enable_ycm
    Plug 'Valloric/YouCompleteMe'
    " Disable YCM's diagnostic since we have ALE.
    let g:ycm_show_diagnostics_ui = 0
    let g:ycm_key_invoke_completion = '<C-N>'
    let g:ycm_seed_identifiers_with_syntax = 1
    let g:ycm_add_preview_to_completeopt = 1
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_autoclose_preview_window_after_insertion = 1
    " Only map GoTo since it's very 'smart'.
    nnoremap <leader>d :YcmCompleter GoTo<CR>
    " GotoImprecise is faster.
    nnoremap <leader>g :YcmCompleter GoToImprecise<CR>
endif

Plug 'vhdirk/vim-cmake', { 'for': 'cmake' }

" Disabled because it hugely slows down the file loading on large Git
" repositories. (2018-09-26)
" Plug 'airblade/vim-gitgutter'

call plug#end()

" &ft is empty for csv files, set as text.
autocmd BufRead,BufNewFile *.csv setfiletype text

set completeopt=menu,preview

" Source .vimrc if present in working dir.
set exrc
set secure

"-------------------------------------------------------------------------------
" Color Scheme

set background=dark
colorscheme gruvbox

"-------------------------------------------------------------------------------
" Format (indent, tabs, wrap, etc.)

" Will be overruled by 'indentexpr' if it's not empty.
" You can also try smartindent, autoindent.
set cindent

" t0: no indent for function return type declaration
" g1: indent 1 character for C++ scope declarations ('public:', etc.)
" h1: indent 1 character for statements occurring after C++ scope declarations
" N-s: no indent inside C++ namespace
" (0: align multi-line parameters.
" j1: properly indent lambda.
set cinoptions=t0,g1,h1,N-s,(0,j1

set smarttab

" After expand tab, type "C-v tab" to get the unexpanded tab.
" See also :retab.
set expandtab | set tabstop=4 | set shiftwidth=4  " Python, CSS, etc.
autocmd FileType c,cpp,html,htmldjango,lua,javascript,nsis
    \ set expandtab | set tabstop=2 | set shiftwidth=2
autocmd FileType make set noexpandtab | set tabstop=8 | set shiftwidth=8

" Maximum width of text that is being inserted.
" This width also controls 'gq' commands to format lines.
autocmd FileType c,cpp,python,vim set textwidth=80

" Highlight columns.
" Multiple values are allowed, e.g., '81,101'.
" NOTE: Don't use relative number because 'textwidth' could be 0.
set colorcolumn=81
highlight ColorColumn ctermbg=darkgray

autocmd FileType text,markdown,html,xml set wrap

" Break line by word (when wrap is on).
set linebreak
" Indent the breaked lines.
set breakindent

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

set ignorecase
set smartcase " No ignore case if any upper case letter

set incsearch

set hlsearch
map <silent> <leader><CR> :nohlsearch<CR>

set gdefault " :%s/foo/bar/ -> :%s/foo/bar/g

" Always insert a '\v' before the pattern to search to get 'very magic'.
" :h /\v or :h magic
" TODO: Remove since I rarely use regex.
" nnoremap / /\v
" vnoremap / /\v

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
autocmd BufWrite * :call DeleteTrailingWS()
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
