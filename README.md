dotfiles
========
everyone else is doing it?

managing dotfiles in linux
=================
use stow

setting the caps lock to ctrl in linux
======================================
add this line to /etc/default/keyboard
XKBOPTIONS"ctrl:nocaps"

installing vim config files on linux
===================================
git clone https://github.com/gmarik/Vundle.vim to
dotfiles/vim/.vim/bundle/vundle

installing vim config files on windows
======================================
put a symbolic link from %USERPROFILE%\vimfiles\ to dotfiles\vim\.vim
 
