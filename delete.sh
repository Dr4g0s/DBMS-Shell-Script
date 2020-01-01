#! /urs/bin/bash

function getColumns4
{
    typeset -a colNames
    path=$HOME/Bash/Databases/$db_name/$tb_name
    line=$(cat $path | awk '{if(NR==2){print $0}}')
    names=$(echo $line | sed -e 's/:String/ /g' -e 's/:Number/ /g')

    count=0
    for n in $names
    do
        colNames[$count]=$n
        count=$count+1
    done
    echo ${colNames[*]}
}

function delete
{
    select ch in 'Delete column' 'Delete row' 'Back'
    do
    path=$HOME/Bash/Databases/$db_name/$tb_name
    case $ch in
    'Delete column')
        typeset -a all_colum=($(getColumns4))
        read -p "Enter column number \> " colm_num;
        if [ $colm_num -gt ${#all_colum[*]} ]
        then
            echo "Invalid, number of columns is ${#all_colum[*]} "
        else
            cat $path | awk -v colm_num="$colm_num" '{$colm_num="";print $0}' | column -t  > $path.old && mv $path.old $path
            echo "Column number [$colm_num] Deleted!!";
        fi
        ;;
    'Delete row')
        read -p "Enter row number \> " row_num;
        all_rows=`cat $path | wc -l 2>/tmp/x`
        if [ $row_num -gt 1 -a $row_num -le $all_rows ]
        then
        cat $path | awk -v row_num="$row_num" '{if(NR!=row_num){print $0}}' | column -t  > $path.old && mv $path.old $path;
        echo "Row number [$row_num] Deleted!!";
        else
            echo "Not allowed, number of rows is $all_rows , rows start from 2"
        fi
        ;;
    'Back')
        break;;
    esac
    done
}

delete