#!/bin/bash
while true   
do
echo "The avaliable databases are: "
ls ./databases
echo "---------------------------------------------"
echo "1) To Enter database name you want to delete"
echo "2) To go back to main menu"
echo "0) Exit"
echo "---------------------------------------------"
read
#if [[  $REPLY  -eq "" ]]
#then
#echo "choose an option before pressing enter"
#else	
case $REPLY in 
	1)     
		while true
		do
		clear
		echo "The avaliable databases are: "
		ls ./databases
		echo "Enter the name of the database to be deleted"
		echo "To go back press 2"
		echo "---------------------------------------------"
		read 
		case $REPLY in
		 +([a-zA-Z_]*[a-zA-Z0-9_]))
			name=$REPLY
			if [ `find ./dbms/databases -maxdepth 0 -empty` ]
			then 
				clear
				echo " There is no database to delete"
				sleep 2
				source ./deletedb.sh
			elif [ -d ./databases/$name ]
                then
				while true
				do
					echo "press 1 to confirm you want to delete" $name
					echo "press 2 to cancel"
					echo "---------------------------------------------"
					read 
					case $REPLY in
					1)			 
			            	rm -r ./databases/$name
					echo $name " was successfully deleted"
					sleep 2
					source ./deletedb.sh
					;;
					2)
					source ./deletedb.sh
					;;
					*)
					echo "Not a valid option"	
					;;			
					esac      
				done
				else
					echo "This database does not exit"	
 					sleep 2
					source ./deletedb.sh
			
				fi
				;;
		2) source ./deletedb.sh
				;;
		*)
				echo "Not a valid option"
				;;
		esac
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
				
