#!/bin/bash

shopt -s extglob
export LC_COLLATE=C
clear
if [ `find ./databases/$DBname -maxdepth 0 -empty` ]
then 
clear
    echo "---------------------------------------------" 
    echo "The $DBname is empty no table to update Its records"
    echo "---------------------------------------------" 
    sleep 3
    source ./tablemenu.sh
else
clear
    while true
    do
    echo "---------------------------------------------" 
    echo "The avaliable tables are :"
    ls  ./databases/$DBname/
    echo "Enter the name of the table"
    echo "Press 0 to go back"
    echo "---------------------------------------------" 
    read tabletoupdate
        case $tabletoupdate in
                +([a-zA-Z1-9_]*[a-zA-Z0-9_]))
                                    if [ -f ./databases/$DBname/$tabletoupdate ]
                                    then
                                    numberofrecordsupdate=`cat  ./databases/$DBname/$tabletoupdate | wc -l`
                                    declare -a colsnamesupdate=()
                                    declare -a datatypesupdate=()
                                    read numberoffieldsupdate <<< $(awk '{if(NR == 2)print NF}'  ./databases/$DBname/$tabletoupdate)
                                    for (( i=1;i<=$numberoffieldsupdate;i++ ));
                                    do
                                            colsnamesupdate[$i-1]=`sed -n '1p' ./databases/$DBname/$tabletoupdate | cut -d: -f$i`
                                    done
                                    for (( i=1;i<=$numberoffieldsupdate;i++ ));
                                    do
                                            datatypesupdate[$i-1]=`sed -n '2p' ./databases/$DBname/$tabletoupdate | cut -d: -f$i `            
                                    done
                                    
                                    if [[ $numberofrecordsupdate -lt 3 ]] 
                                    then
                                        clear
                                        echo "-------------------------------------------------------"
                                        echo "This table $tabletoupdate has no record to be updated"
                                        echo "-------------------------------------------------------"
                                    fi  
                                       
                                    if [ $numberofrecordsupdate -gt 2 ]
                                    then
                                    clear
                                        declare -a pkvaluesupdate=()
                                        for (( i=3;i<=$numberofrecordsupdate;i++ ));
                                        do
                                                pkvaluesupdate[$i-3]=`head -$i ./databases/$DBname/$tabletoupdate | tail -3 | cut -d: -f1`
                                        done
                                        typeset -i pkflagupdate=0
                                        while [[ $pkflagupdate -eq 0 ]]
                                        do
                                        echo "-----------------------------------------------------------------------"
                                        echo "Enter the ${colsnamesupdate[0]} primary key of the record to be updated"
                                        echo "The data type of Primary key is ${datatypesupdate[0]}"
                                        echo "Press - to go back"
                                        if [[ "${datatypesupdate[0]}" =~ "int" ]]
                                        then
                                        echo  " You may enter only numbers and you may not start with 0"
                                        echo "-----------------------------------------------------------------------"
                                        read prk
                                        case $prk in
                                            +([1-9]) | +([1-9]*[0-9]))
                                            if [[ " ${pkvaluesupdate[*]} " =~ "$prk " ]]
                                            then
                                            clear
                                            echo "------------------------------------------------------------------"
                                            head -$numberofrecordsupdate ./databases/$DBname/$tabletoupdate
                                            echo  "Enter the field number " 
                                            #echo  "You are not allowed to update the primary key"
                                            echo  "Enter - to go back" 
                                            echo "------------------------------------------------------------------"             
                                            read fieldnumnber 
                                            case  $fieldnumnber in 
                                             +([1-9]) | +([1-9]*[0-9]))
                                                if [ $fieldnumnber -gt $numberoffieldsupdate ]
                                                then
                                                        clear
                                                        echo "------------------------------------------------------------------"
                                                        echo "The number of field you entered does not exist"
                                                        echo "------------------------------------------------------------------"

                                                #elif [[ $fieldnumnber -eq 1 ]]
                                                #then 
                                                #        clear
                                                #        echo "------------------------------------------------------------------"
                                                #        echo "You are not allowed to update the primary key"
                                                #        echo "------------------------------------------------------------------"              
                                                #         let pkflagupdate++
                                                #         sleep 1
                                                else
                                                clear
                                                        declare -a fieldvalues=()
                                                         oldvalue=`cat ./databases/$DBname/$tabletoupdate | grep "^$prk :" | cut -d: -f$fieldnumnber`
                                                         echo "------------------------------------------------------------------"
                                                         echo "Enter the value to be added"
                                                        echo  "Enter - to go back"  
                                                        echo "------------------------------------------------------------------" 
                                                        read value
                                                
                                            if [[ " ${datatypesupdate[$fieldnumnber-1]} " =~ "int" ]]
                                            then
                                            case $value in
                                                         +([0-9]) | +([0-9]*[0-9]))
                                                         if  [[ $fieldnumnber -eq 1 ]]
                                                        then 
                                                            if [[ " ${pkvaluesupdate[*]} " =~ "$value " ]]
                                                            then
                                                            clear
                                                            echo "This primary key is already used"
                                                             else
                                                             clear
                                                             sed -i -e "/^$prk :/s/$oldvalue/$value /"  ./databases/$DBname/$tabletoupdate
                                                            let pkflagupdate++
                                                            echo "Updated Successfully"
                                                             sleep 1
                                                             
                                                            fi
                                                        else
                                                        sed -i -e "/^$prk :/s/$oldvalue/$value /"  ./databases/$DBname/$tabletoupdate
                                                        let pkflagupdate++
                                                        echo "Updated Successfully"
                                                        sleep 1
                                                        
                                                        fi
                                                          ;;
                                                        -)
                                                            clear
                                                            source ./update.sh
                                                            ;;
                                                        *)
                                                           clear
			                                                echo "-------------------------------------------------"
			                                                echo "----------ERROR----------------------------------"
			                                                echo "* Not a valid Input                             *"
			                                                echo "-------------------------------------------------" 
                                                        ;;
                                            esac
                                            else
                                            case $value in
                                                        +([a-zA-Z0-9]) | +([a-zA-Z0-9]*[a-zA-Z0-9_@.]))
                                                        if  [[ $fieldnumnber -eq 1 ]]
                                                        then 
                                                            
                                                            if [[ " ${pkvaluesupdate[*]} " =~ " $value " ]]
                                                            then
                                                            sed -i -e "/^$prk :/s/$oldvalue/$value /"  ./databases/$DBname/$tabletoupdate
                                                            let pkflagupdate++
                                                            echo "Updated Successfully"
                                                             sleep 1
                                                             else
                                                             echo "This primary key is already used"
                                                            fi
                                                        else
                                                        sed -i -e "/^$prk :/s/$oldvalue/$value /"  ./databases/$DBname/$tabletoupdate
                                                        let pkflagupdate++
                                                        echo "Updated Successfully"
                                                        sleep 1
                                                        
                                                        fi
                                                          ;;
                                                        -)
                                                            clear
                                                            source ./update.sh
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
                                            fi
                                            ;;
                                            -)
                                                clear
                                               source ./update.sh
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
                                                echo "-------------------------------------------------"
                                                echo "This primary key value $prk does not exist int"
                                                echo "-------------------------------------------------"
                                            fi
					                        ;;
                                        -) clear
                                           source ./update.sh
					                        ;;
                                        *)
                                           clear
		                                	echo "-------------------------------------------------"
		                                    echo "----------ERROR----------------------------------"
			                                echo "* Not a valid Input                             *"
			                                echo "-------------------------------------------------" 
                                           
                                           ;;
                                         esac
                                         else   
                                                
                                                echo "-------------------------------------------------"
                                                echo  " You may enter characters,numbers and only these three special .,@ and _ and Not at the beginning"
                                                echo "-------------------------------------------------"
                                        read prk
                                        case $prk in
                                            +([a-zA-Z]) | +([a-zA-Z0-9]*[a-zA-Z0-9_@.]))
                                            if [[ " ${pkvaluesupdate[*]} " =~ "$prk " ]]
                                            then
                                            clear
                                            echo "-------------------------------------------------"
                                            head -$numberofrecordsupdate ./databases/$DBname/$tabletoupdate
                                            echo  "Enter the field number " 
                                            #echo "You are not allowed to update the primary key"
                                            echo  "Enter - to go back"
                                            echo "-------------------------------------------------"               
                                            read fieldnumnber 
                                            case  $fieldnumnber in 
                                             +([1-9]) | +([1-9]*[0-9]))
                                             if [ $fieldnumnber -gt $numberoffieldsupdate ]
                                                then
                                                        clear
                                                        echo "------------------------------------------------------------------"
                                                        echo "The number of field you entered does not exist"
                                                        echo "------------------------------------------------------------------"

                                                #elif [[ $fieldnumnber -eq 1 ]]
                                                #then 
                                                #       clear
                                                #       echo "------------------------------------------------------------------"
                                                #        echo "You are not allowed to update the primary key"
                                                #        echo "------------------------------------------------------------------"              
                                                #         let pkflagupdate++
                                                #         sleep 1
                                                else
                                            declare -a fieldvalues=()
                                            oldvalue=`cat ./databases/$DBname/$tabletoupdate | grep "^$prk :" | cut -d: -f$fieldnumnber`
                                            clear
                                            echo "-------------------------------------------------"
                                            echo "Enter the value to be added"
                                            echo  "Enter - to go back"  
                                            echo "-------------------------------------------------" 
                                            read value
                                            if [[ " ${datatypesupdate[$fieldnumnber-1]} " =~ "int" ]]
                                            then
                                            case $value in
                                                         +([0-9]) | +([0-9]*[0-9]))
                                                            clear
                                                            if  [[ $fieldnumnber -eq 1 ]]
                                                        then 
                                                            if [[ " ${pkvaluesupdate[*]} " =~ "$value " ]]
                                                            then
                                                            clear
                                                            echo "This primary key is already used"
                                                             else
                                                             sed -i -e "/^$prk :/s/$oldvalue/$value /"  ./databases/$DBname/$tabletoupdate
                                                            let pkflagupdate++
                                                            echo "Updated Successfully"
                                                             sleep 1
                                                             
                                                            fi
                                                        else
                                                        sed -i -e "/^$prk :/s/$oldvalue/$value /"  ./databases/$DBname/$tabletoupdate
                                                        let pkflagupdate++
                                                        echo "Updated Successfully"
                                                        sleep 1
                                                        
                                                        fi
                                                          ;;
                                                        -)
                                                            clear
                                                            source ./update.sh
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
                                            case $value in
                                                        +([a-zA-Z0-9]) | +([a-zA-Z0-9]*[a-zA-Z0-9_@.]))
                                                        if  [[ $fieldnumnber -eq 1 ]]
                                                        then 
                                                            if [[ " ${pkvaluesupdate[*]} " =~ "$value " ]]
                                                            then
                                                            clear
                                                            echo "This primary key is already used"
                                                             else
                                                             sed -i -e "/^$prk :/s/$oldvalue/$value /"  ./databases/$DBname/$tabletoupdate
                                                            let pkflagupdate++
                                                            echo "Updated Successfully"
                                                             sleep 1
                                                             
                                                            fi
                                                        else
                                                        sed -i -e "/^$prk :/s/$oldvalue/$value /"  ./databases/$DBname/$tabletoupdate
                                                        let pkflagupdate++
                                                        echo "Updated Successfully"
                                                        sleep 1
                                                        
                                                        fi
                                                          ;;
                                                        -)
                                                            clear
                                                            source ./update.sh
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
                                            fi
                                            ;;
                                            -)
                                                clear
                                               source ./update.sh
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
                                                echo "-------------------------------------------------"
                                                echo "This primary key $prk does not exist string"
                                                echo "-------------------------------------------------"
                                            fi
					                        ;;
                                        -) clear
                                           source ./update.sh
					                        ;;
                                        *)
                                           clear
			                                echo "-------------------------------------------------"
			                                echo "----------ERROR----------------------------------"
			                                echo "* Not a valid Input                             *"
			                                echo "-------------------------------------------------" 
                                           
                                           ;;
                                         esac
                                         fi
                                         done
                                         fi
                                       
                                    else
                                        clear
                                        echo "-------------------------------------------------"
                                        echo "The $tabletoupdate table does not exist"
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
			                    echo "* Please make sure to choose one of the options *"
			                    echo "-------------------------------------------------" 
					    	;;
        esac
    done
fi