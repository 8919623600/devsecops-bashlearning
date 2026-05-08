#! /bin/bash

echo "Configuration management for Frontend"

ID=$(id -u)

if [ $ID -ne 0 ]; then
   echo -e "Script has to be executed by root user"
   echo -e "Example usage: \n\t \e[33m sudo bash $0  OR # bash $0 \e[0m"
   exit 1
fi

stat() {
    if [ $1 -eq 0 ]; then
      echo "Success"
    else
      echo "failure"
      exit 2
    fi
}

echo "disabling nginx module" 
dnf module disable nginx -y  &>> /tmp/front.log
stat $?


echo -n "Enabling nginx"
dnf module enable nginx:1.24 -y &>> /tmp/front.log
stat $?

echo -n "Installing Nginx"
dnf install nginx -y &>> /tmp/front.log
stat $?

echo -n "Download the HTDOCS content and deploy it under the Nginx path"
curl -L -o /tmp/frontend.zip https://stan-robotshop.s3.amazonaws.com/frontend-v3.zip &>> /tmp/front.log
stat $?

echo -n "Performing cleanup"
rm -rf /usr/share/nginx/html
stat $?

echo -n "Extracting the frontend component"
unzip /tmp/frontend.zip -d /usr/share/nginx/html &>> /tmp/front.log
stat $?

echo -n "Configuring frontend proxy file"
cp nginx.conf /etc/nginx/nginx.conf
 stat $?

echo -n "Starting the frontend service: "
systemctl enable nginx &>> /tmp/front.log
systemctl restart nginx &>> /tmp/front.log
stat $?

echo -e "\n \t ___ Configuration Management for frontend in completed! ___"
