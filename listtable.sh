#!/bin/bash
if [ `find ./databases/$DBname/ -maxdepth 0 -empty` ]
then 
	clear
	echo "---------------------------------------------"
	echo "The $DBname database is empty              "
	echo "---------------------------------------------"
    sleep 1
    source ./tablemenu.sh
else
clear
while true 
do
echo "---------------------------------------------"
echo "* Enter 1 to display the available tables   *"
echo "* Enter 0 to go to the previous menu        *"
echo "---------------------------------------------"
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
		echo "-------------------------------------------------"
		echo "----------ERROR----------------------------------"
		echo "* Not a valid Input                             *"
		echo "* Please make sure to enter that you entered the*"
		echo "* correct name of the database to be dropped    *"
		echo "-------------------------------------------------"
		;;
    esac
done
fi 