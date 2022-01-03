#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
while true 
do
clear
echo "1) To enter database name you want to create" 
echo "2) go back to main menu" 
echo "0) Exit"
echo "---------------------------------------------"
read		
			case $REPLY in 
			1)		
					while true  
					do		
					echo "Enter the name of the database to be created"
					echo "Please don't start the name with nummber"
					echo "Please don't include any speccial character except for the underscore"
					echo "To go back press 2"
					echo "---------------------------------------------"
					read name
                       			case $name in
						+([a-zA-Z_]*[a-zA-Z0-9_]))
							if [ -d ./databases/$name ]
                       			then
								echo "This database already exits"
							else
							clear	
							while true   
							do	
							echo "1) confirm the name" 
							echo "2) go back"
							read
							case $REPLY in
								1)
								mkdir ./databases/$name
								echo $name "Database created successfully"
								sleep 2	
								source ./createdb.sh
								;;
								2)
								source ./createdb.sh
								;;
								*)
									echo "Not a valid option"
								;;
								esac	
							done
							fi
                                        	        ;;
						2)
							source ./createdb.sh
							;;	
						*)
						clear
						echo "This name is not valid"
						echo "Try entering the name again"	
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
			

				
