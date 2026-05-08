#! /bin/bash

echo "Configuration management for Frontend"

echo "disabling nginx module"
dnf module disable nginx -y

echo "Enabling nginx"
dnf module enable nginx:1.24 -y

echo "Installing Nginx"
dnf install nginx -y
