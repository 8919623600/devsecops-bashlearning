#! /bin/bash

echo "Configuration management for Frontend"

echo "disabling nginx module"



echo "Enabling nginx"
dnf module enable nginx:1.24 -y
