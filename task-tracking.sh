#! /bin/bash

FILE="/home/garry/.todo/todo-list.md"

if [[ -f todo-list.md=true ]]
	echo "Welcome to your daily dose of organization. Your list has been found."
then
	echo "Displaying entries..."
	sleep 1
	nl todo-list.md
	echo "Do you have an entry (yes/no) OR do you want to remove an entry (remove)?"
		until [[ "${answer}" = "no" ]]
		do
		read answer

			if [[ "${answer}" = "yes" ]]
				then
					echo "Ready to append..."
					read append
					echo "${append}" >> todo-list.md
					echo "Displaying entries..."
					sleep 1
					nl todo-list.md
					echo "Do you have another entry (yes/no) OR do you want to remove an entry (remove)?"
			fi

			if [[ "${answer}" = "remove" ]]
				then
					echo "Select line to remove (1,2,3,etc.)."
					read remove
					sed -i "${remove}"'d' "${FILE}"
					echo "Line "${remove}" removed."
					echo "Displaying entries..."
					sleep 1
					nl todo-list.md
					echo "Do you have another entry (yes/no) OR do you want to remove an entry (remove)?"
			fi

		done

fi
