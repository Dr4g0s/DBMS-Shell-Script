#! /usr/bin/bash

function getColumns3
{
    typeset -a colNames
    path=$HOME/Bash/Databases/$db_name/$tb_name
    line=$(cat $path | awk '{if(NR==1){print $0}}')
    names=$(echo $line | sed -e 's/:String/ /g' -e 's/:Number/ /g')

    count=0
    for n in $names
    do
        colNames[$count]=$n
        count=$count+1
    done
    echo ${colNames[*]}
}

function tb_connect
{
    Backup_of_internal_field_separator=$IFS
    IFS=' '
    select y in 'List columns' 'Select' 'Insert' 'Delete' 'Back'
    do
        case $y in 
        'List columns')
            echo "$(tput setaf 7)##################################################################$(tput sgr0)"
            typeset -a all_col=($(getColumns3))
            for(( cl = 0;cl < ${#all_col[*]} ; cl++ ))
            do
                echo "$(tput setaf 7)$[cl+1]. ${all_col[$cl]}$(tput sgr0)" 
            done
            echo "$(tput setaf 7)##################################################################$(tput sgr0)"
            ;;
        'Select')
                . $HOME/Bash/select.sh
                ;;
        'Insert')
                . $HOME/Bash/insert.sh
                ;;
        'Delete')
                . $HOME/Bash/delete.sh
                ;;
        'Back')
            break;;
        *)
            echo "Invalid input, Try again!!"
        esac
    done    
}

tb_connect