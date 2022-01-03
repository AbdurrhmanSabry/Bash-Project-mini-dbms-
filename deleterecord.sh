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
while true 
			clear
			do
			echo "The avaliable tables are:"
			ls ./databases/$DBname/
			echo "1)To enter the name of the table to delete from"
			echo "0)To go back to the previous menu"
			read	
				case $REPLY in
				   	 1)
						clear
						typeset -i tbselectflag=0
						while [ $tbselectflag -eq 0 ]
						do
						echo "The avaliable tables are:"
						ls ./databases/$DBname/
						echo "Enter the name of the table you want to select from"
						echo "Press 0 to go back to the previous"
						read tabledeletefrom
						case $tabledeletefrom in
							+([a-zA-Z_]*[a-zA-Z0-9_]))
                                    if [ -f ./databases/$DBname/$tabledeletefrom ]
                                   	then
                                    clear
                                    numberofrecordsdelete=`cat ./databases/$DBname/$tabledeletefrom | wc -l`
                                    fi
                                    if [ $numberofrecordsdelete  -lt 3 ]
                                    then 
                                            echo "This $tabledeletefrom has no records to be deleted"
                                    elif [ $numberofrecordsdelete -gt 2 ]
                                    then
									echo "To delete from $tabledeletefrom table choose one of the following options "
									echo "1)To delete the whole table"
									echo "2)To delete a specific record"
                                    echo "0)To go back"
									read answer
									case $answer in
										1)
												sed -i -n '3,$d' ./databases/$DBname/$tabledeletefrom
											;;
										2)	
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
                                        sed -n '1p' ./databases/$DBname/$tabledeletefrom
                                        sed -n '2p' ./databases/$DBname/$tabledeletefrom
                                        echo "enter the value of the primary key ${namesofcolsdelete[0]} of the record you want to display"
					                    echo "${datatypesdelete[0]} is the data type of the primary key"
					                    echo "To go back press 0 if you leave Nothing would be displayed"
					                    echo "---------------------------------------------"
                                        if [[ "${datatypesdelete[0]}" =~ "string" ]]
                                        then    
                                            read pk
                                                case $pk in
                                                    +([a-zA-Z1-9][a-zA-Z0-9@._]))
					                                                if [[ " ${valuesofpkdelete[@]} " =~ " $pk " ]]
					                                                then 
																	sed -i  "/^$pk/d" ./databases/$DBname/$tabledeletefrom
                                                                    let pkdeleteflag++
					                                                else
																	clear
					                                                echo "This primary key does not exist"
					                                                fi
					                                     ;;
                                                    0)
					                                    clear
                                                        source ./deleterecord.sh
					                                     ;;
			                                        *)	                                                        
				                                    	       clear
                                                                echo "Not a valid option"
					                                     ;;
                                                esac
                                        else
                                            read pk
                                            case $pk in
                                                    +([1-9]) | +([1-9]*[0-9]))
					                                                if [[ " ${valuesofpkdelete[@]} " =~ " $pk " ]]
					                                                then 
					                                                sed -i "/^$pk/d" ./databases/$DBname/$tabledeletefrom
					                                                let pkdeleteflag++
					                                                else
					                                                
																	clear
																	echo "This primary key does not exist"
					                                                fi
					                                     ;;
                                                    0)
					                                                source ./deleterecord.sh
					                                     ;;
			                                        *)	                                                        
				                                    	            echo "Not a valid option"
					                                     ;;
                                                esac
                                                fi
                                      		  
                                      		  done

                                            
											;;
                                        0)
                                            source ./deleterecord.sh
                                            ;;
										*)
											echo "Not a valid option"
											;;
									esac
                                    else
                                      echo "The $tabledeletefrom table does not exist"
                                      
                                    fi
								;;
							0)
								source ./deleterecord.sh
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
done 
fi			