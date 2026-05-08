#! /bin/bash

echo "Configuration management for Frontend"

ID=$(id -u)

if [ $ID -ne 0 ]; then
   echo "Script has to be executed by root user"
   echo "Example usage: \n\t \e[33m sudo bash $0  OR # bash $0 \e[0m"
   
fi



echo "disabling nginx module"
dnf module disable nginx -y

echo "Enabling nginx"
dnf module enable nginx:1.24 -y

echo "Installing Nginx"
dnf install nginx -y
