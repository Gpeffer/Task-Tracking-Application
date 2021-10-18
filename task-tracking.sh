#! /bin/bash

FILE="/home/garry/.todo/todo-list.md"

touch "/home/garry/.todo/todo-list.md"
touch "/home/garry/.todo/todo-list-activity.md"

echo "Welcome to your daily dose of organization."
sleep .5
echo "Displaying entries..."
sleep .5
nl todo-list.md
echo "Do you have an entry (yes/no) OR do you want to remove an entry (remove) OR do you want to view activity (activity)?"

	until [[ "${answer}" = "no" ]]
	do

		read answer

		if [[ "${answer}" = "yes" ]]
		then
			Current_time="$(date +%d-%b) @ $(date +%H:%M)"
			echo "Ready to append..."
			read append
			echo "${append} | created on "${Current_time}"" >> /home/garry/.todo/todo-list.md
			echo "${append} | created on "${Current_time}"" >> /home/garry/.todo/todo-list-activity.md
			echo "Entry added on "${Current_time}""
			echo "Displaying entries..."
			sleep .5
			nl todo-list.md
			echo "Do you have another entry (yes/no) OR do you want to remove an entry (remove) OR do you want to view activity (activity)?"
		fi

		if [[ "${answer}" = "remove" ]]
		then
			Current_time="$(date +%d-%b) @ $(date +%H:%M)"
			echo "Select line to remove (1,2,3,etc.)."
			read remove
			sed -i "${remove}"'d' "${FILE}"
			echo "Line "${remove}" removed on "${Current_time}"."
			echo "Line "${remove}" removed on "${Current_time}"." >> /home/garry/.todo/todo-list-activity.md
			echo "Displaying entries..."
			sleep .5
			nl todo-list.md
			echo "Do you have another entry (yes/no) OR do you want to remove an entry (remove) OR do you want to view activity (activity)?"
		fi

		if [[ "${answer}" = "activity" ]]
		then
			echo "Displaying activity..."
			sleep .5
			nl todo-list-activity.md
			sleep .5
			echo "Do you have another entry (yes/no) OR do you want to remove an entry (remove)"
		fi

	done
