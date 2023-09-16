#!/bin/bash

cd Atom-Vagrant/
vagrant status --machine-readable | grep state,running
if [[ $? -gt 0 ]]
then
  echo -e "\e[1;33m 
Está desligada e será LIGADA.
  \e[0m "  
  vagrant up
else
  echo -e "\e[1;33m 
Está ligada e será DESLIGADA.
  \e[0m "
  vagrant halt
fi
