#! /bin/bash

ID=$(id -u)
COMPONENT="mongodb"
LOG="/tmp/mongodb.log"

if [ $ID -ne 0 ]; then
   echo -e "Script has to be excecuted by root user"
   echo -e "Example usage: sudo $0"
   exit 1
fi

stat () {
   if [ $1 -eq 0 ]; then
      echo -e "\e[35m Success \e[0m"
   else
      echo -e "\e[35m Failure \e[0m"
      exit 2
   fi
}

echo -n "copying mongo.repo file to yum.repos.d: "
cp mongo.repo /etc/yum.repos.d/mongo.repo
stat $?

echo -n "Installing MongoDB: "
dnf install mongodb-org -y  &>> $LOG
stat $?

echo -n "Enabling MongoDB service: "
systemctl enable mongod
stat $?

echo -n "Starting MongoDB service: "
systemctl start mongod
stat $?


 
