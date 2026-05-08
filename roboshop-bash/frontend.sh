#! /bin/bash

ID=$(id -u)
LOG="/tmp/frontend.log"
COMPONENT="frontend"

echo -e "\e[33m Configuration management for $COMPONENT \e[0m"

if [ $ID -ne 0 ]; then
   echo -e "Script has to be executed by root user"
   echo -e "Example usage: \n\t \e[33m sudo bash $0  OR # bash $0 \e[0m"
   exit 1
fi

stat() {
    if [ $1 -eq 0 ]; then
      echo -e "\e[35m Success \e[0m"
    else
      echo "\e[36m Failure \e[0m"
      exit 2
    fi
}

echo -n "Disabling nginx module: " 
dnf module disable nginx -y  &>> $LOG
stat $?


echo -n "Enabling nginx: "
dnf module enable nginx:1.24 -y &>> $LOG
stat $?

echo -n "Installing Nginx: "
dnf install nginx -y &>> $LOG
stat $?

echo -n "Download the HTDOCS content and deploy it under the Nginx path: "
curl -L -o /tmp/$COMPONENT.zip https://stan-robotshop.s3.amazonaws.com/$COMPONENT-v3.zip &>> $LOG
stat $?

echo -n "Performing cleanup: "
rm -rf /usr/share/nginx/html
stat $?

echo -n "Extracting the $COMPONENT component: "
unzip /tmp/$COMPONENT.zip -d /usr/share/nginx/html &>> $LOG
stat $?

echo -n "Configuring $COMPONENT proxy file: "
cp nginx.conf /etc/nginx/nginx.conf
 stat $?

echo -n "Starting the $COMPONENT service: "
systemctl enable nginx &>> $LOG
systemctl restart nginx &>> $LOG
stat $?

echo -e "\n \t ___ Configuration Management for $COMPONENT in completed! ___"
