#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
clear
while true 
do

echo "-------------------------------------------------"
echo "* 1) To enter database name you want to create  *" 
echo "* 2) go back to main menu                       *" 
echo "* 0) Exit                                       *"
echo "-------------------------------------------------"
read		
			case $REPLY in 
			1)		
			clear
					while true  
					do
					echo "-------------------------------------------------"	
					echo "* Enter the name of the database to be created"
					echo "* Please don't start the name with nummber"
					echo "* Please don't include any speccial character except for the underscore"
					echo "* To go back press 2"
					echo "-------------------------------------------------"
					read name
                       			case $name in
						+([a-zA-Z_]*[a-zA-Z0-9_]))
								if [ -d ./databases/$name ]
                       			then
								clear
									echo "-------------------------------------------------"
									echo "* This database already exits                   *"
									echo "-------------------------------------------------"
								else
								clear	
								while true   
								do
								echo "-------------------------------------------------"
								echo "* 1) confirm the name                           *" 
								echo "* 2) go back                                    *"
								echo "-------------------------------------------------"
								read
									case $REPLY in
										1)
											clear
											mkdir ./databases/$name
											echo "-------------------------------------------------"
											echo "*"$name "Database has been created successfully *"
											echo "-------------------------------------------------"
											sleep 1
											source ./createdb.sh
											;;
										2)
											clear
											source ./createdb.sh
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
                                        	        ;;
						2)
							clear
							source ./createdb.sh
							;;	
						*)
							clear
							echo "-------------------------------------------------"
							echo "----------ERROR----------------------------------"
							echo "* This name is not valid                        *"
							echo "* Try entering the name again                   *"
							echo "-------------------------------------------------"
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
		 		clear
				echo "-------------------------------------------------"
				echo "----------ERROR----------------------------------"
				echo "* This input is not valid                       *"
				echo "-------------------------------------------------"
				;;
	esac 
done
			

				
