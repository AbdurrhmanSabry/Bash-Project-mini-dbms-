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
    read tabletoupdate
        case $tabletoselect in
                +([a-zA-Z1-9_]*[a-zA-Z0-9_]))
                                    if [ -f ./databases/$DBname/$tabletoupdate ]
                                    then
                                        echo "Enter the primary key to update , fieldName and the value"
                                        echo "Press 0 to go back"
                                        read prk fieldName filedValue
                                        case $prk in
                                        ^[1-9]\d*$)
                                            $awk -F: -v '{if(NR > 2){
                                                if($1 == $prk){
                                                    for( i=1 ; i<NF; i++ ) {
                                                        if($fieldName == `sed -n '1p' ./databases/$DBname/$tabletoupdate | cut -d: -f$i`){
                                                            $i=$filedValue;
                                                        }
                                                    }
                                            }}}' ./databases/$DBname/$tabletoupdate
					                        ;;
                                        0) clear
                                           source ./update.sh
					                        ;;
                                        *)
                                           echo "invalid input"
                                           source ./update.sh
                                    else
                                        echo "The $tabletoupdate table does not exist"
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