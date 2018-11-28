#!/bin/bash

if [ "$1" == "ln" ] ; then 
  # Link to this from ~/.bash_profile
  ln -s ~/dotfiles/bash_profile ~/.bash_profile
fi

source ~/dotfiles/bash_extras.sh
