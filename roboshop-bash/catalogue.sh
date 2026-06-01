#! /bin/bash

COMPONENT="catalogue"
ID=$(id -u)
LOG="/tmp/catalogue.log"
USERAPP="roboshop"

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
dnf module disable nodejs -y    &>> $LOG
stat $?

echo -n "Enabling nodejs version 20: "
dnf module enable nodejs:20 -y  &>> $LOG
stat $?

echo -n "installing nodejs: "
dnf install nodejs -y &>> $LOG
stat $?

echo -n "Adding $USERAPP user account: "
useradd $USERAPP || true  &>> $LOG
stat $?

echo -n "performing cleanup of $COMPONENT: "
rm -rf /app || true &>> $LOG
stat $?

echo -n "Creating app directory"
mkdir /app
stat $?

echo -n "Downloading the $COMPONENT app: "
curl -o /tmp/$COMPONENT.zip https://stan-robotshop.s3.amazonaws.com/${COMPONENT}-v3.zip  &>> $LOG
stat $?

echo -n "Extracting the $COMPONENT app: "
unzip -o /tmp/${COMPONENT}.zip -d /app/   &>> $LOG
stat $?

echo -n "Generating $COMPONENT Artifact: "
cd /app
npm install  &>> $LOG
stat $?

echo -n "Copying $COMPONENT service file to systemd: "
cp catalogue.service /etc/systemd/system/${COMPONENT}.service &>> $LOG
stat $?

systemctl daemon-reload
systemctl start $COMPONENT
systemctl enable $COMPONENT
systemctl status $COMPONENT -l