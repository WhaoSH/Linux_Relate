"auto syntax highlight
syntax on filetype on

"Location of windows
winpos 0	0

"Setup windows size
set lines=150	columns=80

"show the line number
set nu

"setup guifont
set guifont=Monospace\ 15

"setup encoding
set fileencoding=utf-8
set encoding=utf-8

"setup background
colo torte

"highlight current line
autocmd InsertLeave * se nocul
autocmd InsertEnter * se cul

set ruler

"show the input command
set showcmd
set cmdheight=1

"setupstatus line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

set nocompatible

"show the Chinese help doc
if version >= 603
	set helplang=cn
	set encoding=utf-8
endif

"auto insert file header for new C/CPP file
autocmd BufNewFile *.cpp,*.[ch],*.py,*.sh,java exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
    "如果文件类型为.sh文件 
    if &filetype == 'sh' 
        call setline(1,"\#########################################################################") 
        call append(line("."), "\# File Name: ".expand("%")) 
        call append(line(".")+1, "\# Author: Whao") 
        call append(line(".")+2, "\# Description: ") 
        call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
        call append(line(".")+4, "\#########################################################################") 
        call append(line(".")+5, "\#!/bin/bash") 
        call append(line(".")+6, "") 
    else 
        call setline(1, "/*************************************************************************") 
        call append(line("."), "    > File Name: ".expand("%")) 
        call append(line(".")+1, "    > Author: Whao") 
        call append(line(".")+2, "    > Description: ") 
        call append(line(".")+3, "    > Created Time: ".strftime("%c")) 
        call append(line(".")+4, " ************************************************************************/") 
        call append(line(".")+5, "")
    endif
    if &filetype == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc

"auto load when file been modified
set autoread

"hide tool bar & menu bar
set guioptions-=T
set guioptions-=m

"need confirm when handle read only file
set confirm

" 自动缩进
set autoindent
set cindent
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 不要用空格代替制表符
set noexpandtab
" 在行和段开始处使用制表符
set smarttab

"setup history number
set history=1000

"ignore Case when search
set ignorecase

"highlight search
set hlsearch
set incsearch

"press Space to tur off highlight and clear any message dispalyed
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

 " 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-

 " 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key

" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\

"highlight matched bracket
set showmatch

"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!java %<"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc

"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc

"python 按F6编译运
map <F6> :w<cr>:!python %<cr>
