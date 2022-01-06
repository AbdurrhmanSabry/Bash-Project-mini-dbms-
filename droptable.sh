#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
if [ `find ./databases/$DBname -maxdepth 0 -empty` ]
then 
	clear
	echo "-----------------------------------------------"
    echo "* The $DBname is empty no table to be dropped *"
	echo "-----------------------------------------------"
	sleep 2
	source ./tablemenu.sh
else
clear
while true 
do
		if [ `find ./databases/$DBname -maxdepth 0 -empty` ]
		then 
			clear
			echo "-------------------------------------------------"
    		echo "* The $DBname has no more tables to be dropped  *"
			echo "-------------------------------------------------"
			source ./tablemenu.sh
		else
			clear
			echo "---------------------------------------------------"
			echo "* The avaliable tables are:                       *"
			ls ./databases/$DBname/
			echo "* 1)To enter the name of the table to be dropped   *"
			echo "* 0)To go back to the previous menu                *"
			echo "----------------------------------------------------"
			read	
				case $REPLY in
				   	 1)
						clear
						typeset -i tbdropflag=0
						while [ $tbdropflag -eq 0 ]
						do
						echo "------------------------------------------------"
						echo "* The avaliable tables are:                    *"
						ls ./databases/$DBname/
						echo "* Enter the name of the table you want to drop *"
						echo "* Press 0 to go back to the previous           *"
						echo "------------------------------------------------"
						read tabletodrop
						case $tabletodrop in
							+([a-zA-Z_]*[a-zA-Z0-9_]))
                                    if [ -f ./databases/$DBname/$tabletodrop ]
                                    then
                                    clear
									echo "------------------------------------------------"
									echo "* Confirm you want to drop $tabletodrop table  *"
									echo "* Enter y to confirm                           *"
									echo "* Enter n to cancel                            *"
									echo "------------------------------------------------"
									read answer
									case $answer in
										y|Y)
												clear
												rm ./databases/$DBname/$tabletodrop
												echo "$tabletodrop table was successfully dropped"
												sleep 2
												source ./tablemenu.sh
											;;
										n|N) 	clear
												source ./droptable.sh
											;;
										*)
											clear
											echo "-------------------------------------------------"
											echo "----------ERROR----------------------------------"
											echo "* Not a valid Input                             *"
											echo "* Please make sure to enter that you entered the*"
											echo "* correct name of the table to be dropped       *"
											echo "-------------------------------------------------"
											;;
									esac
                                    else
										clear
										echo "-------------------------------------------------"
                                    	echo "The $tabletodrop table does not exist"
										echo "-------------------------------------------------"
                                    fi
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
								echo "* Please make sure          that you entered the*"
								echo "* correct name of the table to be dropped       *"
								echo "-------------------------------------------------"
								;;
						esac
						done
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
						echo "* Please make sure that you entered the         *"
						echo "* correct name of the table to be dropped       *"
						echo "-------------------------------------------------"
					 	;;
				esac
			fi	
done 
fi			