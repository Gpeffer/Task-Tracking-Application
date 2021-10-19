#! /bin/bash

# Variables
FILE="/home/garry/.todo/todo-list.md"
FILE1="/home/garry/.todo/todo-list-activity.md"

touch "/home/garry/.todo/todo-list.md"
touch "/home/garry/.todo/todo-list-activity.md"

# Functions
border()
{
    title="| $1 |"
    edge=$(echo "$title" | sed 's/./-/g')
    echo "$edge"
    echo "$title"
    echo "$edge"
}

display()
{
	sleep 1
	echo "Displaying entries..."
	sleep 1
	nl todo-list.md
	sleep 1
	echo ""
	echo "Do you want to..."
	sleep .1
	border "Make an entry (entry)?"
	sleep .1
	border "Copy an entry (copy)?"
	sleep .1
	border "Remove an entry (remove)?"
	sleep .1
	border "View activity (activity)?"
	sleep .1
	border "Reset list (reset)?"
	sleep .1
	border "Exit (exit)?"
	sleep .1
	echo "Input ↓↓↓"
}

display1()
{
	sleep 1
	echo "Displaying activity..."
	sleep 1
	nl todo-list-activity.md
	sleep 1
	echo ""
	echo "Do you want to..."
	sleep .1
	border "Make an entry (entry)?"
	sleep .1
	border "Copy an entry (copy)?"
	sleep .1
	border "Remove an entry (remove)?"
	sleep .1
	border "View activity (activity)?"
	sleep .1
	border "Reset list (reset)?"
	sleep .1
	border "Exit (exit)?"
	sleep .1
	echo "Input ↓↓↓"
}

# Start script

border "Welcome to your daily dose of organization."
echo ""
display

	until [[ "${answer}" = "exit" ]]
	do

		read answer

		if [[ "${answer}" = "entry" ]]
		then
			Current_time="$(date +%d-%b) @ $(date +%H:%M)"
			echo "Ready to append..."
			read append
			echo "${append} | created on "${Current_time}"" >> "${FILE}"
			echo "${append} | created on "${Current_time}"" >> "${FILE1}"
			echo "Entry added on "${Current_time}""
			display
		fi

		if [[ "${answer}" = "remove" ]]
		then
			Current_time="$(date +%d-%b) @ $(date +%H:%M)"
			echo "Select line to remove (1,2,3,etc.)."
			read remove
			sed -i "${remove}"'d' "${FILE}"
			echo "Line "${remove}" removed on "${Current_time}"."
			echo "Line "${remove}" removed on "${Current_time}"." >> "${FILE1}"
			display
		fi

		if [[ "${answer}" = "activity" ]]
		then
			display1	
		fi

		if [[ "${answer}" = "copy" ]]
		then
			Current_time="$(date +%d-%b) @ $(date +%H:%M)"
			echo "Which line do you want to copy?"
			read copy
			sed -n "${copy}"p "${FILE}" >> "${FILE}"
			echo "Line "${copy}" copied on "${Current_time}"."
			echo "Line "${copy}" copied on "${Current_time}"." >> "${FILE1}"
			display
		fi

		if [[ "${answer}" = "reset" ]]
		then
			Current_time="$(date +%d-%b) @ $(date +%H:%M)"
			rm todo-list.md
			touch todo-list.md
			echo "todo-list.md has been reset on "${Current_time}""
			echo "todo-list.md has been reset on "${Current_time}"" >> todo-list-activity.md
			display
		fi

	done

border "Goodbye"
