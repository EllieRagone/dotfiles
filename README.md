```
\curl -sSL https://raw.githubusercontent.com/pcragone/dotfiles/master/install2.sh | bash
```

# Install

### Powerline:
#### Linux
- `sudo apt-get install -y python-pip fontconfig`
- `sudo pip install powerline-status`
- `wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf`
- `wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf`
- `mkdir ~/.fonts`
- `mv PowerlineSymbols.otf ~/.fonts/`
- `fc-cache -vf ~/.fonts/`
- `mkdir -p ~/.config/fontconfig/conf.d/`
- `mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/`

# Components


## Git
- gitignore
- gitconfig

## OS X
- OS X for hackers

## RVM/Ruby
- gemrc

## Tmux
- tmuxrc
- tmux-powerlinerc

## Vim
  - vimrc
  - vundle
  
## Zsh
  - Prezto
  - aliases
  - bash_profile
  - env
  - zpreztorc
  - zshrc
  - zlogin
  - zshenv?

  #### Config File Order:

*The configuration files are read in the following order:
*
  
  1. /etc/zshenv
  2. ~/.zshenv
  3. /etc/zprofile
  4. ~/.zprofile
  5. /etc/zshrc
  6. ~/.zshrc
  7. ~/.zpreztorc
  8. /etc/zlogin
  9. ~/.zlogin
  10. ~/.zlogout
  11. /etc/zlogout
