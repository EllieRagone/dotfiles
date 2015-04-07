#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:git-core/ppa
# sudo add-apt-repository -y ppa:fcwu-tw/ppa
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y tmux python-pip fontconfig zsh cmake python2.7-dev g++ git
# sudo apt-get install -y vim git

function run_or_exit {
  if $1; then
    if [ ! -z "$2" ]; then
      echo $2
    else
      echo "OK"
    fi
  else
    if [ ! -z "$3" ]; then
      echo $3
    fi

    echo "Exiting"
    exit 1
  fi
}

function link_file {
  filename=${1##*/}
  run_or_exit "ln -sf $DOTFILES/$1 $HOME/.$filename" "Symlinked $1 to $HOME/.$filename" "Unable to create symlink for $1"
}

run_or_exit "source ./env" "Sourced ./env" "Unable to source ./env"


# shell
# ln -sf $DOTFILES/aliases $HOME/.aliases
link_file 'aliases'
# ln -sf $DOTFILES/env $HOME/.env
link_file 'env'

# bash
# ln -sf $DOTFILES/bash_profile $HOME/.bash_profile
link_file 'bash_profile'

# zsh
# prezto - super slow; (it's supposed to be better than oh-my-zsh by being
# faster. I had the exact opposite experience)
# # ln -sf $DOTFILES/zsh/prezto/zprezto/ $HOME/.zprezto
# link_file "zsh/prezto/zprezto"
# # ln -sf $DOTFILES/zsh/prezto/zlogin $HOME/.zlogin
# link_file "zsh/prezto/zlogin"
# # ln -sf $DOTFILES/zsh/prezto/zshenv $HOME/.zshenv
# link_file "zsh/prezto/zshenv"
# # ln -sf $DOTFILES/zsh/prezto/zshrc $HOME/.zshrc
# link_file "zsh/prezto/zshrc"
# # ln -sf $DOTFILES/zsh/prezto/zpreztorc $HOME/.zpreztorc
# link_file "zsh/prezto/zpreztorc"

# oh-my-zsh
# curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
# ln -sf $DOTFILES/zsh/oh-my-zsh/pragone.zsh-theme $HOME/.oh-my-zsh/themes/pragone.zsh-theme
ln -sf $DOTFILES/zsh/oh-my-zsh/oh-my-zsh $HOME/.oh-my-zsh
ln -sf $DOTFILES/zsh/oh-my-zsh/oh-my-zsh-zshrc $HOME/.zshrc


# # git
# ln -sf $DOTFILES/git/gitconfig $HOME/.gitconfig
link_file "git/gitconfig"
# ln -sf $DOTFILES/git/gitignore $HOME/.gitignore
link_file "git/gitignore"

# # vim
# ln -sf $DOTFILES/vimrc $HOME/.vimrc
link_file "vimrc"
# ln -sf $DOTFILES/vim/ $HOME/.vim
link_file "vim"
# mkdir -p $HOME/.vimundo # the directory for undo files.

# tmux
# ln -sf $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf
link_file "tmux/tmux.conf"
# ln -sf $DOTFILES/tmux/tmux-powerlinerc $HOME/.tmux-powerlinerc
link_file "tmux/tmux-powerlinerc"
# ln -sf $DOTFILES/tmux/tmuxinator $HOME/.tmuxinator
link_file "tmux/tmuxinator"

# ruby
# ln -sf $DOTFILES/ruby/gemrc $HOME/.gemrc
link_file "ruby/gemrc"

# bin/
# ln -sf $DOTFILES/bin/ $HOME/bin
link_file "bin"

# battery status
if [ $PLATFORM = "osx" ]; then
  link_file "battery"
fi

# lib/
ln -sf $DOTFILES/lib $HOME/lib

# # Install Vundle
run_or_exit "git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim"
# # Install Vim plugins:
run_or_exit "vim +PluginInstall +qall"

# Compile YouCompleteMe
cd $HOME/.vim/bundle/YouCompleteMe
./install.sh
cd $DOTFILES

sudo pip install powerline-status
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir $HOME/.fonts
mv PowerlineSymbols.otf $HOME/.fonts/
fc-cache -vf $HOME/.fonts/
mkdir -p $HOME/.config/fontconfig/conf.d/
mv 10-powerline-symbols.conf $HOME/.config/fontconfig/conf.d/

echo "source \"$POWERLINE_ROOT/powerline/bindings/tmux/powerline.conf\"" >> $HOME/.tmux.conf

chsh -s /bin/zsh
