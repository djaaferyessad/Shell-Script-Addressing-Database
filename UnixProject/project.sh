
#!/bin/bash
# The file names
#TODO Define all file names used for this project
# The file paths
#TODO Define all file paths here
# The globals
#TODO Define all global variables required
# Time out periods
#TODO Define all timeout values here
wrong=1
firstloop=1
secondloop=1
directory="Database"
RED='\033[0;31m'
NC='\033[0m'
name=""
email=""
tel=""
mob=""
place=""
textarea=""
line=""
edited=0

function log()
{
#	TODO Write activities to log files along with timestamp, pass argument as a string
echo -e "\n $1 $2 \n" >> "$directory/database.log"

}

function menu_header()
{
	# TODO Just to print welcome menu presntation
  empty=$1
  echo -e "My Database Project\nPlease choose the below options :\n\n"
  echo "1. Add Entry"
  if [[ "$empty" != "empty" ]]; then
    echo "2. Search / Edit Entry"
  fi
  echo "x. Exit"
}

function field_menu()
{
    # TODO to print a selected user information 
    # Name, Email, Tel no, Mob num, Address, Message
    screen=$1
    echo -e "My Database Project\nPlease choose the below options :\n"
    if [[ "$screen" == "add" ]];then
    echo -e "Add New Entry Screen:\n"
    elif [[ "$screen" == "search" ]];then
    echo -e "${RED}Search ${NC}/ Edit by:"
    elif [[ "$screen" == "edit" ]];then
    echo -e "Search / ${RED}Edit${NC} by:"
  	fi
    echo -e ""
    echo -e "1: Name      : $2"
    echo -e "2: Email     : $3"
    echo -e "3: Tel No    : $4"
    echo -e "4: Mob No    : $5"
    echo -e "5: Place     : $6"
    echo -e "6: Message   : $7"
    if [[ "$screen" == "edit" ]];then
    echo -e "7: ${RED}Save${NC}      :"
  	fi
    echo -e "x: Exit\n"
}
function edit_operation()
{
	# TODO Provide an option to change fields of an entry
	# 1. Ask user about the field to edit
	# 2. As per user selection, prompt a message to enter respected value
	# 3. Verify the user entry to field for matching. Eg mob number only 10 digits to enter
   # 4. Prompt error in case any mismatch of entered data and fields	
   secondloop=1
   edited=0
   while(( secondloop != 0 ))
   do
   	field_menu "edit" "$name" "$email" "$tel" "$mob" "$place" "$textarea"
    read -p "Please choose your option : " choose 
    case $choose in 
    	1)
				read -p "Please enter the new Name : " reply
				validate_entry 1 reply
				if ((  wrong != 0 ));then
					name="$reply"
					edited=1
				fi
				;;
			2)
			read -p "Please enter the new Email : " reply
				validate_entry 1 reply
				if ((  wrong != 0 ));then
					email="$reply"
					edited=1
				fi
				;;
			3)
			read -p "Please enter the new Tel No : " reply
				validate_entry 1 reply
				if ((  wrong != 0 ));then
					tel="$reply"
					edited=1
				fi
				;;
			4)
			read -p "Please enter the new Mob No : " reply
				validate_entry 1 reply
				if ((  wrong != 0 ));then
					mob="$reply"
					edited=1
				fi
				;;
			5)
			read -p "Please enter the new Place : " reply
				validate_entry 1 reply
				if ((  wrong != 0 ));then
					place="$reply"
					edited=1
				fi
				;;
			6)
			read -p "Please enter the new Message : " reply
				validate_entry 1 reply
				if ((  wrong != 0 ));then
					textarea="$reply"
					edited=1
				fi
				;;
			7)
			
			search_and_edit 
			;;
			x)
				secondloop=0
				;;
			*)
		echo "Invalid option " 
		;;
		esac

		done






}

