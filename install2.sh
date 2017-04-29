#!/bin/sh

sudo apt-get -y install zsh git tmux vim

# Get all the dotfiles
git clone https://www.github.com/pcragone/dotfiles ~/.dotfiles

# ZPrezto setup
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Vim Vundle setup
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Symlink files
ln -sf ~/.dotfiles/prompt/zlogout ~/.zlogout
ln -sf ~/.dotfiles/prompt/zpreztorc ~/.zpreztorc
ln -sf ~/.dotfiles/prompt/zprofile ~/.zprofile
ln -sf ~/.dotfiles/prompt/zshenv ~/.zshenv
ln -sf ~/.dotfiles/prompt/zshrc ~/.zshrc
ln -sf ~/.dotfiles/prompt/prompt_peter_setup ~/.zprezto/modules/prompt/functions/prompt_peter_setup
ln -sf ~/.dotfiles/vimrc ~/.vimrc
ln -sf ~/.dotfiles/aliases ~/.aliases
ln -sf ~/.dotfiles/bin ~/bin

# Configure global git settings
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


# Install RVM with ruby
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby

# Install Vim plugins
vim +BundleInstall +qall

# Change shell to zsh
chsh -s /bin/zsh
