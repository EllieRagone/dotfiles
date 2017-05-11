#!/bin/zsh

action=$1

case "$action" in
  boot)
    VBoxManage startvm $1 --type headless
    ;;
  save)
    VBoxManage controlvm $1 savestate
    ;;
  status)
    if [[ -z $2 ]]
    then
      IFS=$'\n'
      for line in $(VBoxManage list vms | sed 's/"\([A-Za-z0-9 ]*\)".*/\1/g')
      do
        echo $line "\t" $(vm status "$line")
      done
      unset IFS
    else
      VBoxManage showvminfo $1 | grep "State" | sed 's/State: *\(.*\) (since.*/\1/'
    fi
    ;;
  list)
    VBoxManage list vms
    ;;
  *)
    echo "Usage: $0 {boot|save|status|list} [machine]"
    exit 1
    ;;
esac
