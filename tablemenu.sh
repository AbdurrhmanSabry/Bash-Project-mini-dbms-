#!/bin/bash
clear
while true
do 
echo "welcome to $DBname Database"
echo "--------------------------------------------------------------------"
echo "* 1) Create Table                                                  *" 
echo "* 2) List Tables                                                   *" 
echo "* 3) Drop Table                                                    *" 
echo "* 4) Insert Into Table                                             *" 
echo "* 5) Select From Table                                             *" 
echo "* 6) Delete From Table                                             *" 
echo "* 7) Update Table                                                  *" 
echo "* 8) Go To The Previous menu                                       *"
echo "* 9) Exit                                                          *"
echo "* Please choose one of the previous option before you press enter  *"
echo "--------------------------------------------------------------------"
read
	case $REPLY in
		1) 	
			clear   	
			source ./createtable.sh
			;;	
		2)  
			clear
			source ./listtable.sh
			;;
		3)	
			clear
			source ./droptable.sh
			;;
		4) 	
			clear
			source ./insert.sh
			;;
			
		5)  
			clear
			source ./select.sh
			;;
		6)	
			clear
			source ./deleterecord.sh
			;;
		7)	
			clear
			source ./update.sh
			;;
		8)	
			clear
			source ./connectdb.sh
			;;
		9)	
			clear
			exit
			;;
		*)	
			clear
			echo "-------------------------------------------------"
			echo "----------ERROR----------------------------------"
			echo "* Not a valid Input                             *"
			echo "* Please make sure to choose one of the options *"
			echo "-------------------------------------------------" 
			;;	
	esac
done	

