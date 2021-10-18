#! /bin/bash

FILE="/home/garry/.todo/todo-list.md"
FILE1="/home/garry/.todo/todo-list-activity.md"

touch "/home/garry/.todo/todo-list.md"
touch "/home/garry/.todo/todo-list-activity.md"

echo "Welcome to your daily dose of organization."
sleep .5
echo "Displaying entries..."
sleep .5
nl todo-list.md
echo "Do you want to make an entry (yes/no) OR copy an entry (copy) OR remove an entry (remove) OR view activity (activity)?"

	until [[ "${answer}" = "no" ]]
	do

		read answer

		if [[ "${answer}" = "yes" ]]
		then
			Current_time="$(date +%d-%b) @ $(date +%H:%M)"
			echo "Ready to append..."
			read append
			echo "${append} | created on "${Current_time}"" >> "${FILE}"
			echo "${append} | created on "${Current_time}"" >> "${FILE1}"
			echo "Entry added on "${Current_time}""
			echo "Displaying entries..."
			sleep .5
			nl todo-list.md
			echo "Do you want to make another entry (yes/no) OR copy an entry (copy) OR remove an entry (remove) OR view activity (activity)?"
		fi

		if [[ "${answer}" = "remove" ]]
		then
			Current_time="$(date +%d-%b) @ $(date +%H:%M)"
			echo "Select line to remove (1,2,3,etc.)."
			read remove
			sed -i "${remove}"'d' "${FILE}"
			echo "Line "${remove}" removed on "${Current_time}"."
			echo "Line "${remove}" removed on "${Current_time}"." >> "${FILE1}"
			echo "Displaying entries..."
			sleep .5
			nl todo-list.md
			echo "Do you want to make another entry (yes/no) OR copy an entry (copy) OR remove an entry (remove) OR view activity (activity)?"
		fi

		if [[ "${answer}" = "activity" ]]
		then
			echo "Displaying activity..."
			sleep .5
			nl todo-list-activity.md
			sleep .5
			echo "Do you want to make another entry (yes/no) OR copy an entry OR remove an entry (remove)"
		fi

		if [[ "${answer}" = "copy" ]]
		then
			Current_time="$(date +%d-%b) @ $(date +%H:%M)"
			echo "Which line do you want to copy?"
			read copy
			sed -n "${copy}"p "${FILE}" >> "${FILE}"
			echo "Line "${copy}" copied on "${Current_time}"."
			echo "Line "${copy}" copied on "${Current_time}"." >> "${FILE1}"
			echo "Displaying entries..."
			sleep .5
			nl todo-list.md
			echo "Do you want to make another entry (yes/no) OR copy an entry (copy) OR remove an entry (remove) OR view activity (activity)?"
		fi

	done
