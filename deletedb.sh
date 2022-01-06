#!/bin/bash

if [ `find ./databases -maxdepth 0 -empty` ]
then 
	clear
	echo "-------------------------------------------------"
	echo "* There is no database to be dropped            *"
	echo "-------------------------------------------------"
	sleep 1
	source ./main.sh
else
while true   
do
echo "------------------------------------------------"
echo "------The avaliable databases are:--------------"
ls ./databases
echo "------------------------------------------------"
echo "* 1) To Enter database name you want to drop   *"
echo "* 2) To go back to main menu                   *"
echo "* 0) Exit                                      *"
echo "------------------------------------------------"
read
case $REPLY in 
	1) 
	clear    
		while true
		do
		echo "------------------------------------------------"
		echo "------The avaliable databases are:--------------"
		ls ./databases
		echo "* Enter the name of the database to be dropped *"
		echo "* To go back press 2                           *"
		echo "------------------------------------------------"
		read name
			case $name in
		 		+([a-zA-Z_]*[a-zA-Z0-9_]))
						if [ -d ./databases/$name ]
                		then
						clear
							while true
							do
								echo "------------------------------------------------"
								echo "* press 1 to confirm you want to drop $name    *"
								echo "* press 2 to cancel                            *"
								echo "------------------------------------------------"
								read 
								case $REPLY in
									1)	
										clear		 
			            				rm -r ./databases/$name
										echo "-------------------------------------------------"
										echo "* $name Database was dropped successfully       *"
										echo "-------------------------------------------------"
										sleep 1
										source ./deletedb.sh
										;;
									2)
										clear
										source ./deletedb.sh
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
						else
							clear
							echo "-------------------------------------------------"
							echo "* This database does not exit                   *"
							echo "-------------------------------------------------"	
 							sleep 1
							source ./deletedb.sh
						fi
						;;
				2) 
					clear
					source ./deletedb.sh
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
