#!/bin/bash 
clear
shopt -s extglob
export LC_COLLATE=C
while true
do
echo "-------------------------------------------------"
echo "* 1) To enter table name you want to create     *" 
echo "* 2) go back to the previous menu               *"
echo "* Please choose an option before pressing enter *"
echo "-------------------------------------------------"
read 
	case $REPLY in
		1)	
			clear
			while true  
			do
			echo "-------------------------------------------------------------------------"		
			echo "* Enter the name of the table to be created                             *"
			echo "* Please don't start the name with nummber                              *"
			echo "* Please don't include any speccial character except for the underscore *"
			echo "* To go back press 2                                                    *"
			echo "-------------------------------------------------------------------------"
			read TBname
                       	case $TBname in
							+([a-zA-Z_]*[a-zA-Z0-9_]))
									if [ -f ./databases/$DBname/$TBname ]
                       				then
									   clear
									   	echo "-------------------------------------------------" 
										echo "* This table already exits                      *"
										echo "-------------------------------------------------"
									else
										clear
										touch ./databases/$DBname/$TBname
										source ./creatcol.sh
									fi
								;;
							2)
									clear
									source ./tablemenu.sh
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
					source ./tablemenu.sh
			;;
		*)
					clear
					echo "-------------------------------------------------"
					echo "----------ERROR----------------------------------"
					echo "* Not a valid Input                             *"
					echo "* Please make sure to choose one of the options *"
					echo "-------------------------------------------------" 
					sleep 1
					source ./createtable.sh
			;;
	esac
done 