function search_operation()
{
	# TODO Ask user for a value to search
	# 1. Value can be from any field of an entry.
	# 2. One by one iterate through each line of database file and search for the entry
	# 3. If available display all fiels for that entry
	# 4. Prompt error incase not available
name=""
email=""
tel=""
mob=""
place=""
textarea=""
line=""


	read -p "Please chooes the field to be searched : " choose
	case $choose in 
		1) 
			read -p "Please enter the Name: " reply
			resault=$(grep "^1:$reply" "$directory/database.csv")
			numline=$(echo "$resault" | wc -l)
			num=1
			if (( numline > 1 ));then
				while (( num <= numline ))
				do
					line=$(echo "$resault" | sed -n "${num}p" )
					echo "[$num]"
					echo "$line"
					let num+=1
				done
				read -p "Select the user number to be displayed: " reply
				if (( "$reply" > numline &&   "$reply" < numline ));then
					echo "Invalid option . Try again "
				else
					line=$(echo "$resault" | sed -n "${reply}p")
					name=$(echo "$line" | grep -oP '1:\K\S+')
					email=$(echo "$line" | grep -oP '2:\K\S+')
					tel=$(echo "$line" | grep -oP '3:\K\S+')
					mob=$(echo "$line" | grep -oP '4:\K\S+')
					place=$(echo "$line" | grep -oP '5:\K\S+')
					textarea=$(echo "$line" | grep -oP '6:\K.+$')
					edit_operation
				fi
			fi
				content=$(echo "$resault" | wc -c)
			if (( content > 1 ));then
					name=$(echo "$resault" | grep -oP '1:\K\S+')
					email=$(echo "$resault" | grep -oP '2:\K\S+')
					tel=$(echo "$resault" | grep -oP '3:\K\S+')
					mob=$(echo "$resault" | grep -oP '4:\K\S+')
					place=$(echo "$resault" | grep -oP '5:\K\S+')
					textarea=$(echo "$resault" | grep -oP '6:\K.+$')
					edit_operation
				
			else
				echo -e " There is no such name \n" 
				search_operation
					
			fi
			;;
		2)
read -p "Please enter the Email: " reply
			resault=$(grep "2:$reply" "$directory/database.csv")
			numline=$(echo "$resault" | wc -l)
			num=1
			if (( numline > 1 ));then
				while (( num <= numline ))
				do
					line=$(echo "$resault" | sed -n "${num}p" )
					echo "[$num]"
					echo "$line"
					let num+=1
				done
				read -p "Select the user number to be displayed: " reply
				if (( "$reply" > numline &&   "$reply" < numline ));then
					echo "Invalid option . Try again "
				else
					line=$(echo "$resault" | sed -n "${reply}p")
					name=$(echo "$line" | grep -oP '1:\K\S+')
					email=$(echo "$line" | grep -oP '2:\K\S+')
					tel=$(echo "$line" | grep -oP '3:\K\S+')
					mob=$(echo "$line" | grep -oP '4:\K\S+')
					place=$(echo "$line" | grep -oP '5:\K\S+')
						textarea=$(echo "$line" | grep -oP '6:\K.+$')
					edit_operation
				fi
			fi
		content=$(echo "$resault" | wc -c)
			if (( content > 1 ));then
					name=$(echo "$resault" | grep -oP '1:\K\S+')
					email=$(echo "$resault" | grep -oP '2:\K\S+')
					tel=$(echo "$resault" | grep -oP '3:\K\S+')
					mob=$(echo "$resault" | grep -oP '4:\K\S+')
					place=$(echo "$resault" | grep -oP '5:\K\S+')
					textarea=$(echo "$resault" | grep -oP '6:\K.+$')
					edit_operation
				
			else
				echo -e " There is no such email \n"
				search_operation
			fi
				;;
			3)
			read -p "Please enter the Tel No: " reply
			resault=$(grep "3:$reply" "$directory/database.csv")
			numline=$(echo "$resault" | wc -l)
			num=1
			if (( numline > 1 ));then
				while (( num <= numline ))
				do
					line=$(echo "$resault" | sed -n "${num}p" )
					echo "[$num]"
					echo "$line"
					let num+=1
				done
				read -p "Select the user number to be displayed: " reply
				if (( "$reply" > numline &&   "$reply" < numline ));then
					echo "Invalid option . Try again "
				else
					line=$(echo "$resault" | sed -n "${reply}p")
					name=$(echo "$line" | grep -oP '1:\K\S+')
					email=$(echo "$line" | grep -oP '2:\K\S+')
					tel=$(echo "$line" | grep -oP '3:\K\S+')
					mob=$(echo "$line" | grep -oP '4:\K\S+')
					place=$(echo "$line" | grep -oP '5:\K\S+')
						textarea=$(echo "$line" | grep -oP '6:\K.+$')
					edit_operation
				fi
			fi
