#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
PS3="Please choose one of the following options >"
while true 
do
clear
echo "Welcome to the A&A DBMS"
echo "Done by Abdurrhman Sabry and Abdelrahim Saad"
echo "---------------------------------------------"
echo "1) Create Database" 
echo "2) Connect To Database " 
echo "3) List Databases" 
echo "4) Drop Database" 
echo "5) Exit"
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
			clear			
			echo "The databases are: "
			ls ./databases
			;;
		4) clear
			source ./deletedb.sh
			;;
			
		5)     
			exit	
		
				;;
		*)	
			clear 
			echo "Not a valid option"
			;;	
	
	esac
done	

