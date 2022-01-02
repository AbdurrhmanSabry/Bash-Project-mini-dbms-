#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
clear
if [ `find ./databases/$DBname -maxdepth 0 -empty` ]
then 
    echo "---------------------------------------------" 
    echo "The $DBname is empty no table to insert into"
    echo "---------------------------------------------" 
else
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
                +([a-zA-Z1-9_]*[a-zA-Z0-9_]))
                                    if [ -f ./databases/$DBname/$tabletoinsertinto ]
                                    then
                                        
                                        
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
					                    echo "---------------------------------------------"
                                        if [[ ${datatypesinsertasarray[0]} == "string" ]]
                                        then    
                                            read pk
                                                case $pk in
                                                    +([a-zA-Z1-9]*[a-zA-Z0-9@._]))
					                                                if [[ " ${valueofpksinsert[@]} " =~ " $pk " ]]
					                                                then 
                                                                    clear
					                                                echo "This primary key already exists"
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
                                                                echo "Not a valid option"
					                                     ;;
                                                esac
                                        else
                                            read pk
                                            case $pk in
                                                    +([1-9]*[0-9]))
					                                                if [[ " ${valueofpksinsert[@]} " =~ " $pk " ]]
					                                                then 
					                                                echo "This primary key already exists"
					                                                else
					                                                valuestoinsert[0]=$pk
					                                                let pkinsertflag++
					                                                fi
					                                     ;;
                                                    0)
					                                                source ./insert.sh
					                                     ;;
			                                        *)	                                                        
				                                    	            echo "Not a valid option"
					                                     ;;
                                                esac
                                        fi
                                        done
                                        #loop array i=3 i<=numberofrecords to catch one value at a time  
                                        #sed -n '$i' ./path | cut -d: -f1 redirct to an value to array to save the pk
                                        #awk -F: '{if(NR == 2)print $0}' ./databases/$DBname/$tabletoinsertinto
                                        #problem in capturing the the datatypes with awk
                                        #read value <<< $(awk -F: '{if(NR == 2)print $0}' ./databases/$DBname/$tabletoinsertinto)
                                        
                                        
                                       
                                        typeset -i valueinsetflag=0
                                        for (( i=1;i<numberoffields;i++ ));    
                                        do
                                        if [ $i -gt 1 ]
                                        then 
                                            let valueinsetflag--
                                        fi
                                        while [ $valueinsetflag -eq 0 ]
                                        do
                                        echo "enter the value of the ${namesofcolsinsert[$i]}"
					                    echo "${datatypesinsertasarray[$i]} is the data of the ${namesofcolsinsert[$i]}"
					                    echo "Press + if you want to skip this column"
                                        echo "To go back press - if you leave the record would be deleted"
					                    echo "---------------------------------------------"
                                        if [[ "${datatypesinsertasarray[$i]}" =~ "string" ]]
                                        then    
                                            read value
                                                case $value in
                                                    +([a-zA-Z0-9]*[a-zA-Z0-9@._]))
                                                                    clear
					                                                valuestoinsert[$i]=":$value"
					                                                let valueinsetflag++
					                                     ;;
                                                    -)              clear
					                                                source ./insert.sh
					                                     ;;
                                                    +)
                                                             valuestoinsert[$i]=":null"
					                                        let valueinsetflag++
                                                            ;;
			                                        *)	                                                        
				                                    	        echo "Not a valid option"
					                                     ;;
                                                esac
                                        else
                                            read value
                                            case $value in
                                                    +([0-9]))
					                                         valuestoinsert[$i]=":$value"
					                                         let valueinsetflag++
					                                            
					                                     ;;
                                                    -)
					                                         source ./insert.sh
					                                     ;;
                                                    +)
                                                            valuestoinsert[$i]=":null"
					                                        let valueinsetflag++
                                                        ;;
			                                        *)	                                                        
				                                    	            echo "Not a valid option"
					                                     ;;
                                                esac
                                        fi
                                        done
                                        done
                                        #sed -i "8 a ${values[*]}" ./databases/$DBname/$tabletoinsertinto
                                        #typeset -i numofrecord=`cat ./databases/$DBname/$tabletoinsertinto | wc -l`
                                        #echo ${values[*]} >> ./databases/$DBname/$tabletoinsertinto
                                        #awk -F: '{ if($1==133){$1=333330;print $0} }' ./databases/$DBname/$tabletoinsertinto

                                        echo ${valuestoinsert[*]}  >> ./databases/$DBname/$tabletoinsertinto
                                        sleep 10
                                        source ./insert.sh

                                    else
                                      echo "The $tabletoinsertinto table does not exist"
                                    fi
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