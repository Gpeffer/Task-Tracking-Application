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
	if [[ `nl "${file}" | wc -l` = "0" ]]
	then
		echo ""
		echo "No entries to display at this time."
		sleep .1
		echo ""
		echo "Press enter to continue."
		read enter
		clear
	else
		echo ""
		echo "Displaying current entries..."
		sleep .5
		echo ""
		nl "${file}"
		sleep .1
		echo ""
		echo "Press enter to continue"
		read enter
		clear
	fi
}

options()
{
	echo ""
	echo "What would you like to do?"
	sleep .1
	border "Make an entry (entry)?"
	sleep .1
	border "Delete an entry (delete)?"
	sleep .1
	border "Copy an entry (copy)?"
	sleep .1
	border "Reset list (reset)?"
	sleep .1
	border "Search entries (search)?"
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

#begin script
clear
echo ""
border "Welcome to your daily dose of organization!"
sleep 1
entries
options
until [[ "$answer" = "exit" ]]
do
	read answer
	clear
	if [[ "${answer}" = "entry" ]]
	then
		time="$(date +%d-%b) @ $(date +%H:%M)"
		today="$(date +%d-%b)"
		echo ""
		echo "Ready to append..."
		echo ""
		echo "Input ↓↓↓"
		read append
		clear
		echo ""
		echo "Do you want to add a due date (yes/no)?"
		echo ""
		echo "Input ↓↓↓"
		read add_due_date
		echo ""
		if [[ "${add_due_date}" = "yes" ]]
		then
			clear
			echo ""
			echo "When is this due (Day-Month)? Type (today) to automatically apply today's date."
			echo ""
			echo "Input ↓↓↓"
			read due_date
			if [[ "${due_date}" = "today" ]]
			then
				echo ""${append}" | created on "${time}" | due by "${today}"" >> "${file}"
				echo "Added \""${append}"\" | created on "${time}" | due by "${today}"" >> "${file1}"
				clear
			else
				echo ""${append}" | created on "${time}" | due by "${due_date}"" >> "${file}"
				echo "Added \""${append}"\" | created on "${time}" | due by "${due_date}"" >> "${file1}"
				clear
			fi
		else
			echo ""${append}" | created on "${time}"" >> "${file}"
			echo ""${append}" | created on "${time}"" >> "${file1}"
			clear
		fi
		entries
		options
	fi
	if [[ "${answer}" = "delete" ]]
	then
		time="$(date +%d-%b) @ $(date +%H:%M)"
		clear
		if [[ `nl "${file}" | wc -l` != "0" ]]
		then
			echo ""
			echo "Displaying entries..."
			sleep .5
			echo ""
			nl "${file}"
			echo ""
			sleep .1
			echo "Which line would you like to delete (1,2,3,etc)?"
			echo ""
			echo "Input ↓↓↓"
			read delete
			sed -i "${delete}"'d' "${file}"
			echo "Line "${delete}" has been deleted."
			echo "Deleted line "${delete}" | on "${time}"" >> "${file1}"
			clear
			entries
			options
		else
			echo "No entries to display at this time."
			echo ""
			echo "Press enter to continue."
			read enter
			clear
			entries
			options
		fi
	fi
	if [[ "${answer}" = "copy" ]]
	then
		time="$(date +%d-%b) @ $(date +%H:%M)"
		clear
		if [[ `nl "${file}" | wc -l` != "0" ]]
		then
			echo ""
			echo "Displaying entries..."
			sleep .5
			echo ""
			nl "${file}"
			echo ""
			sleep .1
			echo "Which line would you like to copy (1,2,3,etc)?"
			echo ""
			echo "Input ↓↓↓"
			read copy
			sed -n "${copy}"p "${file}" >> "${file}"
			echo "Line "${copy}" has been copied."
			echo "Copied line "${copy}" | on "${time}"" >> "${file1}"
			clear
			entries
			options
		else
			echo "No entries to display at this time."
			echo ""
			echo "Press enter to continue."
			read enter
			clear
			entries
			options
		fi
	fi
	if [[ "${answer}" = "reset" ]]
	then
		time="$(date +%d-%b) @ $(date +%H:%M)"
		echo ""
		echo "Are you sure you want to erase all entries (yes/no)?"
		echo ""
		echo "Input ↓↓↓"
		read erase
		if [[ "${erase}" = "yes" ]]
		then
			if [[ `nl "${file}" | wc -l` = "0" ]]
			then
				clear
				echo "There are no entries to remove."
				echo ""
				echo "Press enter to continue"
				read enter
			else
				clear
				rm "${file}"
				touch "${file}"
				echo ""
				echo "Your list has been reset."
				echo "Reset list | on "${time}"" >> "${file1}"
				echo ""
				echo "Press enter to continue"
				read enter
			fi
		fi
		clear
		options
	fi
	if [[ "${answer}" = "search" ]]
	then
		time="$(date +%d-%b) @ $(date +%H:%M)"
		echo ""
		echo "Enter keyword."
		echo ""
		echo "Input ↓↓↓"
		read keyword
		echo ""
		if [[ `nl "${file}" | grep -i "${keyword}" | wc -l` = "0" ]]
		then
			clear
			echo "No entries returned."
			echo ""
			echo "Press enter to continue."
			read enter
			clear
			options
		else
			clear
			echo "Displaying matching entries..."
			echo ""
			nl "${file}" | grep -i "${keyword}"
			echo "Searched for "${keyword}" | on "${time}"" >> "${file1}"
			echo ""
			echo "Press enter to continue."
			read enter
			clear
			options
		fi
	fi
	if [[ "${answer}" = "list" ]]
	then
		time="$(date +%d-%b) @ $(date +%H:%M)"
		if [[ `nl "${file}" | wc -l` = "0" ]]
		then
			clear
			echo ""
			echo "No entries to display at this time."
			echo ""
			echo "Press enter to continue."
			read enter
			clear
			options
		else
			clear
			echo ""
			echo "Listing all entries..."
			echo ""
			sleep .5
			nl "${file}"
			sleep .1
			echo "Listed entries | on "${time}"" >> "${file1}"
			echo ""
			echo "Press enter to continue."
			read enter
			clear
			options
		fi
	fi
	if [[ "${answer}" = "activity" ]]
	then
		echo ""
		nl "${file1}"
		echo ""
		echo "Press enter to continue."
		read enter
		clear
		entries
		options
	fi
	if [[ "${answer}" = $1 ]]
	then
		echo "Invald input"
		options
	fi
done
echo ""
border "Goodbye!"
echo ""
sleep 1
clear
