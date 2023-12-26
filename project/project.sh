#!/bin/bash

drawmain() {
  empty=$1
  echo -e "My Database Project\n Please choose the below options :\n\n"
  echo "1. Add Entry"
  if [ "$empty" != "empty" ]; then
    echo "2. Search / Edit Entry"
  fi
  echo "x. Exit"
}
drawentry()
{
echo -e "\nAdd New Entry Screen:\n"
echo -e "\n1: Name    : $1\n"
shift
echo -e "2: Email     : $1\n"
shift
echo -e "3: Tel No\t\t: $1\n"
shift
echo -e "4: Mob No    : $1\n"
shift
echo -e "5: Place     : $1\n"
shift
echo -e "6: Message   : $1\n"
shift
echo -e "x: Exit\n\n"
echo "Please choose the field to be added: "
}



directory="Database"

if [ -d "$directory" ]; then
  continue
else
  mkdir "$directory"
  chmod +w "$directory"
fi

if [ ! -e "$directory/database.log" ]; then
  echo > "$directory/database.log"
fi
echo -e "\n" `date` "  :  " `whoami` "\n" >> "$directory/database.log"


if [ ! -e "$directory/database.csv" ]; then
  echo > "$directory/database.csv"
fi
if [ -s "$directory/database.csv" ];then
drawmain "empty"
else
drawmain "notempty"
fi
read answer

