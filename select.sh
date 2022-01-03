#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
if [ `find ./databases/$DBname -maxdepth 0 -empty` ]
then 
	clear
	echo "---------------------------------------------"
    echo "The $DBname is empty no table to select from"
	echo "---------------------------------------------"
else
while true 
			clear
			do
			echo "The avaliable tables are:"
			ls ./databases/$DBname/
			echo "1)To enter the name of the table to select from"
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
						read tabletoselectfrom
						case $tabletoselectfrom in
							+([a-zA-Z_]*[a-zA-Z0-9_]))
                                    if [ -f ./databases/$DBname/$tabletoselectfrom ]
                                   	then
                                    clear
									echo "To select from $tabletoselectfrom table choose one of the following options "
									echo "1)To display the whole table"
									echo "2)To display a specific row"
                                    echo "0)To go back"
									read answer
									case $answer in
										1)
												cat ./databases/$DBname/$tabletoselectfrom
											;;
										2)	
										declare -a datatypesselect=()
                                        declare -a namesofcolsselect=()
                                        numberoffieldsselect=0   
                                        numberofrecordsselect=`cat ./databases/$DBname/$tabletoselectfrom | wc -l`
                                        read numberoffieldsselect <<< $(awk -F: '{if(NR == 1)print NF}' ./databases/$DBname/$tabletoselectfrom) 
                                        for (( i=1;i<=$numberoffieldsselect;i++ ));
                                        do
                                            namesofcolsselect[$i-1]=`sed -n '1p' ./databases/$DBname/$tabletoselectfrom | cut -d: -f$i`
                                            datatypesselect[$i-1]=`sed -n '2p' ./databases/$DBname/$tabletoselectfrom | cut -d: -f$i`
                                        done
                                        typeset -i pkselectflag=0
                                        declare -a valueofpksselect=()
                                        
                                        for (( i=3;i<=$numberofrecordsselect;i++ ));
                                        do
                                            valueofpksselect[$i-3]=`head -$i ./databases/$DBname/$tabletoselectfrom | tail -1 |cut -d: -f1`
                                        done
                                        while [ $pkselectflag -eq 0 ] 
                                        do
                                        sed -n '1p' ./databases/$DBname/$tabletoselectfrom
                                        sed -n '2p' ./databases/$DBname/$tabletoselectfrom
                                        echo "enter the value of the primary key ${namesofcolsselect[0]} of the record you want to display"
					                    echo "${datatypesselect[0]} is the data type of the primary key"
					                    echo "To go back press 0 if you leave Nothing would be displayed"
					                    echo "---------------------------------------------"
                                        if [[ "${datatypesselect[0]}" =~ "string" ]]
                                        then    
                                            read pk
                                                case $pk in
                                                    +([a-zA-Z1-9][a-zA-Z0-9@._]))
					                                                if [[ " ${valueofpksselect[@]} " =~ " $pk " ]]
					                                                then 
																	cat ./databases/$DBname/$tabletoselectfrom | grep ^$pk :
                                                                    let pkselectflag++
					                                                else
																	clear
					                                                echo "This primary key does not exist"
					                                                fi
					                                     ;;
                                                    0)
					                                    clear
                                                        source ./select.sh
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
					                                                if [[ " ${valueofpksselect[@]} " =~ " $pk " ]]
					                                                then 
					                                                cat ./databases/$DBname/$tabletoselectfrom | grep "^$pk :"
					                                                let pkselectflag++
					                                                else
					                                                
																	clear
																	echo "This primary key does not exist"
					                                                fi
					                                     ;;
                                                    0)
					                                                source ./select.sh
					                                     ;;
			                                        *)	                                                        
				                                    	            echo "Not a valid option"
					                                     ;;
                                                esac
                                      		  fi
                                      		  done

                                            
											;;
                                        0)
                                            source ./select.sh
                                            ;;
										*)
											echo "Not a valid option"
											;;
									esac
                                    else
                                      echo "The $tabletoselectfrom table does not exist"
                                    fi
								;;
							0)
								source ./select.sh
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