#! /usr/bin/bash


PS3="DBMS > ";

select choice in 'List Databases' 'Connect to Database' 'Create Database' 'Drop Database' 'Exit'
do
    mkdir $HOME/Bash/Databases 2>/tmp/x
    case $choice in
    'List Databases')
    	ls $HOME/Bash/Databases/
        ;;
    'Connect to Database')
    	echo "Enter Databse name \: "
        read db_name
    	if ` ls $HOME/Bash/Databases/$db_name/ 2>/tmp/x 1>/tmp/x `
    	then
            cd $HOME/Bash/Databases/$db_name/
    		echo "$db_name connected!!"
    		PS3="DBMS ($db_name) > "
            . $HOME/Bash/db_connect.sh
    	else
    		echo "$db_name not exist!!"
    	fi
    	;;
    'Create Database')
    	echo "Enter Database name \: "
        read db_create
    	if ` mkdir $HOME/Bash/Databases/$db_create 2>/tmp/x 1>/tmp/x | tr [A-Z] [a-z] `
    	then
    		echo "$db_create Created!!"
    	else
    		echo "Database already exist!!"
    	fi
    	;;
    'Drop Database')
    	echo "Enter Database name \: "
        read db_drop
        if [ $db_drop = "" 1>/tmp/x 2>/tmp/x ]
        then
            echo "invalid input, try again!"
        else
            if ` rm -r $HOME/Bash/Databases/$db_drop 1>/tmp/x 2>/tmp/x`
        	then
        		echo "$db_drop Dropped!!"
        	else
        		echo "Database not exist!!"
        	fi
        fi
    	;;
    'Exit')
    	echo "Thanks for using our project!!"
    	break;;
    *)
    	echo "Invalid input, Try again!!";;
    esac
done
