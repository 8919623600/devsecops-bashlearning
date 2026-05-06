#! /bin/bash

echo "Enter file name: "
read file

if [-f "$file"] 
then
  echo "File exist"
 else
  echo "File does not exist"
fi