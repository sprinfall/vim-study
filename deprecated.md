# 弃用或作为备份的设置

## 一般设置

### shellslash

```vim
" NOTE: (2017-02-07)
" If set shellslash, jedi-vim will be broken.
" See https://github.com/davidhalter/jedi-vim/issues/447 (commented by bimlas)
if has("win32")
    " Expand file path using / instead of \ on Windows. See expand().
    set shellslash
endif
```

### Restore Cursor Position

```vim
" Restore cursor to file position in previous editing session.
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
```
上面的方法来自 [Restore cursor to file position in previous editing session](http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session)。
已经被下面的方法替代了：
```vim
au BufWinLeave ?* mkview
au VimEnter ?* silent loadview
```
详见：https://stackoverflow.com/questions/8854371/vim-how-to-restore-the-cursors-logical-and-physical-positions

2018-04-16: 通过`View`不但可以记住游标位置，一些设置也会被记住，比如
`cursorline`，这可能并不是我想要的效果。
得搞清楚`View`具体是干嘛的。

### 括号匹配

有点花哨的功能。
```vim
set showmatch
set matchtime=1 " 1/10 second to blink
```

### Map TAB to %

在成对的括号间跳转，原本是用 `%`，下面尝试以 `tab` 键代替。
其实并没有必要，甚至还可能会影响到正常输入，比如会跟 YCM 的Tab补全相冲突。
```vim
" Tab is much easier to type than %.
nnoremap <tab> %
vnoremap <tab> %
```

### List chars

一句话，用的很少。

```vim
" List chars (tab, trailing spaces, EOL, etc.)
func! ListOrNot()
    if &list
        set nolist
    else
        " TODO: :dig
        set list listchars=tab:>-,trail:-,eol:$,extends:>,precedes:<
        " set list listchars=tab:<-,trail:-,eol:$
    endif
endfunc
map <buffer> <leader>ls :call ListOrNot()<CR>
```

### Visual Search

现在貌似已经原生支持了。
`<leader>*`：前向搜索当前游标下的单词。
`<leader>#`：后向搜索当前游标下的单词。
然后，按 `n` 或 `N` 就可以在匹配项间跳转了。

```vim
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
```

### Abbreviations

下面这种还是比较实用的：
```vim
iabbrev xdate <c-r>=strftime("%Y-%m-%d")<CR>
iabbrev xtime <c-r>=strftime("%H:%M:%S")<CR>
```
但是输入模式的这种就不太实用了（我设置了但是从来没用过）：
```vim
if exists("*strftime")
    imap <buffer> <silent> <leader>d <c-r>=strftime("%Y %b %d %X")<CR>
endif
```

### 状态栏

有了 airline 插件，不需要手动设置了。
```vim
func! CurDir()
    return substitute(getcwd(), escape($HOME, '\'), "~", "")
endfunc

" NOTE: Obsoleted by airline
set laststatus=2 " Always show status line
set statusline=%<%f\ -\ %r%{CurDir()}%h\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\
            \ \ %-16.(%l/%L,%c%V%)\ \ %P
```

### 当前目录

```vim
" Always set the CWD to the dir of current buffer.
au BufEnter * :cd %:p:h
```

### Persistent Undo

隐藏的 undo 文件，比较烦人。
```vim
" Persistent undo serializes to a file named '.<filename>.un~'.
" That's a little anoying.
if v:version >= 730
    set undofile " .
endif
```

### Folding

折叠功能，暂时还用不习惯。

```vim
set foldenable
set foldlevel=3
set foldcolumn=3
set foldmethod=indent

let g:xml_syntax_folding=1
" ISSUE: JavaScript syntax folding doesn't work event you open it by setting
" javaScript_fold.
let javaScript_fold=1

au FileType c,cpp,java,xml set foldmethod=syntax
au FileType python set foldmethod=indent
```

## Color Schemes

下面两个插件，有了基于clang的'jeaye/color_coded'，就没必要了。
```vim
Plugin 'justinmk/vim-syntax-extra'
Plugin 'octol/vim-cpp-enhanced-highlight'
```

## 语言支持

### Space Errors

TODO
```vim
" Using syntax space errors.
let c_space_errors = 1
let java_space_errors = 1
```

## YCM

YCM 自带的诊断功能，有了ALE，就不需要了。
```vim
" YcmDiags is obsoleted by ALE.
nmap <F4> :YcmDiags<CR>
```

## Rust

暂时不写Rust。
```vim
" Rust
Plugin 'rust-lang/rust.vim'
" NOTE:
" For auto-complete, YCM is prefered to vim-racer.
" Actually, I can't make vim-racer work on Windows because of the incorrect
" value of col('.').
```

### C++

```vim
autocmd FileType cpp map <buffer> <leader><space> :!g++ -S %<CR>
autocmd FileType cpp map <buffer> <leader>nb :!node-gyp configure build<CR>
```
