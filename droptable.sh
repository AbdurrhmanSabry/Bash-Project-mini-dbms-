#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
if [ `find ./databases/$DBname -maxdepth 0 -empty` ]
then 
	clear
	echo "---------------------------------------------"
    echo "The $DBname is empty no table to be dropped"
	echo "---------------------------------------------"
	source ./tablemenu.sh
else
while true 
do
clear
		if [ `find ./databases/$DBname -maxdepth 0 -empty` ]
		then 
			clear
			echo "---------------------------------------------"
    		echo "The $DBname has no more tables to be dropped"
			echo "---------------------------------------------"
			source ./tablemenu.sh
		else 
			echo "---------------------------------------------"
			echo "The avaliable tables are:"
			ls ./databases/$DBname/
			echo "1)To enter the name of the table to be dropped"
			echo "0)To go back to the previous menu"
			echo "---------------------------------------------"
			read	
				case $REPLY in
				   	 1)
						clear
						typeset -i tbdropflag=0
						while [ $tbdropflag -eq 0 ]
						do
						echo "The avaliable tables are:"
						ls ./databases/$DBname/
						echo "Enter the name of the table you want to drop"
						echo "Press 0 to go back to the previous"
						read tabletodrop
						case $tabletodrop in
							+([a-zA-Z_]*[a-zA-Z0-9_]))
                                    if [ -f ./databases/$DBname/$tabletodrop ]
                                    then
                                    clear
									echo "Confirm you want to drop $tabletodrop table "
									echo "enter y to confirm"
									echo "enter n to cancel "
									read answer
									case $answer in
										y|Y)
												rm ./databases/$DBname/$tabletodrop
												source ./tablemenu.sh
											;;
										n|N)
											;;
										*)
											echo "Not a valid option"
											;;
									esac
                                    else
                                      echo "The $tabletodrop table does not exist"
                                    fi
								;;
							0)
								source ./tablemenu.sh
								;;
							*)
								echo "Not a valid option"
								;;
						esac
						done
						;;
					 0)
						source ./tablemenu.sh
					 	;;
					 *)
					 	echo "Not a valid option"
					 	;;
				esac
			fi	
done 
fi			