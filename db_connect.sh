#! /usr/bin/bash

function db_connect
{
	select x in 'List tables' 'Connect to table'  'Create table' 'Drop table' 'Back'
	do
		case $x in
		'List tables')
			if ` ls $HOME/Bash/Databases/$db_name/ 1>/tmp/x 2>/tmp/x `
			then
				ls $HOME/Bash/Databases/$db_name/
			else
				echo "No database yet, Try to create one!!"
			fi
			;;
		'Connect to table')
			echo "Enter table name \> "
			read tb_name
			if ` ls $HOME/Bash/Databases/$db_name/$tb_name 2>/tmp/x 1>/tmp/x `
    		then
            		echo "$tb_name connected!!"
            		PS3="DBMS ($db_name>$tb_name) > "
                . $HOME/Bash/tb_connect.sh
    		else
            		echo "$tb_name not exist!!"
    		fi
			;;
		'Create table')
			echo "Enter table name \> "
			read tb_create
            path=$HOME/Bash/Databases/$db_name/$tb_create
			if ` touch $HOME/Bash/Databases/$db_name/$tb_create | tr [A-Z] [a-z] `
            then
                echo "Enter number of columns \> "
                read column_num
                typeset -a all_columns[$column_num]
                for (( i = 0; i < column_num ; i++ ))
                do
                    read -p "Enter name of column number $[i+1] : " ColName
                    echo "Enter data type of column $ColName : "
                    select Type in String Number
                    do
                        case $Type in
                        'String')
                            all_columns[$i]=$ColName":"$Type;
                            echo -n ${all_columns[$i]}" " >> $path;
                            break;
                            ;;
                        'Number')
                            all_columns[$i]=$ColName":"$Type;
                            echo -n ${all_columns[$i]}" " >> $path;
                            break;
                            ;;
                        *)
                            echo "You must choose data type."
                            ;;
                        esac
                    done                
                done
                echo -n -e '\n' >> $path;
            else
                echo "Table already exist."
            fi
            

			echo "$tb_create created!!"
			;;
		'Drop table')
			echo "Enter table name \> "
			read tb_drop
			if ` rm $HOME/Bash/Databases/$db_name/$tb_drop 1>/tmp/x 2>/tmp/x `
        		then
                		echo "$tb_drop Deleted!!"
        		else
                		echo "Table not exist!!"
        		fi
			;;
		'Back')
			break;;
        *)
            echo "invalid input, try again"
            ;;
        esac
	done
}

db_connect