#!/bin/bash 
clear
shopt -s extglob
export LC_COLLATE=C
while true
do
echo "1) To enter table name you want to create" 
echo "2) go back to the previous menu"
echo "Please choose an option before pressing enter"
	read 
	case $REPLY in
		1)	
			while true  
			do		
			echo "Enter the name of the table to be created"
			echo "Please don't start the name with nummber"
			echo "Please don't include any speccial character except for the underscore"
			echo "To go back press 2"
			read TBname
                       	case $TBname in
				+([a-zA-Z_]*[a-zA-Z0-9_]))
						if [ -f ./databases/$DBname/$TBname ]
                       				then
						echo "This table already exits"
						else
						`touch ./databases/$DBname/$TBname`
						source ./creatcol.sh
						fi
						;;
						2)
						source ./tablemenu.sh
						;;
						*)
						echo "Not a valid option"
						;;
						esac	
						done
						
						;;
					
				2)
					source ./tablemenu.sh
					;;
				*)
					echo "Not a valid option"
					sleep 2 
					source ./createtable.sh
					;;
				esac
			done 
			#echo "Not a valid option"
			#sleep 2 
			#source ./createtable.sh
