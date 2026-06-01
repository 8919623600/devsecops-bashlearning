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


echo -n "Disabling older version of nodejs: "
dnf module disable nodejs -y  
stat $?

echo -n "Enabling nodejs version 20: "
dnf module enable nodejs:20 -y 
stat $?

echo -n "installing nodejs: "
dnf install nodejs -y
stat $?

echo -n "Adding roboshop user: "
useradd roboshop
stat $?

mkdir /app
curl -o /tmp/catalogue.zip https://stan-robotshop.s3.amazonaws.com/catalogue-v3.zip 
cd /app 
unzip /tmp/catalogue.zip

