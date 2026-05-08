#! /bin/bash

echo "Configuration management for Frontend"

ID=$(id -u)

if [ $ID -ne 0 ]; then
   echo -e "Script has to be executed by root user"
   echo -e "Example usage: \n\t \e[33m sudo bash $0  OR # bash $0 \e[0m"
   exit 1
fi

echo "disabling nginx module"
dnf module disable nginx -y  &>> /tmp/front.log

echo "Enabling nginx"
dnf module enable nginx:1.24 -y &>> /tmp/front.log

echo "Installing Nginx"
dnf install nginx -y &>> /tmp/front.log

echo "Download the HTDOCS content and deploy it under the Nginx path"
curl -L -o /tmp/frontend.zip https://stan-robotshop.s3.amazonaws.com/frontend-v3.zip &>> /tmp/front.log

echo "Performing cleanup"
rm -rf /usr/share/nginx/html

echo "Extracting the frontend component"
unzip /tmp/frontend.zip -d /usr/share/nginx/html &>> /tmp/front.log

echo "Configuring frontend proxy file"
cp nginx.conf /etc/nginx/nginx.conf
 
echo "Starting the frontend service: "
systemctl enable nginx &>> $LOG
systemctl restart nginx &>> $LOG

echo -e "\n \t ___ Configuration Management for frontend in completed! ___"
