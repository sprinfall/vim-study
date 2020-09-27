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
$ ./configure --prefix=/usr/local --with-features=huge --enable-multibyte --enable-luainterp=yes --enable-python3interp=yes --enable-xim --enable-fontset --disable-cscope --disable-largefile
```

Or (with line breaks):

```plain
$ ./configure --prefix=/usr/local \
   --with-features=huge \
   --enable-multibyte \
   --enable-luainterp=yes \
   --enable-python3interp=yes \
   --enable-xim \
   --enable-fontset \
   --disable-cscope \
   --disable-largefile
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

**2018-10-07**: 如果 Python 版本从 3.5 升级为 3.6，重新编译 Vim 时，发现指向的还是 3.5 路径（并不存在）：

```
(cached) checking Python's configuration directory... (cached) /usr/lib/python3.5/config-3.5m-x86_64-linux-gnu
(cached) checking Python3's dll name... (cached) libpython3.5m.so.1.0
```

得想办法禁用 cache，发现 `./configure` 第一行输出指明了 cache 文件位置：

```
configure: loading cache auto/config.cache
```

这个文件并不在 `configure` 文件所在的目录，而是在 `src` 目录。把它删掉，重新执行 `./configure`：

```
$ rm src/auto/config.cache
$ ./configure --prefix=/usr/local --with-features=huge --with-x --enable-multibyte --enable-luainterp=yes --enable-python3interp=yes --enable-xim --enable-fontset --disable-cscope --disable-largefile
```

就没有问题了。

**2020-09-27**: Remove `--with-x`.
