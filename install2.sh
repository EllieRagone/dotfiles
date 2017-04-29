#!/bin/sh

sudo apt-get -y install zsh git tmux vim

git clone https://www.github.com/pcragone/dotfiles ~/.dotfiles

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

ln -sf ~/.dotfiles/prompt/zlogout ~/.zlogout
ln -sf ~/.dotfiles/prompt/zpreztorc ~/.zpreztorc
ln -sf ~/.dotfiles/prompt/zprofile ~/.zprofile
ln -sf ~/.dotfiles/prompt/zshenv ~/.zshenv
ln -sf ~/.dotfiles/prompt/zshrc ~/.zshrc
ln -sf ~/.dotfiles/prompt/prompt_peter_setup ~/.zprezto/modules/prompt/functions/prompt_peter_setup

chsh -f /bin/zsh

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

\curl -sSL https://get.rvm.io | bash -s stable --ruby


git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -sf ~/.dotfiles/vimrc ~/.vimrc
vim +BundleInstall +qall


ln -sf ~/.dotfiles/aliases ~/.aliases
ln -sf ~/.dotfiles/bin ~/bin

git config --global user.name 'Peter Ragone'
git config --global user.email 'pcragone@gmail.com'
git config --global push.default simple

if [ `uname` = 'Darwin' ]
then
  git config --global credential.helper osxkeychain
fi

if [ `uname` = 'Linux' ]
then
  git config --global credential.helper store
fi

