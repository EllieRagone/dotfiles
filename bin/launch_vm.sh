#!/usr/bin/env bash

if [ -d "~/projects/$1" ]; then
  echo "~/projects/$1 exists. Continue? (y/N)"
  read answer
  if [ "$answer" != "y" ]; then
    echo "Exiting..."
    exit 1
  else
    echo "Continuing."
  fi
fi

mkdir ~/projects/$1

if [ -e "~/projects/$1/Vagrantfile"]; then
  echo "Moving ~/projects/$1/Vagrantfile to ~/projects/$1/Vagrantfile.bak"
  mv ~/projects/$1/Vagrantfile ~/projects/$1/Vagrantfile.bak
fi

cp ~/lib/vm_skeleton/Vagrantfile ~/projects/$1/Vagrantfile
cd ~/projects/$1
vagrant up
