#!/bin/bash

#variables
file="/home/garry/.todo/todo-listV2.md"
file1="/home/garry/.todo/todo-activityV2.md"

touch "${file}"
touch "${file1}"

#functions

border()
{
    title="| $1 |"
    edge=$(echo "$title" | sed 's/./-/g')
    echo "$edge"
    echo "$title"
    echo "$edge"
}

entries()
{
	if [[ $(nl "${file}" | wc -l) = "0" ]]
	then
		echo ""
		echo "No entries to display at this time."
		echo ""
		echo "Press enter to continue."
		read -r enter
		clear
	else
		echo ""
		echo "Displaying current entries..."
		sleep .5
		echo ""
		nl "${file}"
		echo ""
		echo "Press enter to continue"
		read -r enter
		clear
	fi
}

options()
{
	echo ""
	echo "What would you like to do?"
	border "Make an entry (entry)?"
	border "Delete an entry (delete)?"
	border "Copy an entry (copy)?"
	border "Reset list (reset)?"
	border "Search entries (search)?"
	border "View list (list)?"
	border "View activity (activity)?"
	border "Exit (exit)?"
	echo ""
	echo "Input ↓↓↓"
	read -r answer
	clear
}

#begin script
clear
echo ""
border "Welcome to your daily dose of organization!"
sleep 1
entries
until [[ "$answer" = "exit" ]]
do
	options
	if [[ "${answer}" = "entry" ]]
	then
		time="$(date +%d-%b) @ $(date +%H:%M)"
		today="$(date +%d-%b)"
		echo ""
		echo "Ready to append..."
		echo ""
		echo "Input ↓↓↓"
		read -r append
		clear
		echo ""
		echo "Do you want to add a due date (yes/no)?"
		echo ""
		echo "Input ↓↓↓"
		read -r add_due_date
		echo ""
		if [[ "${add_due_date}" = "yes" ]]
		then
			clear
			echo ""
			echo "When is this due (Day-Month)? Type (today) to automatically apply today's date."
			echo ""
			echo "Input ↓↓↓"
			read -r due_date
			if [[ "${due_date}" = "today" ]]
			then
				echo """${append}"" | created on ""${time}"" | due by ""${today}""" >> "${file}"
				echo "Added \"""${append}""\" | created on ""${time}"" | due by ""${today}""" >> "${file1}"
				clear
			else
				echo """${append}"" | created on ""${time}"" | due by ""${due_date}""" >> "${file}"
				echo "Added \"""${append}""\" | created on ""${time}"" | due by ""${due_date}""" >> "${file1}"
				clear
			fi
		else
			echo """${append}"" | created on ""${time}""" >> "${file}"
			echo """${append}"" | created on ""${time}""" >> "${file1}"
			clear
		fi
		entries
	fi
	if [[ "${answer}" = "delete" ]]
	then
		time="$(date +%d-%b) @ $(date +%H:%M)"
		clear
		if [[ $(nl "${file}" | wc -l) != "0" ]]
		then
			echo ""
			echo "Displaying entries..."
			sleep .5
			echo ""
			nl "${file}"
			echo ""
			echo "Which line would you like to delete (1,2,3,etc)?"
			echo ""
			echo "Input ↓↓↓"
			read -r delete
			clear
			echo ""
			sed -i "${delete}"'d' "${file}"
			echo "Line ""${delete}"" has been deleted."
			echo "Deleted line ""${delete}"" | on ""${time}""" >> "${file1}"
		else
			echo "No entries to display at this time."
		fi
		echo ""
		echo "Press enter to continue."
		read -r enter
		clear
		entries
	fi
	if [[ "${answer}" = "copy" ]]
	then
		time="$(date +%d-%b) @ $(date +%H:%M)"
		clear
		if [[ $(nl "${file}" | wc -l) != "0" ]]
		then
			echo ""
			echo "Displaying entries..."
			sleep .5
			echo ""
			nl "${file}"
			echo ""
			echo "Which line would you like to copy (1,2,3,etc)?"
			echo ""
			echo "Input ↓↓↓"
			read -r copy
			sed -n "${copy}"p "${file}" >> "${file}"
			echo "Line ""${copy}"" has been copied."
			echo "Copied line ""${copy}"" | on ""${time}""" >> "${file1}"
		else
			echo "No entries to display at this time."
			echo ""
			echo "Press enter to continue."
			read -r enter
		fi
		clear
		entries
	fi
	if [[ "${answer}" = "reset" ]]
	then
		time="$(date +%d-%b) @ $(date +%H:%M)"
		echo ""
		echo "Are you sure you want to erase all entries (yes/no)?"
		echo ""
		echo "Input ↓↓↓"
		read -r erase
		if [[ "${erase}" = "yes" ]]
		then
			if [[ $(nl "${file}" | wc -l) = "0" ]]
			then
				clear
				echo "There are no entries to remove."
				echo ""
				echo "Press enter to continue"
				read -r enter
			else
				clear
				rm "${file}"
				touch "${file}"
				echo ""
				echo "Your list has been reset."
				echo "Reset list | on ""${time}""" >> "${file1}"
				echo ""
				echo "Press enter to continue"
				read -r enter
			fi
		fi
		echo ""
		echo "Press enter to continue"
		read -r enter
		clear
	fi
	if [[ "${answer}" = "search" ]]
	then
		time="$(date +%d-%b) @ $(date +%H:%M)"
		echo ""
		echo "Enter keyword."
		echo ""
		echo "Input ↓↓↓"
		read -r keyword
		echo ""
		if [[ $(nl "${file}" | grep -i -c "${keyword}") = "0" ]]
		then
			clear
			echo ""
			echo "No entries returned."
		else
			clear
			echo ""
			echo "Displaying matching entries..."
			echo ""
			nl "${file}" | grep -i "${keyword}"
			echo "Searched for ""${keyword}"" | on ""${time}""" >> "${file1}"
		fi
		echo ""
		echo "Press enter to continue."
		read -r enter
		clear
	fi
	if [[ "${answer}" = "list" ]]
	then
		time="$(date +%d-%b) @ $(date +%H:%M)"
		clear
		echo ""
		if [[ $(nl "${file}" | wc -l) = "0" ]]
		then
			echo "No entries to display at this time."
		else
			echo "Listing all entries..."
			echo ""
			sleep .5
			nl "${file}"
			echo "Listed entries | on ""${time}""" >> "${file1}"
		fi
		echo ""
		echo "Press enter to continue."
		read -r enter
		clear
	fi
	if [[ "${answer}" = "activity" ]]
	then
		echo ""
		nl "${file1}"
		echo ""
		echo "Press enter to continue."
		read -r enter
		clear
	fi
#	if [[ "${answer}" = "move" ]]
#	then
#		time="$(date +%d-%b) @ $(date +%H:%M)"
#		local moveto="sed -n "${to}""
#		if [[ $(nl "${file}" | wc -l) = "0" ]]
#		then
#			clear
#			echo ""
#			echo "No entries to display at this time."
#			echo ""
#			echo "Press enter to continue."
#			read -r enter
#			clear
#			options
#		else
#			clear
#			echo ""
#			echo "Displaying all entries..."
#			sleep .5
#			echo ""
#			nl "${file}"
#			echo ""
#			echo "Which line would you like to move?"
#			echo ""
#			echo "Input ↓↓↓"
#			read -r move
#			clear
#			echo ""
#			echo "Which line would you like to move it to?"
#			echo ""
#			echo "Input ↓↓↓"
#			read -r to
#			sed -n "${move}"p "${file}" >> (sed -n "${to}" "${file}")
#			clear
#			echo ""
#			echo "Line "${move}" has been moved to line "${to}""
#			entries
#			clear
#			options
#		fi
#	fi
done
echo ""
border "Goodbye!"
echo ""
sleep 1
clear
