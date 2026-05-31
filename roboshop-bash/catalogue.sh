#! /bin/bash

COMPONENT="catalogue"
ID=$(id -u)
LOG="/tmp/catalogue.log"

if [ $ID -ne 0 ]; then
   echo -e "Script has to be excecuted by root user"
   echo -e "Example usage: sudo $0"
   exit 1
fi

stat() {
    if [ $1 -eq 0 ]; then
      echo -e "\e[35m Success \e[0m"
    else
      echo -e "\e[36m Failure \e[0m"
      exit 2
    fi
}


echo 