content=$(echo "$resault" | wc -c)
			if (( content > 1 ));then
					name=$(echo "$resault" | grep -oP '1:\K\S+')
					email=$(echo "$resault" | grep -oP '2:\K\S+')
					tel=$(echo "$resault" | grep -oP '3:\K\S+')
					mob=$(echo "$resault" | grep -oP '4:\K\S+')
					place=$(echo "$resault" | grep -oP '5:\K\S+')
						textarea=$(echo "$resault" | grep -oP '6:\K.+$')
					edit_operation
				
			else
				echo -e " There is no such Tel No\n"
				search_operation
				fi
			;;
			4)
read -p "Please enter the Mob No: " reply
			resault=$(grep "4:$reply" "$directory/database.csv")
			numline=$(echo "$resault" | wc -l)
			num=1
			if (( numline > 1 ));then
				while (( num <= numline ))
				do
					line=$(echo "$resault" | sed -n "${num}p" )
					echo "[$num]"
					echo "$line"
					let num+=1
				done
				read -p "Select the user number to be displayed: " reply
			if (( "$reply" > numline &&   "$reply" < numline ));then
				echo "Invalid option . Try again "
			else
					line=$(echo "$resault" | sed -n "${reply}p")
					name=$(echo "$line" | grep -oP '1:\K\S+')
					email=$(echo "$line" | grep -oP '2:\K\S+')
					tel=$(echo "$line" | grep -oP '3:\K\S+')
					mob=$(echo "$line" | grep -oP '4:\K\S+')
					place=$(echo "$line" | grep -oP '5:\K\S+')
						textarea=$(echo "$line" | grep -oP '6:\K.+$')
					edit_operation
				fi
		fi
content=$(echo "$resault" | wc -c)
			if (( content > 1 ));then
					name=$(echo "$resault" | grep -oP '1:\K\S+')
					email=$(echo "$resault" | grep -oP '2:\K\S+')
					tel=$(echo "$resault" | grep -oP '3:\K\S+')
					mob=$(echo "$resault" | grep -oP '4:\K\S+')
					place=$(echo "$resault" | grep -oP '5:\K\S+')
						textarea=$(echo "$resault" | grep -oP '6:\K.+$')
					edit_operation
				
			else
				echo -e " There is no such Mob No \n"
				search_operation
				fi
				;;
			5)
read -p "Please enter the Place: " reply
			resault=$(grep "5:$reply" "$directory/database.csv")
			numline=$(echo "$resault" | wc -l)
			num=1
			if (( numline > 1 ));then
				while (( num <= numline ))
				do
					line=$(echo "$resault" | sed -n "${num}p" )
					echo "[$num]"
					echo "$line"
					let num+=1
				done
				read -p "Select the user number to be displayed: " reply
				if (( "$reply" > numline &&   "$reply" < numline ));then
					echo "Invalid option . Try again "
				else
					line=$(echo "$resault" | sed -n "${reply}p")
					name=$(echo "$line" | grep -oP '1:\K\S+')
					email=$(echo "$line" | grep -oP '2:\K\S+')
					tel=$(echo "$line" | grep -oP '3:\K\S+')
					mob=$(echo "$line" | grep -oP '4:\K\S+')
					place=$(echo "$line" | grep -oP '5:\K\S+')
					textarea=$(echo "$line" | grep -oP '6:\K.+$')
					edit_operation
				fi
			fi
