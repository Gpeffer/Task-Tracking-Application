#! /bin/bash

# Variables
FILE="/home/garry/.todo/todo-list.md"
FILE1="/home/garry/.todo/todo-list-activity.md"

touch "${FILE}"
touch "${FILE1}"

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
	echo ""
	sleep .1
	echo "Displaying entries..."
	sleep 1
	nl "${FILE}"
		if [[ `nl "${FILE}" | wc -l` = "0" ]]
		then
			echo ""
			echo "No entries to display at this time."
		fi
	sleep .1
	echo ""
	echo "Do you want to..."
	sleep .5
	border "Make an entry (entry)?"
	sleep .1
	border "Remove an entry (remove)?"
	sleep .1
	border "Copy an entry (copy)?"
	sleep .1
	border "Reset list (reset)?"
	sleep .1
	border "Search list (search)?"
	sleep .1
	border "View list (list)?"
	sleep .1
	border "View activity (activity)?"
	sleep .1
	border "Exit (exit)?"
	sleep .1
	echo ""
	echo "Input ↓↓↓"
}

display1()
{
	echo ""
	sleep .1
	echo "Displaying activity..."
	sleep 1
	nl "${FILE1}"
		if [[ `nl "${FILE}" | wc -l` = "0" ]]
		then
			echo ""
			echo "No entries to display at this time."
		fi
	sleep .1
	echo ""
	echo "Do you want to..."
	sleep .5
	border "Make an entry (entry)?"
	sleep .1
	border "Remove an entry (remove)?"
	sleep .1
	border "Copy an entry (copy)?"
	sleep .1
	border "Reset list (reset)?"
	sleep .1
	border "Search list (search)?"
	sleep .1
	border "View list (list)?"
	sleep .1
	border "View activity (activity)?"
	sleep .1
	border "Exit (exit)?"
	sleep .1
	echo ""
	echo "Input ↓↓↓"
}

display2()
{
	sleep .1
	echo ""
	echo "Do you want to..."
	sleep .5
	border "Make an entry (entry)?"
	sleep .1
	border "Remove an entry (remove)?"
	sleep .1
	border "Copy an entry (copy)?"
	sleep .1
	border "Reset list (reset)?"
	sleep .1
	border "Search list (search)?"
	sleep .1
	border "View list (list)?"
	sleep .1
	border "View activity (activity)?"
	sleep .1
	border "Exit (exit)?"
	sleep .1
	echo ""
	echo "Input ↓↓↓"
}

# Start script

echo ""
border "Welcome to your daily dose of organization."
display

	until [[ "${answer}" = "exit" ]]
	do

		read answer

		if [[ "${answer}" = "entry" ]]
		then
			Current_time="$(date +%d-%b) @ $(date +%H:%M)"
			echo ""
			echo "Ready to append..."
			echo ""
			echo "Input ↓↓↓"
			read append
			echo ""
			sleep .1
			echo "Do you want to add a due date?"
			sleep .1
			border yes
			sleep .1
			border no
			sleep .1
			echo ""
			echo "Input ↓↓↓"
			read if_due_date
			echo ""

				if [[ "${if_due_date}" = "yes" ]]
				then
					sleep .1
					echo "When is this due (day-month)?"
					sleep .1
					echo ""
					echo "Input ↓↓↓"
					read due_date
					echo ""
					echo "${append} | created on "${Current_time}" | due by "${due_date}"" >> "${FILE}"
					echo "${append} | created on "${Current_time}" | due by "${due_date}"" >> "${FILE1}"
					sleep .5
					echo "Entry added on "${Current_time}""
					display
				else
					echo "${append} | created on "${Current_time}"" >> "${FILE}"
					echo "${append} | created on "${Current_time}"" >> "${FILE1}"
					sleep .5
					echo "Entry added on "${Current_time}""
					display
				fi
		fi

		if [[ "${answer}" = "remove" ]]
		then
			Current_time="$(date +%d-%b) @ $(date +%H:%M)"
			echo ""
			echo "Select line to remove (1,2,3,etc.)."
			echo ""
			echo "Input ↓↓↓"
			read remove
			echo ""
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
			echo ""
			echo "Which line do you want to copy?"
			echo ""
			nl "${FILE}"
			echo ""
			echo "Input ↓↓↓"
			read copy
			echo ""
			sed -n "${copy}"p "${FILE}" >> "${FILE}"
			echo "Line "${copy}" copied on "${Current_time}"."
			echo "Line "${copy}" copied on "${Current_time}"." >> "${FILE1}"
			display
		fi

		if [[ "${answer}" = "reset" ]]
		then
			Current_time="$(date +%d-%b) @ $(date +%H:%M)"
			echo ""
			rm "${FILE}"
			touch "${FILE}"
			echo "todo-list.md has been reset on "${Current_time}""
			echo "todo-list.md has been reset on "${Current_time}"" >> "${FILE1}"
			display2
		fi

		if [[ "${answer}" = "search" ]]
		then
			Current_time="$(date +%d-%b) @ $(date +%H:%M)"
			echo ""
			echo "Enter keyword."
			echo ""
			echo "Input ↓↓↓"
			read keyword
			nl "${FILE}" | grep "${keyword}"
			echo ""
			echo "Press 'enter' to continue"
			read enter
			display
		fi

		if [[ "${answer}" = "list" ]]
		then
			sleep .1
			nl "${FILE}"
				if [[ `nl "${FILE}" | wc -l` = 0 ]]
				then
					echo ""
					echo "No entries to display at this time."
				fi
			echo ""
			sleep .1
			echo "Press 'enter' to continue"
			read enter
			display2
		fi

	done

sleep .1
echo ""
border "Goodbye"
echo ""
sleep .1
