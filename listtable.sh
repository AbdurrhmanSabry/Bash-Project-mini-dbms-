#!/bin/bash
clear
if [ `find ./databases/$DBname/ -maxdepth 0 -empty` ]
then 
	clear
	echo "---------------------------------------------"
	echo "The $DBname database is empty"
	echo "---------------------------------------------"
    sleep 2
    source ./tablemenu.sh
else
while true 
do

echo "Enter 1 to display the available tables"
echo "Enter 0 to go to the previous menu"
read 
    case $REPLY in
    1)
        clear
        echo "---------------------------------------------"
        echo "The avaliable tables are: "
        ls ./databases/$DBname
        echo "---------------------------------------------"
        ;;
    0)
        clear
        source ./tablemenu.sh
        ;;
    *)  
        clear
        echo "Not a valid option"
        ;;
    esac
done
fi 