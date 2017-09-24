#!/bin/sh

if [ `uname` = 'Darwin' ]
then
  echo 'Installing zsh, git, tmux, and vim from Homebrew'
  brew install zsh git tmux vim python3
  pip3 install powerline
fi

if [ `uname` = 'Linux' ]
then
  echo 'Installing zsh, git, tmux, and vim from apt-get'
  sudo apt-get -y install zsh git tmux vim powerline
fi

echo 'Cloning dotfiles into ~/.dotfiles'
# Get all the dotfiles
git clone https://www.github.com/pcragone/dotfiles ~/.dotfiles

echo 'Cloning zprezto into ~/.zprezto'
# ZPrezto setup
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

echo 'Cloning Vundle into ~/.vim/bundle/Vundle.vim'
# Vim Vundle setup
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo 'Symlinking files'
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
ln -sf ~/.dotfiles/ruby/gemrc ~/.gemrc
ln -sf ~/.dotfiles/tmux/tmuxinator ~/.tmuxinator
ln -sf ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

# Install powerline
echo 'Installing powerline'
# if [ `uname` = 'Darwin' ]
# then
  ln -sf ~/.dotfiles/powerline ~/.config/powerline
# fi

# Leaving commented out for now in case I need it later. Should work fine with
# the above symlink though
# if [ `uname` = 'Linux' ]
# then
#   sudo ln -sf ~/.dotfiles/powerline/colorscheme.json /usr/share/powerline/config_files/colorschemes/tmux/default.json
#   sudo ln -sf ~/.dotfiles/powerline/theme.json /usr/share/powerline/config_files/themes/tmux/default.json
# fi

echo 'Configuring git'
# Configure global git settings
git config --global user.name 'Peter Ragone'
git config --global user.email 'pcragone@gmail.com'
git config --global push.default simple

if [ `uname` = 'Darwin' ]
then
  git config --global credential.helper osxkeychain
fi

if [ `uname` = 'Darwin' ]
then
  # Install pf anchor bypasses for virtualbox (required in order to get
  # networking in virtualbox to work correctly with PrivateInternetAccess VPN running)
  sudo ln -s ~/.dotfiles/lib/vbox.pfrules /etc/pf.anchors/com.pccr
  echo "anchor \"com.pccr\"" | sudo tee -a /etc/pf.conf
  echo "load anchor \"com.pccr\" from \"/etc/pf.anchors/com.pccr\"" | sudo tee -a /etc/pf.conf
  sudo pfctl -f /etc/pf.conf
fi

if [ `uname` = 'Linux' ]
then
  git config --global credential.helper store
fi

if [ `uname` = 'Linux' ]
then
  echo 'Installing RVM'
  # Install RVM with ruby
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  \curl -sSL https://get.rvm.io | bash -s stable --ruby
fi

echo 'Installing Vim plugins'
# Install Vim plugins
vim +BundleInstall +qall

echo 'Changing shell to zsh'
# Change shell to zsh
chsh -s /bin/zsh