content=$(echo "$resault" | wc -c)
			if (( content > 1 ));then
				line=$(echo "$resault" | sed -n "${reply}p")
					name=$(echo "$resault" | grep -oP '1:\K\S+')
					email=$(echo "$resault" | grep -oP '2:\K\S+')
					tel=$(echo "$resault" | grep -oP '3:\K\S+')
					mob=$(echo "$resault" | grep -oP '4:\K\S+')
					place=$(echo "$resault" | grep -oP '5:\K\S+')
				textarea=$(echo "$resault" | grep -oP '6:\K.+$')
					edit_operation
			else
				echo -e " There is no such place \n"
				search_operation
				fi
				;;
			6)
read -p "Please enter the Message: " reply
			resault=$(grep "6:$reply" "$directory/database.csv")
			numline=$(echo "$resault" | wc -l)
			num=1
			if (( numline > 1 ));then
				while (( num <= numline ))
				do
					line=$(echo "$resault" | sed -n "${num}p" )
					echo "[$num]"
					echo "$line"
					let num+=1
				done
				read -p "Select the user number to be displayed: " reply
				if (( "$reply" > numline &&   "$reply" < numline ));then
					echo "Invalid option . Try again "
				else
					line=$(echo "$resault" | sed -n "${reply}p")
					name=$(echo "$line" | grep -oP '1:\K\S+')
					email=$(echo "$line" | grep -oP '2:\K\S+')
					tel=$(echo "$line" | grep -oP '3:\K\S+')
					mob=$(echo "$line" | grep -oP '4:\K\S+')
					place=$(echo "$line" | grep -oP '5:\K\S+')
					textarea=$(echo "$line" | grep -oP '6:\K.+$')
					edit_operation
				fi
		fi
			content=$(echo "$resault" | wc -c)
			if (( content > 1 ));then
					name=$(echo "$resault" | grep -oP '1:\K\S+')
					email=$(echo "$resault" | grep -oP '2:\K\S+')
					tel=$(echo "$resault" | grep -oP '3:\K\S+')
					mob=$(echo "$resault" | grep -oP '4:\K\S+')
					place=$(echo "$resault" | grep -oP '5:\K\S+')
						textarea=$(echo "$resault" | grep -oP '6:\K.+$')
				edit_operation
				
			else
				echo -e " There is no such message \n"
				search_operation
				fi
			;;
			x)
			;;
			*)
			echo -e "Invalid option \n"
			search_operation
			;;
			esac



}

function search_and_edit()
{
	# TODO UI for editing and searching 
	# 1. Show realtime changes while editing
	# 2. Call above functions respectively
	sed -i "/^$line/d" "$directory/database.csv"
	database_entry "$name" "$email" "$tel" "$mob" "$place" "$textarea"
}

function database_entry()
{
	# TODO user inputs will be written to the database file
	# 1. If some fields are missing, add consecutive ','. Eg: user,,,,,


	field1=$1
	field2=$2
	field3=$3
	field4=$4
	field5=$5
	field6=$6


	if [[ $field1 == "" ]]; then field1=","; fi
	if [[ $field2 == "" ]]; then field2=","; fi
	if [[ $field3 == "" ]]; then field3=","; fi
	if [[ $field4 == "" ]]; then field4=","; fi
	if [[ $field5 == "" ]]; then field5=","; fi
	if [[ $field6 == "" ]]; then field6=","; fi

	# Write to the database file
	echo -e "1:$field1 2:$field2 3:$field3 4:$field4 5:$field5 6:$field6\n" >> "$directory/database.csv"
}	

function validate_entry()
{
	# TODO Inputs entered by user must be verified and validated as per fields
	# 1. Names should have only alphabets
	# 2. Emails must have a @ symbols and ending with .<domain> Eg: user@mail.com
	# 3. Mobile/Tel numbers must have 10 digits .
	# 4. Place must have only alphabets
	message=$1 
	choser=$2
	wrong=1

	case $choser in
		1) 
			if [[ "$message" =~ ^[a-zA-Z]+$ ]];then
				field_menu 
			else
				echo "Wrong write it with correct format "
				wrong=0
			fi
			;;
		2)
			if [[ "$message" =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$ ]];then
				field_menu 
			else
				echo "Wrong write it with correct format "
				wrong=0
			fi
			;;
		3) 
			if [[ "$message" =~ ^[0-9]{10}$ ]];then
				field_menu 
			else
				echo "Wrong write it with correct format "
				wrong=0
			fi
			;;
		4)
			if [[ "$message" =~ ^[0-9]{10}$ ]];then
				field_menu 
			else
				echo "Wrong write it with correct format "
				wrong=0
			fi
			;;
		5) 
			if [[ "$message" =~ ^[a-zA-Z]+$ ]];then
				field_menu 
			else
				echo "Wrong write it with correct format "
				wrong=0
			fi
			;;
		esac

}

function add_entry()
{
	# TODO adding a new entry to database
	# 1. Validates the entries
	# 2. Add to database
	name=""
	email=""
	tel=""
	mob=""
	place=""
	textarea=""

	secondloop=1
	while(( secondloop != 0 ))
	do

	 field_menu "add" "$name" "$email" "$tel" "$mob" "$place" "$textarea"
	read -p "Please choose the field to be added: " answer

case $answer in
	1) 
	read -p "Please enter the Name: " reply
	validate_entry $reply 1
		if(( wrong != 0 ));then
			name=$reply
		fi
		;;
	2)
	read -p "Please enter the Email: " reply
	validate_entry $reply 2 
		if(( wrong != 0 ));then
			email=$reply
		fi
		;;
	3)
	read -p "Please enter the Tel No: " reply
	validate_entry $reply 3 
		if(( wrong != 0 ));then
			tel=$reply
		fi
		;;
	4)
	read -p "Please enter the Mob No: " reply
	validate_entry $reply 4
		if(( wrong != 0 ));then
			mob=$reply 
		fi
		;;
	5)
	read -p "Please enter the Place: " reply
	validate_entry $reply 5
		if(( wrong != 0 ));then
			place=$reply
		fi
		;;
	6)
	read -p "Please enter the Message: " reply
			textarea=$reply
	;;
	x)
		if [[ "$name" != "" || "$email" != "" || "$tel" != "" || "$mob" != "" || "$place" != "" || "$textarea" != "" ]];then
		database_entry "$name" "$email" "$tel" "$mob" "$place" "$textarea"
		fi	
		secondloop=0
		;;
	*)
		echo "Invalid option. Please choose a valid option."
		;;
	esac
	done
		
}

# TODO Your main scropt starts here 
# 1. Creating a database directory if it doesn't exist
# 2. Creating a database.csv file if it doesn't exist
# Just loop till user exits




if [ ! -d "$directory" ]; then
  mkdir "$directory"
  chmod +w "$directory"
fi


if [ ! -e "$directory/database.log" ]; then
  touch "$directory/database.log"
fi

if [ ! -e "$directory/database.csv" ]; then
  touch "$directory/database.csv"
fi

log "$(date)" "$(whoami)"

while (( firstloop != 0 ))
do
  if [ -s "$directory/database.csv" ]; then
    menu_header notempty
  else
    menu_header empty
  fi
  echo -e "\nNote: Script Exit Timeout is set \n"
  read -t 10 -p "Please choose your option: " answer
if [ -n "$answer" ]; then
  case $answer in
    1)
      field_menu "add"
      add_entry
      ;;
    2)
      field_menu "search"
      search_operation
      ;;
    x)
      firstloop=0  # Exit the loop
      ;;
    *)
      echo "Invalid option. Please choose a valid option."
      ;;
  esac
else
	firstloop=0
fi

done