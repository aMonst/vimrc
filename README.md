# vimrc
自己的vim环境配置

## 使用
1. 克隆项目
2. 拷贝项目中的.vimrc 文件到用户home目录下
```
cd vimrc
cp .vimrc ~/
```
3. 安装 bundle
```
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
4. 进入vim执行 `:PluginInstall` 下载对应插件
5. 编译Ycm
```
cd ~/.vim/bundle/YouCompleteMe
python install.py --all
```
