set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
"在此处添加要安装的插件
Plugin 'VundleVim/Vundle.vim'
Plugin 'tmhedberg/SimpylFold' "代码折叠
Plugin 'vim-scripts/indentpython.vim' "代码缩进
Plugin 'Valloric/YouCompleteMe' "python自动补全
Plugin 'scrooloose/syntastic' "语法检查
Plugin 'nvie/vim-flake8' "让缩进符合PEP8规范
"配色方案
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree' "文件树形结构
Plugin 'jistr/vim-nerdtree-tabs' "使用tab键
Plugin 'kien/ctrlp.vim' "文件搜索
Plugin 'tpope/vim-fugitive' "添加git支持
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'} "状态栏
call vundle#end()

filetype plugin indent on

"分割布局的区域
set splitbelow
set splitright
"设置在各个区域间切换的快捷键
nnoremap <C-J> <C-W><C-J> "下
nnoremap <C-K> <C-W><C-K> "上
nnoremap <C-L> <C-W><C-L> "右
nnoremap <C-H> <C-W><C-H> "左

"代码折叠
set foldmethod=indent
set foldlevel=99
let g:SimpylFold_docstring_preview=1
"设置代码折叠的快捷键为空格
nnoremap <space> za
"代码缩进
au BufNewFile,BufRead *.py
\ set tabstop=4 |
\ set softtabstop=4 |
\ set shiftwidth=4 |
\ set textwidth=79 |
\ set expandtab |
\ set autoindent |
\ set fileformat=unix |

"设置其他语言的格式
au BufNewFile,BufRead *.js, *.html, *.css
\ set tabstop=2 |
\ set softtabstop=2 |
\ set shiftwidth=2 |

"设置多余空格显示红色
hi BadWhitespace guifg=gray guibg=red ctermfg=gray ctermbg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
set encoding=utf-8 "设置编码格式为utf-8
let g:ycm_autoclose_preview_window_after_completion=1 "保留代码补全窗口
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR> "定义转到定义的快捷键

"保证vim能找到virtualenv中的虚拟环境
python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    exec(compile(open(activate_this).read(), activate_this, 'exec'), dict(__file__=activate_this))
EOF
"设置语法高亮
let python_highlight_all=1
syntax on
"不同环境启用不同配色方案
if has('gui_running')
    set background=dark
    colorscheme solarized
else
    colorscheme zenburn
endif
"设置F2开启目录树
map <F2> :NERDTreeToggle<CR>
"切换配色方案主题----F3
call togglebg#map("<F3>")
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree "隐藏pyc文件
set nu "开启行号
set clipboard=unnamed "设置剪切板

"设置代码补全配置文件
let g:ycm_server_python_interpreter='/usr/bin/python2' "设置对应python程序路径
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
	exec "!go build %<"
	exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunc
