
if [[ `uname` == 'Darwin' ]] ; then
  if [[ -a ~/.bin ]] ; then
    read "proceed?~/.bin exists. Overwite? [nY] "
    if [[ "$proceed" =~ ^[Yy]$  ]]
    then
      ln -s bin ~/.bin
    fi
  else
    ln -s bin ~/.bin
  fi
fi

