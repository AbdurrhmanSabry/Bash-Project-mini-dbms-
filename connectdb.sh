#!/bin/bash
while true   
do
clear
echo "The avaliable databases are: "
ls -A ./databases/
echo "1) To Enter database name you want to connect to"
echo "2) go back to main menu"
echo "0) Exit"
echo "---------------------------------------------"
read	
case $REPLY in 
	1)     
		while true
		do
		clear
		echo "The avaliable databases are: "
		ls ./databases
		echo "Enter the name of the database that you want to connect to"
		echo "To go back press 0"
		echo "---------------------------------------------"
		read DBname
		if [ `find ./dbms/databases -maxdepth 0 -empty` ]
		then 
			clear
			echo " There is no database to conncet to"
			sleep 2
			source ./connectdb.sh
		elif [ -d ./databases/$DBname ]
        then		 
			source ./tablemenu.sh
			echo  "Connected to" $DBname "successfully"
			sleep 2
		elif [[ $DBname == 0 ]]
		then
			source ./connectdb.sh        
		else
			echo "This database does not exits"	
 			sleep 2
			source ./connectdb.sh
			
		fi
		done
 		;;
	2) source ./main.sh
		;;

	0)
		exit
		;;

	*)
		echo "Not valid option"
		;;
esac 
done
