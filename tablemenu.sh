#!/bin/bash
while true
do 
clear
echo "welcome to" $DBname "Database"
echo "1) Create Table" 
echo "2) List Tables" 
echo "3) Drop Table" 
echo "4) Insert Into Table" 
echo "5) Select From Table" 
echo "6) Delete From Table" 
echo "7) Update Table" 
echo "8) Go To The Previous menu"
echo "9) Exit"
echo "Please choose one of the previous option before you press enter"
echo "---------------------------------------------"
read
	case $REPLY in
		1) 	clear   	
			source ./createtable.sh
			;;	
		2)  
			source ./listtable.sh
			;;
		3)	
			source ./droptable.sh
			;;
		4) 	
			source ./insert.sh
			echo "Insert" $DBname
			;;
			
		5)     clear
			source ./select.sh
						;;
		6)	
			source ./deleterecord.sh
			;;
		7)	clear
			source ./update.sh
			;;
		8)	source ./connectdb.sh
			;;
		9)	exit
			;;
		*)	
			clear
			echo "Not valid option" 
			;;	
	
	esac
done	

