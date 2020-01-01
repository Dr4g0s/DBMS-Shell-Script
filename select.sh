#! /urs/bin/bash

function getColumns2
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

function selectTable
{
    select z in 'All data' 'Specific columns' 'Back'
    do
    path=$HOME/Bash/Databases/$db_name/$tb_name
    case $z in
        'All data')
            awk '{print NR"-", $0}' $path | column -t 
            ;;
        'Specific columns')
            typeset -a all_column=($(getColumns2))
            typeset -a all_values
            typeset -a all_indexes
            Backup_of_internal_field_separator=$IFS
            IFS=','
            echo "$(tput setaf 5)Hint \> 'name:1,age:2,.........'$(tput sgr0)"
            read -p "Enter columns name and it's numbers separated by ':' and ',' > " cName;
            for val in $cName
            do
                Backup_of_internal_field_separator=$IFS
                IFS=':'
                k=0
                for vv in $val
                do
                    if [ $k = 1 ]
                    then
                    echo "$(tput setaf 7)##################################################################$(tput sgr0)"
                    awk -v field="$vv" '{if(NR!=1){print NR"-", $field}}' $path
                    echo "$(tput setaf 7)##################################################################$(tput sgr0)"
                    fi
                    k=${k+1}
                done
            done
            ;;
        'Back')
            break;;
        *)
            echo "invalid input, try again."
            ;;
    esac
    done
}

selectTable