#!/bin/bash
if [ `find ./databases -maxdepth 0 -empty` ]
then 
	clear
	echo "---------------------------------------------------"
	echo "* There is no database to connect to              *"
	echo "* Please make sure that any database exist before *"
	echo "* choosing the connect to database option         *"
	echo "---------------------------------------------------"
	sleep 1
	source ./main.sh
else
clear
while true   
do
echo "--------------------------------------------------------------"
echo "-----The avaliable databases are:-----------------------------"
ls -A ./databases/                                       
echo "--------------------------------------------------------------"
echo "* 1) To Enter database name you want to connect to           *"
echo "* 2) go back to main menu                                    *"
echo "* 0) Exit                                                    *"
echo "--------------------------------------------------------------"
read	
case $REPLY in 
	1)     
	clear
		while true
		do
		echo "--------------------------------------------------------------"
		echo "-----The avaliable databases are:-----------------------------"
		ls ./databases
		echo "* Enter the name of the database that you want to connect to *"
		echo "* To go back press 0                                         *"
		echo "--------------------------------------------------------------"
		read DBname
		case $DBname in 
			+([a-zA-Z_]*[a-zA-Z0-9_])) 
							if [ -d ./databases/$DBname ]
        					then
								clear		 
								echo "-----------------------------------------------------"
								echo "* Connectimg to $DBname                               *"
								echo "-----------------------------------------------------"
								sleep 1
								source ./tablemenu.sh
							else
								clear
								echo "-----------------------------------------------------"
								echo "* This database does not exits                      *"	
								echo "-----------------------------------------------------"
 								sleep 1
								source ./connectdb.sh
							fi
					;;
			0)
				clear
				source ./connectdb.sh        
				;;
			*)
			clear
			echo "-------------------------------------------------"
			echo "----------ERROR----------------------------------"
			echo "* Not a valid Input                             *"
			echo "-------------------------------------------------"
 			sleep 1
			source ./connectdb.sh
				;;
		esac			
		done
 		;;
	2) 
		clear
		source ./main.sh
		;;

	0)
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
fi
