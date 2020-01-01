#! /urs/bin/bash

function getColumns
{
    typeset -a colName
    path=$HOME/Bash/Databases/$db_name/$tb_name
    line1=$(cat $path | awk '{if(NR==1){print $0}}')
    names1=$(echo $line1 | sed -e 's/:String/ /g' -e 's/:Number/ /g')

    count=0
    for n in $names1
    do
        colName[$count]=$n
        count=$count+1
    done
    echo ${colName[*]}
}

function insert
{
    select b in 'Insert data' 'Back'
    do
    case $b in
    'Insert data')
        typeset -a all_colum=($(getColumns))
        typeset -a colDat
        for (( jj = 0; jj < ${#all_colum[@]} ; jj++ ))
        do
            read -p "Enter value of column [ ${all_colum[$jj]} ] > " colInsert;
            colDat[$jj]=$colInsert             
        done
        path=$HOME/Bash/Databases/$db_name/$tb_name
        echo ${colDat[*]} >> $path
        echo "[*] Done [*]"
        ;;
    'Back')
        break;;
    esac
    done
    
    
}

insert