#! /bin/bash

dnf module list
dnf module disable redis -y
dnf module enable redis:7 -y
dnf install redis -y

# sed -ie 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
sed -ie 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf

sed -ie 's/^protected-mode yes/protected-mode no/' /etc/redis/redis.conf

systemctl enable redis
systemctl start redis
systemctl status redis -l