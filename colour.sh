#!/bin/bash 

# Each and every color you see on terminal will have a color code and we need to use that code baesd on our need.
# Colors       Foreground          Background
# Red              31                  41
# Green            32                  42
# Yellow           33                  43
# Blue             34                  44
# Magenta          35                  45
# Cyan             36                  46

# Syntax to print colors 
# echo -e "\e[COLORCODEm I am printing a color \e[0m"

echo -e "\e[36m This is cyan color \e[0m"
echo -e "\e[31m This is red color \e[0m"
echo -e "\e[32m This is green color \e[0m"
echo -e "\e[33m This is yellow color \e[0m"
echo -e "\e[34m This is blue color \e[0m"
echo -e "\e[35m This is magenta color \e[0m"

# Printing with background colors
# echo -e "\e[backGroundColor;ForeGroundCOLORm Printing Color \e[0m"

echo -e "\e[43;31m Printing Red On Yellow \e[0m"
