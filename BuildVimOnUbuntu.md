# Build Vim On Ubuntu
For **Ubuntu** and any Ubuntu based distributions.

Firstly, remove any Vim packages (including `vim-common`, `vim-data`, etc.) from your system.

Get Vim source code from [GitHub](https://github.com/vim/vim):

```plain
$ git clone https://github.com/vim/vim.git
```

Install dependencies (*suppose you have already installed build essentials*):
```plain
$ sudo apt install libncurses5-dev lua5.3 liblua5.3-dev libxpm-dev libx11-dev libpython3-dev
```
You can see that only **Lua** and **Python3** are supported. Personally, even **Lua** is not necessary. But just keep it since it's very lightweight.

Configure:
```plain
$ ./configure --prefix=/usr/local --with-features=huge --with-x --enable-multibyte --enable-luainterp=yes --enable-python3interp=yes --enable-xim --enable-fontset --disable-cscope --disable-largefile
```
These configure options should be sufficient for most use cases.

Build:
```plain
$ make -j4
```

If everything is OK, install with:
```plain
$ sudo make install
```
