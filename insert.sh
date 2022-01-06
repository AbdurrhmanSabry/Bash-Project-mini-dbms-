#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
clear
if [ `find ./databases/$DBname -maxdepth 0 -empty` ]
then 
    clear
    echo "---------------------------------------------" 
    echo "The $DBname is empty no table to insert into"
    echo "You need to create a table first"
    echo "---------------------------------------------" 
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
    read tabletoinsertinto
        case $tabletoinsertinto in
                +([a-zA-Z_]*[a-zA-Z0-9_]))
                                    if [ -f ./databases/$DBname/$tabletoinsertinto ]
                                    then
                                        clear
                                        declare -a datatypesinsertasarray=()
                                        declare -a namesofcolsinsert=()
                                        numberoffields=0   
                                        numberofrecords=`cat ./databases/$DBname/$tabletoinsertinto | wc -l`
                                        read numberoffields <<< $(awk -F: '{if(NR == 1)print NF}' ./databases/$DBname/$tabletoinsertinto) 
                                        for (( i=1;i<=$numberoffields;i++));
                                        do
                                            namesofcolsinsert[$i-1]=`sed -n '1p' ./databases/$DBname/$tabletoinsertinto | cut -d: -f$i`
                                            datatypesinsertasarray[$i-1]=`sed -n '2p' ./databases/$DBname/$tabletoinsertinto | cut -d: -f$i`
                                        done
                                        declare -a valuestoinsert=()
                                        typeset -i pkinsertflag=0
                                        declare -a valueofpksinsert=()
                                        
                                        for (( i=3;i<=$numberofrecords;i++ ));
                                        do
                                            valueofpksinsert[$i-3]=`head -$i ./databases/$DBname/$tabletoinsertinto | tail -1 |cut -d: -f1`
                                        done
                                        while [ $pkinsertflag -eq 0 ] 
                                        do
                                        sed -n '1p' ./databases/$DBname/$tabletoinsertinto
                                        sed -n '2p' ./databases/$DBname/$tabletoinsertinto
                                        echo "enter the value of the primary key ${namesofcolsinsert[0]}"
					                    echo "${datatypesinsertasarray[0]} is the data of the primary key"
					                    echo "To go back press 0 if you leave the record would be deleted"
					                    echo "-----------------------------------------------------------"
                                        if [[ "${datatypesinsertasarray[0]}" =~ "string" ]]
                                        then    
                                            read pk
                                                case $pk in
                                                   +([a-zA-Z]) | +([a-zA-Z1-9]*[a-zA-Z0-9@._]))
					                                                if [[ " ${valueofpksinsert[@]} " =~ " $pk " ]]
					                                                then 
                                                                    clear
                                                                    echo "---------------------------------------------" 
					                                                echo "* This primary key already exists           *"
                                                                    echo "---------------------------------------------" 
					                                                else
                                                                    clear
					                                                valuestoinsert[0]=$pk
					                                                let pkinsertflag++
					                                                fi
					                                     ;;
                                                    0)
					                                    clear
                                                        source ./insert.sh
					                                     ;;
			                                        *)	                                                        
				                                    	       clear
						                                        echo "-------------------------------------------------"
						                                        echo "----------ERROR----------------------------------"
						                                        echo "* Not a valid Input                             *"
						                                        echo "* Please make sure          that you entered the*"
						                                        echo "* correct input                                 *"
						                                        echo "-------------------------------------------------"
					                                     ;;
                                                esac
                                        else
                                            read pk
                                            case $pk in
                                                    +([1-9]) | +([1-9]*[0-9]))
					                                                if [[ " ${valueofpksinsert[@]} " =~ " $pk " ]]
					                                                then 
                                                                    clear
                                                                    echo "---------------------------------------------" 
					                                                echo "* This primary key already exists           *"
                                                                    echo "---------------------------------------------" 
					                                                else
                                                                    clear
					                                                valuestoinsert[0]=$pk
					                                                let pkinsertflag++
					                                                fi
					                                     ;;
                                                    0)
                                                                    clear
					                                                source ./insert.sh
					                                     ;;
			                                        *)	                                                        
				                                    	            clear
						                                            echo "-------------------------------------------------"
						                                            echo "----------ERROR----------------------------------"
						                                            echo "* Not a valid Input                             *"
						                                            echo "* Please make sure          that you entered the*"
						                                            echo "* correct input                                 *"
						                                            echo "-------------------------------------------------"
					                                     ;;
                                                esac
                                        fi
                                        done
                                        #loop array i=3 i<=numberofrecords to catch one value at a time  
                                        #sed -n '$i' ./path | cut -d: -f1 redirct to an value to array to save the pk
                                        #awk -F: '{if(NR == 2)print $0}' ./databases/$DBname/$tabletoinsertinto
                                        #problem in capturing the the datatypes with awk

                                        typeset -i valueinsetflag=0
                                        for (( i=1;i<numberoffields;i++ ));    
                                        do
                                        valuestoinsert[$i]=":null"
                                        if [[ $valueinsetflag -gt 0 ]]
                                        then
                                                    let valueinsetflag--
                                        fi
                                        while [ $valueinsetflag -eq 0 ]
                                        do
                            
                                        echo "enter the value of the ${namesofcolsinsert[$i]}"
					                    echo "${datatypesinsertasarray[$i]} is the data of the ${namesofcolsinsert[$i]}"
					                    echo "Press + if you want to skip this column"
                                        echo "To go back press - if you leave the rest of columns would be set to null"
					                    echo "--------------------------------------------------------------------------------"
                                        if [[ "${datatypesinsertasarray[$i]}" =~ "string" ]]
                                        then    
                                            read value
                                                case $value in
                                                  +([a-zA-Z0-9]) | +([a-zA-Z0-9]*[a-zA-Z0-9@._]))
                                                            clear
					                                        valuestoinsert[$i]=":$value"
					                                        let valueinsetflag++
					                                     ;;
                                                    -)              clear
					                                        let valueinsetflag+=1024
					                                     ;;
                                                    +)
                                                            clear
					                                        let valueinsetflag++
                                                            ;;
			                                        *)	                                                        
				                                    	clear
						                                echo "-------------------------------------------------"
						                                echo "----------ERROR----------------------------------"
						                                echo "* Not a valid Input                             *"
						                                echo "* Please make sure          that you entered the*"
						                                echo "* correct input                                 *"
						                                echo "-------------------------------------------------"
					                                     ;;
                                                esac
                                        else
                                            read value
                                            case $value in
                                                    +([0-9]) | +([0-9]*[0-9]))
                                                            clear
					                                         valuestoinsert[$i]=":$value"
					                                         let valueinsetflag++
					                                            
					                                     ;;
                                                    -)
					                                        clear
                                                            let valueinsetflag+=1024
					                                     ;;
                                                    +)
					                                        clear
                                                            let valueinsetflag++
                                                        ;;
			                                        *)	                                                        
				                                    	    clear
						                                    echo "-------------------------------------------------"
						                                    echo "----------ERROR----------------------------------"
						                                    echo "* Not a valid Input                             *"
						                                    echo "* Please make sure  that you entered the        *"
						                                    echo "* correct input                                 *"
						                                    echo "-------------------------------------------------"
					                                     ;;
                                                esac
                                        fi
                                        done
                                        done
                                        echo ${valuestoinsert[*]}  >> ./databases/$DBname/$tabletoinsertinto
                                        echo "-------------------------------------------------"
                                        echo "Record inserted successfully"
                                        echo "-------------------------------------------------"
                                        echo ${valuestoinsert[*]}
                                        sleep 2
                                        source ./insert.sh

                                    else
                                        clear
                                        echo "-------------------------------------------------"
                                        echo "The $tabletoinsertinto table does not exist"
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
						        echo "* Please make sure that you entered the         *"
						        echo "* correct input                                 *"
						        echo "-------------------------------------------------"
					    	;;
        esac
    done
fi
