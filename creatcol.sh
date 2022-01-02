#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
clear
while true
do
echo  "1)To enter the number of columns"
echo  "2)to go back if you leave now the table would be deleted"
echo "---------------------------------------------"
read
	case $REPLY in
		1)	while true 
			do
			echo "Enter the number of columns"
			echo " The number has to be greater than zero"
			echo "press 0 to go back to the pervious if you leave the table would be deleted"
			echo "Please don't start the number with 0"	
			echo "---------------------------------------------"
			read number
			case $number in
			+([[0-9]))
			if [[ $number == +([0]*) ]]
			then 
				
			      rm ./databases/$DBname/$TBname
				echo "you entered 0, Exit"
				sleep 3					
				source ./tablemenu.sh
				
			else	
			declare -a colnames=()
			declare -a datatypes=()
			typeset -i primflag=0
			while [ $primflag -eq 0 ] 
			do
			echo " Enter the name of the primary key"
			echo "To go back press 0 if you leave now the table would be deleted"
			echo "Please don't start the name with nummber"
			echo "Please don't include any speccial character except for the underscore"
			echo "---------------------------------------------"
			read pk
			
			case $pk in
			+([a-zA-Z_]*[a-zA-Z0-9_]))
					colnames[0]=$pk
					typeset -i pkdatatype=0
					while [ $pkdatatype -eq 0 ]
					do
					clear
					 
					echo "enter the data type of the primary key $pk"
					echo "1)int"
					echo "2)string"
					echo "To go back press 0 if you leave the table would be deleted"
					echo "---------------------------------------------"
					read data
					case $data in
						1)
							datatypes[0]="int"
							let pkdatatype++
							;;
						2)
							datatypes[0]=string
							let pkdatatype++
						;;
						0)	
						rm ./databases/$DBname/$TBname
						source ./tablemenu.sh
						;;
						*)	
						echo "Not a valid option"
						;;	
					esac
					done	
					let primflag++
				;;
			0)
				rm ./databases/$DBname/$TBname				
				source ./tablemenu.sh
				
				;;
			*)
				echo "Not valid option"
				;;
			esac
			
			done	
		        for ((i=1;i<${number};i++));
			do
			
			typeset -i colflag=0
			while [ $colflag -eq 0 ]
			do
			
			echo $((i+1))":"
			echo "Enter the name of the column to be created"
			echo "Please don't start the name with nummber"
			echo "Please don't include any speccial character except for the underscore"
			echo "To go back press 0 if you leave now the table would be deleted"
			echo "---------------------------------------------"
			read value
			case $value in
				+([a-zA-Z1-9_]*[a-zA-Z0-9_]))
					if [[ ":$pk " =~ ":${value} " || " ${colnames[@]} " =~ ":${value} " ]]
					then 
					echo "This column already exists"
					else
					colnames[$i]=":"$value
					let colflag++
					fi
					;;
				0)	
					rm ./databases/$DBname/$TBname
					source ./tablemenu.sh
					;;
				*)	
					echo "Not a valid name"
					;;	
			esac
			done		
			
			typeset -i dataflag=0
			while [ $dataflag -eq 0 ]
			do
			clear
			echo $((i+1))":"
			echo "enter the data type of $value" 
			echo "1)int"
			echo "2)string"
			echo "To go back press 0 if you leave the table would be deleted"
			echo "---------------------------------------------"
			read data
			case $data in
				1)
					datatypes[$i]=":int"
					let dataflag++
					;;
				2)
					datatypes[$i]=":string"
					let dataflag++
					;;
				0)	
					rm ./databases/$DBname/$TBname
					source ./tablemenu.sh
					;;
				*)	
					echo "Not a valid name"
					;;	
			esac
			done	
			done
			clear
			echo $TBname "Table has been created successfully"
			echo "the table contains $number columns, the columns are"
			echo ${colnames[@]}
			echo "and their datatypes are"
			echo ${datatypes[@]}
			echo "---------------------------------------------"
			echo ${colnames[*]} > ./databases/$DBname/$TBname
			sed -i "1 a ${datatypes[*]}" ./databases/$DBname/$TBname
			echo "---------------------------------------------"
			cat ./databases/$DBname/$TBname 
			
						sleep 5
						source ./tablemenu.sh
					fi
					;;
				
			*)
			echo "Not a valid option"
			;;
			
			esac		
			done
			;;	
		2)
			rm ./databases/$DBname/$TBname
			source ./tablemenu.sh
				;;
		*)
			echo "Not a valid option"
			;;
	esac
done
