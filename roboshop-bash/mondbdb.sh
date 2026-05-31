#! /bin/bash

ID=$(id -u)
COMPONENT="mongodb"

if [$ID -ne 0]; then
   echo -e "Script has to be excecuted by root user"
   echo -e "Example usage: sudo $0.sh "
   exit 1
fi
 
