#!/bin/sh

# sudo apt-get -y install zsh git tmux vim

git clone https://www.github.com/pcragone/dotfiles ~/.dotfiles

# git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

ln -sf ~/.zlogout ~/.dotfiles/prompt/.zlogout
ln -sf ~/.zpreztorc ~/.dotfiles/prompt/zpreztorc
ln -sf ~/.zprofile ~/.dotfiles/prompt/zprofile
ln -sf ~/.zshenv ~/.dotfiles/prompt/zshenv
ln -sf ~/.zshrc ~/.dotfiles/prompt/zshrc
ln -sf ~/.zprezto/modules/prompt/functions/prompt_peter_setup ~/.dotfiles/prompt/prompt_peter_setup
#
# chsh -f /bin/zsh
#
# gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
#
# \curl -sSL https://get.rvm.io | bash -s stable --ruby


# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# ln -sf ~/.vimrc ~/.dotfiles/vimrc
# vim +BundleInstall +qall


ln -sf ~/bin ~/.dotfiles/bin
