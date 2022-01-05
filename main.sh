#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
PS3="Please choose one of the following options >"
clear
while true 
do
echo "Welcome to the A&A DBMS"
echo "---------------------------------------------"
echo "* Choosing one of the following options:    *"
echo "* 1) Create Database                        *" 
echo "* 2) Connect To Database                    *" 
echo "* 3) List Databases                         *" 
echo "* 4) Drop Database                          *" 
echo "* 5) Exit                                   *"
echo "---------------------------------------------" 
read 
	case $REPLY in
		1)  clear
			 source ./createdb.sh
			;;	
		2) 
			clear
			source ./connectdb.sh
			;;
		3)	
			
			if [ `find ./databases/ -maxdepth 0 -empty` ]
			then
			clear
			echo "-------------------------------------------------"
			echo "* There is no database to list                  *"
			echo "* Please make sure to create a database first   *"
			echo "-------------------------------------------------"	
			else
			clear
			echo "-------------------------------------------------"
			echo "----------The avaliable databases are:-----------"			
			ls ./databases
			echo "-------------------------------------------------"
			fi
			;;
		4) clear
			source ./deletedb.sh
			;;
			
		5)     
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

