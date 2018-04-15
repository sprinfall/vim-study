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

### 括号匹配

有点花哨的功能。
```vim
set showmatch
set matchtime=1 " 1/10 second to blink
```

### 状态栏

有了 airline 插件，不需要手动设置了。
```vim
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

### View

没搞清楚是干嘛的。
```vim
" Automatically save and restore views for files.
" NOTE: Using * instead of ?* causes error.
"au BufWinLeave ?* mkview
"au BufWinEnter ?* silent loadview
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
