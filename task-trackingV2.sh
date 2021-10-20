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
	echo ""
	echo "Displaying current entries..."
	sleep .5
	echo ""
	if [[ `nl "${file}" | wc -l` = "0" ]]
	then
		echo "No entries to display at this time."
		sleep .5
	else
		nl "${file}"
		sleep 1
	fi
}

options()
{
	echo ""
	echo "What would you like to do?"
	sleep 1
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

echo ""
border "Welcome to your daily dose of organization!"
sleep 1
entries
options
until [[ "${answer}" = "exit" ]]
do
	read answer
	if [[ "${answer}" = "entry" ]]
	then
		time="$(date +%d-%b) @ $(date +%H:%M)"
		echo ""
		echo "Ready to append..."
		echo ""
		echo "Input ↓↓↓"
		read append
		echo ""
		echo "Do you want to add a due date (yes/no)?"
		echo ""
		echo "Input ↓↓↓"
		read add_due_date
		echo ""
		if [[ "${add_due_date}" = "yes" ]]
		then
			echo "When is this due (Day-Month)?"
			echo ""
			echo "Input ↓↓↓"
			read due_date
			echo ""${append}" | created on "${time}" | due by "${due_date}"" >> "${file}"
			echo "Added \""${append}"\" | created on "${time}" | due by "${due_date}"" >> "${file1}"
		else
			echo ""${append}" | created on "${time}"" >> "${file}"
			echo ""${append}" | created on "${time}"" >> "${file1}"
		fi
		entries
		options
	fi
	if [[ "${answer}" = "delete" ]]
	then
		time="$(date +%d-%b) @ $(date +%H:%M)"
		echo ""
		echo "Which line would you like to delete (1,2,3,etc)?"
		echo ""
		echo "Input ↓↓↓"
		read delete
		sed -i "${delete}"'d' "${file}"
		echo "Line "${delete}" has been deleted."
		echo "Deleted line "${delete}" | on "${time}"" >> "${file1}"
		entries
		options
	fi
	if [[ "${answer}" = "copy" ]]
	then
		time="$(date +%d-%b) @ $(date +%H:%M)"
		echo ""
		echo "Which line would you like to copy (1,2,3,etc)?"
		echo ""
		echo "Input ↓↓↓"
		read copy
		sed -n "${copy}"p "${file}" >> "${file}"
		echo "Line "${copy}" has been copied."
		echo "Copied line "${copy}" | on "${time}"" >> "${file1}"
		entries
		options
	fi
	if [[ "${answer}" = "reset" ]]
	then
		time="$(date +%d-%b) @ $(date +%H:%M)"
		echo ""
		rm "${file}"
		touch "${file}"
		echo "Your list has been reset."
		echo "Reset list | on "${time}"" >> "${file1}"
		echo ""
		echo "Press enter to continue"
		read enter
		entries
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
		nl "${file}" | grep "${keyword}"
		echo "Searched for "${keyword}" | on "${time}"" >> "${file1}"
		echo ""
		echo "Press enter to continue."
		read enter
		options
	fi
	if [[ "${answer}" = "list" ]]
	then
		time="$(date +%d-%b) @ $(date +%H:%M)"
		echo ""
		nl "${file}"
		echo "Listed entries | on "${time}"" >> "${file1}"
		echo ""
		echo "Press enter to continue."
		read enter
		options
	fi
	if [[ "${answer}" = "activity" ]]
	then
		echo ""
		nl "${file1}"
		echo ""
		echo "Press enter to continue."
		read enter
		entries
		options
	fi
done
echo ""
border "Goodbye!"
echo ""
