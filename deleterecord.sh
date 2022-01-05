#!/bin/bash 
#!/bin/bash

shopt -s extglob
export LC_COLLATE=C
if [ `find ./databases/$DBname -maxdepth 0 -empty` ]
then 
	clear
	echo "---------------------------------------------"
    echo "The $DBname is empty no table to delete from"
	echo "---------------------------------------------"
else
clear
while true 
do
			echo "-------------------------------------------------"
			echo "The avaliable tables are:"
			ls ./databases/$DBname/
			echo "1)To enter the name of the table to delete from"
			echo "0)To go back to the previous menu"
			echo "--------------------------------------------------"
			read	
				case $REPLY in
				   	 1)
						clear
						typeset -i tbselectflag=0
						while [ $tbselectflag -eq 0 ]
						do
						echo "----------------------------------------------------"
						echo "The avaliable tables are:"
						ls ./databases/$DBname/
						echo "Enter the name of the table you want to select from"
						echo "Press 0 to go back to the previous"
						echo "----------------------------------------------------"
						read tabledeletefrom
						case $tabledeletefrom in
							+([a-zA-Z_]*[a-zA-Z0-9_]))
                                    if [ -f ./databases/$DBname/$tabledeletefrom ]
                                   	then
                                    
                                    numberofrecordsdelete=`cat ./databases/$DBname/$tabledeletefrom | wc -l`
                                    fi
                                    if [ $numberofrecordsdelete  -lt 3 ]
                                    then 	
											clear
											echo "--------------------------------------------------"
                                            echo "This $tabledeletefrom has no records to be deleted"
											echo "--------------------------------------------------"
                                    elif [ $numberofrecordsdelete -gt 2 ]
                                    then
									clear
									echo "--------------------------------------------------------------------------"
									echo "To delete from $tabledeletefrom table choose one of the following options "
									echo "1)To delete the whole table"
									echo "2)To delete a specific record"
                                    echo "0)To go back"
									echo "--------------------------------------------------------------------------"
									read answer
									case $answer in
										1)
											clear
											sed -i  '3,$d' ./databases/$DBname/$tabledeletefrom
											echo "------------------------------------------------------------------"
											echo "Every record in $tabledeletefrom was deleted"
											echo "------------------------------------------------------------------"		
											;;
										2)
										clear	
										declare -a datatypesdelete=()
                                        declare -a namesofcolsdelete=()
                                        numberoffieldsdelete=0   
                                        read numberoffieldsdelete <<< $(awk -F: '{if(NR == 1)print NF}' ./databases/$DBname/$tabledeletefrom) 
                                        for (( i=1;i<=$numberoffieldsdelete;i++ ));
                                        do
                                            namesofcolsdelete[$i-1]=`sed -n '1p' ./databases/$DBname/$tabledeletefrom | cut -d: -f$i`
                                            datatypesdelete[$i-1]=`sed -n '2p' ./databases/$DBname/$tabledeletefrom | cut -d: -f$i`
                                        done
                                        typeset -i pkdeleteflag=0
                                        declare -a valuesofpkdelete=()
                                        
                                        for (( i=3;i<=$numberofrecordsdelete;i++ ));
                                        do
                                            valuesofpkdelete[$i-3]=`head -$i ./databases/$DBname/$tabledeletefrom | tail -1 |cut -d: -f1`
                                        done
                                        while [ $pkdeleteflag -eq 0 ] 
                                        do
										echo "--------------------------------------------------------------------------"
                                        sed -n '1p' ./databases/$DBname/$tabledeletefrom
                                        sed -n '2p' ./databases/$DBname/$tabledeletefrom
                                        echo "enter the value of the primary key ${namesofcolsdelete[0]} of the record you want to display"
					                    echo "${datatypesdelete[0]} is the data type of the primary key"
					                    echo "To go back press 0 if you leave Nothing would be displayed"
										echo "--------------------------------------------------------------------------"
                                        if [[ "${datatypesdelete[0]}" =~ "string" ]]
                                        then   
                                            read pk
                                                case $pk in
                                                   +([a-zA-Z]) | +([a-zA-Z1-9][a-zA-Z0-9@._]))
					                                                if [[ " ${valuesofpkdelete[@]} " =~ " $pk " ]]
					                                                then 
																	clear
																	echo "--------------------------------------------------------------------"
																	sed -i  "/^$pk :/d" ./databases/$DBname/$tabledeletefrom
																	echo "--------------------------------------------------------------------"
                                                                    let pkdeleteflag++
					                                                else
																	clear
																	echo "-----------------------------------------------------------"
					                                                echo "This primary key does not exist"
																	echo "-----------------------------------------------------------"
					                                                fi
					                                     ;;
                                                    0)
					                                    clear
                                                        source ./deleterecord.sh
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
                                        else
                                            read pk
                                            case $pk in
                                                    +([1-9]) | +([1-9]*[0-9]))
					                                                if [[ " ${valuesofpkdelete[@]} " =~ " $pk " ]]
					                                                then 
																	clear
																	echo "--------------------------------------------------------------------"
					                                                sed -i "/^$pk/d" ./databases/$DBname/$tabledeletefrom
																	echo "--------------------------------------------------------------------"
					                                                let pkdeleteflag++
					                                                else
					                                                
																	clear
																	echo "-----------------------------------------------------------"
					                                                echo "This primary key does not exist"
																	echo "-----------------------------------------------------------"
					                                                fi
					                                     ;;
                                                    0)
														clear
					                                     source ./deleterecord.sh
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
                                                fi
                                      		  
                                      		  done

                                            
											;;
                                        0)
											clear
                                            source ./deleterecord.sh
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
                                    else
										clear
										echo "-----------------------------------------------------------"
                                      	echo "The $tabledeletefrom table does not exist"
										echo "-----------------------------------------------------------"
                                    fi
								;;
							0)
								clear
								source ./deleterecord.sh
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
					 0)
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
fi			