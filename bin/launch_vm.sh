#!/usr/bin/env bash

project_name=$1
if [[ $# -eq 0  ]] ; then
  echo "Project name: "
  read project_name
fi

if [ -d "$HOME/projects/$project_name" ]; then
  echo "$HOME/projects/$project_name exists. Continue? (y/N)"
  read answer
  if [ "$answer" != "y" ]; then
    echo "Exiting..."
    exit 1
  else
    echo "Continuing."
  fi
else
  mkdir $HOME/projects/$project_name
fi

if [ -e "$HOME/projects/$project_name/Vagrantfile" ]; then
  echo "Moving $HOME/projects/$project_name/Vagrantfile to $HOME/projects/$project_name/Vagrantfile.bak"
  mv $HOME/projects/$project_name/Vagrantfile $HOME/projects/$project_name/Vagrantfile.bak
fi

cp $HOME/lib/vm-skeleton/Vagrantfile $HOME/projects/$project_name/Vagrantfile
cp $HOME/lib/vm-skeleton/Cheffile $HOME/projects/$project_name/Cheffile
cd $HOME/projects/$project_name
vagrant up

echo "Finding port..."
action_set_name=`cat .vagrant/machines/default/virtualbox/action_set_name`
port=`sed 's/00:00:00.237903 NAT: set redirect TCP host port \([0-9][0-9][0-9][0-9]\) =>.*$/\1/' /Users/pragone/VirtualBox\ VMs/*$log_id*/Logs/VBox.log | grep '^3' $HOME/VirtualBox\ VMs/*$action_set_name*/Logs/VBox.log`
echo $port > $HOME/.pow/$project_name
echo "Linked virtual machine to $project_name.dev"
