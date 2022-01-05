#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
clear
while true
do
echo "-------------------------------------------------------------"
echo "* 1)To enter the number of columns                          *"
echo "* 2)to go back if you leave now the table would be deleted  *"
echo "-------------------------------------------------------------"
read
	case $REPLY in
		1)	
			clear
			while true 
			do
			echo "------------------------------------------------------------------------------"
			echo "* Enter the number of columns                                                *"
			echo "* The number has to be greater than zero                                     *"
			echo "* Press 0 to go back to the pervious if you leave the table would be deleted *"
			echo "* Please don't start the number with 0                                       *"	
			echo "------------------------------------------------------------------------------"
			read number
			case $number in
			+([[0-9]))
			if [[ $number == +([0]*) ]]
			then 
				clear
			    rm ./databases/$DBname/$TBname
				echo "---------------------------------------------"
				echo "* you entered 0, Exit                       *"
				echo "* The $TBname was deleted                   *"
				echo "---------------------------------------------"
				sleep 1					
				source ./tablemenu.sh
			else
			typeset -i primflag=0
			while [ $primflag -eq 0 ] 
			do
			echo "---------------------------------------------------------------------------"
			echo "* Enter the name of the primary key                                       *"
			echo "* To go back press 0 if you leave now the table would be deleted          *"
			echo "* Please don't start the name with nummber                                *"
			echo "* Please don't include any speccial character except for the underscore   *"
			echo "---------------------------------------------------------------------------"
			read pk
			case $pk in
			+([a-zA-Z_]*[a-zA-Z0-9_]))
					colnames[0]=$pk
					typeset -i pkdatatype=0
					while [ $pkdatatype -eq 0 ]
					do
					echo "--------------------------------------------------------------"
					echo "* enter the data type of the primary key $pk                 *"
					echo "* 1)int                                                      *"
					echo "* 2)string                                                   *"
					echo "* To go back press 0 if you leave the table would be deleted *"
					echo "--------------------------------------------------------------"
					read data
					case $data in
						1)
							clear
							datatypes[0]="int"
							let pkdatatype++
							;;
						2)
							clear
							datatypes[0]="string"
							let pkdatatype++
						;;
						0)	
							clear
							rm ./databases/$DBname/$TBname
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
					let primflag++
					
				;;
			0)
				clear
				rm ./databases/$DBname/$TBname				
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
			fi	
		        for ((i=1;i<${number};i++));
			do
			typeset -i colflag=0
			while [ $colflag -eq 0 ]
			do
			echo $((i+1))":"
			echo "--------------------------------------------------------------------------"
			echo "* Enter the name of the column to be created                             *"
			echo "* Please don't start the name with nummber                               *"
			echo "* Please don't include any speccial character except for the underscore  *"
			echo "* To go back press 0 if you leave now the table would be deleted         *"
			echo "--------------------------------------------------------------------------"
			read value
			case $value in
				+([a-zA-Z1-9_]*[a-zA-Z0-9_]))
					if [[ ":$pk " =~ ":${value} " || " ${colnames[@]} " =~ ":${value} " ]]
					then 
					clear
					echo "---------------------------------------------"
					echo "* This column already exists                *"
					echo "---------------------------------------------"
					else
					clear
					colnames[$i]=":"$value
					let colflag++
					fi
					;;
				0)	
					clear
					rm ./databases/$DBname/$TBname
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
			
			typeset -i dataflag=0
			while [ $dataflag -eq 0 ]
			do
			
			echo $((i+1))":"
			echo "--------------------------------------------------------------"
			echo "* enter the data type of $value                              *" 
			echo "* 1)int                                                      *"
			echo "* 2)string                                                   *"
			echo "* To go back press 0 if you leave the table would be deleted *"
			echo "--------------------------------------------------------------"
			read data
			case $data in
				1)	
					clear
					datatypes[$i]=":int"
					let dataflag++
					;;
				2)	
					clear
					datatypes[$i]=":string"
					let dataflag++
					;;
				0)	
					clear
					rm ./databases/$DBname/$TBname
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
			done
			clear
			echo ${colnames[*]} >> ./databases/$DBname/$TBname
			echo ${datatypes[*]} >> ./databases/$DBname/$TBname
			echo "---------------------------------------------"
			#cat ./databases/$DBname/$TBname 
			echo "---------------------------------------------------------" 
			echo "* $TBname Table has been created successfully           *"
			echo "---------------------------------------------------------"
			echo "* The table contains $number columns, the columns are   *"
			echo ${colnames[@]}
			echo "* And their datatypes are                               *"
			echo ${datatypes[@]}
			echo "---------------------------------------------------------"
			
			sleep 4
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
			rm ./databases/$DBname/$TBname
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
